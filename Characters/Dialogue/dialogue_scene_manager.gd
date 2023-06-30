extends Control

@export var dialogue_timer: float

var npc_dialogue: Dialogue

var dialogue_participants = {
	"player": load("res://Assets/Dialogue Icons/icon_player.svg")
}

func _ready():
	# gamevent bus verbinden
	EventHandler.connect("dialogue_started_event", _start_dialogue)
	EventHandler.connect("dialogue_ended_event", _end_dialogue)

func _start_dialogue(npc_dialogue:Dialogue):
	self.npc_dialogue = npc_dialogue
	EventHandler.emit_signal("set_player_movement", false)
	_instantiate_dialogue_options(self.npc_dialogue)
	get_parent().show()
	
func _end_dialogue():
	EventHandler.emit_signal("set_player_movement", true)
	_reset_dialogue_options()
	get_parent().hide()

# TODO: hier den dialog abspielen
func _run_dialogue(talk_option:Dictionary, npc_name:String):
	var timeout = talk_option.get("timer")
	var player_option = talk_option.get("option_text")
	var ends_dialogue = talk_option.get("ends_dialogue")
	var goto_next = talk_option.get("goto_next")
	
	# counter to track the array position
	var npc_counter = 0
	var player_counter = 0
	
	_set_container_visibility(false)
	
	# einmal spieler gewählte option abspielen
	_set_talking(dialogue_participants["player"], "player (placeholder)", player_option)
	await get_tree().create_timer(timeout).timeout
	
	for talking in talk_option.get("is_talking"):
		_set_talking(dialogue_participants[talking], 
				npc_name if talking == "npc" else "Player",
				talk_option.get(talking)[npc_counter]\
				if talking == "npc" else\
				talk_option.get(talking)[player_counter])
		if talking == "npc": npc_counter += 1
		if talking == "player": player_counter += 1
		await get_tree().create_timer(timeout).timeout
		
	if goto_next:
		_reset_dialogue_options()
		_instantiate_dialogue_options(self.npc_dialogue, goto_next)
		await get_tree().create_timer(1).timeout # kurz warten damit zeit is den dialog zu laden
	
	_set_container_visibility(true)
	
	if ends_dialogue: EventHandler.emit_signal("dialogue_ended_event")

# TODO: dialogoptionen hier instanziieren
func _instantiate_dialogue_options(dia:Dialogue, dialogue_key = null):
	var num = 1
	var current_id = dia.dialogue.keys()[0] 
	var current_dialogue = dia.dialogue.get(current_id) as DialogueOption\
						if dialogue_key == null else dia.dialogue.get(dialogue_key)
	
	var welcome = current_dialogue.welcome
	var npc_name = current_dialogue.npc_name
	
	dialogue_participants["npc"] = dia.avatar_texture
	
	for opt in current_dialogue.options:
		var dia_opt = ResourceLoader.load("res://Characters/Dialogue/dialogue_option.tscn")
		var new_dia_opt = dia_opt.instantiate() as DialogueOptionContainer
		
		new_dia_opt.talk_option = opt
		new_dia_opt.number = num
		new_dia_opt.npc_name = npc_name
		new_dia_opt.selected_option.connect(_run_dialogue)
		$ScrollContainer/AspectRatioContainer/VBoxContainer.add_child(new_dia_opt)
		num += 1
		
	_set_talking(dialogue_participants["npc"], npc_name, welcome)

# removes all child nodes from the vbox container if present
func _reset_dialogue_options():
	if $ScrollContainer/AspectRatioContainer/VBoxContainer.get_child_count() == 0:
		return
	for opt in $ScrollContainer/AspectRatioContainer/VBoxContainer.get_children():
		opt.queue_free()

func _set_talking(avatar:Texture, talking:String, text:String):
	$DialogueOverlay/AvatarImage.texture = avatar
	$DialogueOverlay/CharacterName.text = talking + ":" 
	$DialogueOverlay/Text.text = "\"" + text + "\"" if text != "" else "\"...\""

func _set_container_visibility(visibility:bool):
	$ScrollContainer.visible = visibility

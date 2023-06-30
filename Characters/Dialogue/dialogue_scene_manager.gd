extends Control

@export var dialogue_timer: float

var dialogue_participants = {
	"player": load("res://Assets/Dialogue Icons/icon_player.svg")
}

func _ready():
	# gamevent bus verbinden
	EventHandler.connect("dialogue_started_event", _start_dialogue)
	EventHandler.connect("dialogue_ended_event", _end_dialogue)

func _start_dialogue(npc_dialogue:Dialogue):
	EventHandler.emit_signal("set_player_movement", false)
	_run_dialogue(npc_dialogue.dialogue)
	_instantiate_dialogue_options(npc_dialogue)
	get_parent().show()
	
func _end_dialogue():
	EventHandler.emit_signal("set_player_movement", true)
	_reset_dialogue_options()
	get_parent().hide()

# TODO: hier den dialog abspielen
func _run_dialogue(dialogue:Dictionary):
	var current_id = dialogue.keys()[0] # an erster stelle immer der dialog start
	print()

# TODO: dialogoptionen hier instanziieren
func _instantiate_dialogue_options(dia:Dialogue):
	var num = 1
	var current_id = dia.dialogue.keys()[0]
	var current_dialogue = dia.dialogue.get(current_id) as DialogueOption
	
	var welcome = current_dialogue.welcome
	var npc_name = current_dialogue.npc_name
	
	for opt in current_dialogue.options:
		var dia_opt = ResourceLoader.load("res://Characters/Dialogue/dialogue_option.tscn")
		var new_dia_opt = dia_opt.instantiate() as DialogueOptionContainer
		
		new_dia_opt.talk_option = opt
		new_dia_opt.number = num
		$ScrollContainer/AspectRatioContainer/VBoxContainer.add_child(new_dia_opt)
		num += 1
		
	_set_talking(dia.avatar_texture, npc_name, welcome)

func _instantiate_dialogue(options: Dialogue):
	# add the npc avatar to the dictionary
	dialogue_participants["npc"] = options.avatar_texture
	
	for opt in options.dialogue_options:
		if opt.has("welcome_text"):
			$DialogueOverlay/CharacterName.text = opt.get("display_name") + ":"
			$DialogueOverlay/Text.text = "\"" + opt.get("welcome_text") + "\""
			$DialogueOverlay/AvatarImage.texture = dialogue_participants["npc"]

# removes all child nodes from the vbox container if present
func _reset_dialogue_options():
	if $ScrollContainer/AspectRatioContainer/VBoxContainer.get_child_count() == 0:
		return
	for opt in $ScrollContainer/AspectRatioContainer/VBoxContainer.get_children():
		opt.queue_free()

func _play_dialogue(text:String, npc_answer:String, player_answer:String, end_function:bool):
	_set_container_visibility(false) # falls ichs schaffe, das in ne schleife auszulagern nur ein aufruf nötig
	# TODO: mit schleife über alle möglichen optionen itarieren wär nett
	_set_talking(dialogue_participants["player"], "Player", text)
	await get_tree().create_timer(dialogue_timer).timeout
	_set_talking(dialogue_participants["npc"], "NPC (placeholder)", npc_answer)
	await get_tree().create_timer(dialogue_timer).timeout
	_set_talking(dialogue_participants["player"], "Player", player_answer)
	await get_tree().create_timer(dialogue_timer).timeout
	_set_container_visibility(true)
	if end_function:
		EventHandler.emit_signal("dialogue_ended_event")

func _set_talking(avatar:Texture, talking:String, text:String):
	$DialogueOverlay/AvatarImage.texture = avatar
	$DialogueOverlay/CharacterName.text = talking + ":" 
	$DialogueOverlay/Text.text = "\"" + text + "\"" if text != "" else "\"...\""

func _set_container_visibility(visibility:bool):
	$ScrollContainer.visible = visibility

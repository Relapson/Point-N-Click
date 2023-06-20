extends Control

var dialogue_participants = {
	"player": load("res://Assets/Dialogue Icons/icon_player.svg")
}

func _ready():
	# gamevent bus verbinden
	EventHandler.connect("dialogue_started_event", _start_dialogue)
	EventHandler.connect("dialogue_ended_event", _end_dialogue)

func _start_dialogue(npc_dialogue:Dialogue):
	EventHandler.emit_signal("set_player_movement", false)
	_instantiate_dialogue_options(npc_dialogue.dialogue_options)
	_instantiate_dialogue(npc_dialogue)
	get_parent().show()
	
func _end_dialogue():
	EventHandler.emit_signal("set_player_movement", true)
	_reset_dialogue_options()
	get_parent().hide()

func _instantiate_dialogue_options(options:Array):
	var num = 1
	for opt in options:
		var text_option
		var dia_opt 
		var new_dia_opt 
		
		if opt.has("option"):
			dia_opt = ResourceLoader.load("res://Characters/Dialogue/dialogue_option.tscn")
			new_dia_opt = dia_opt.instantiate()
			text_option = opt["option"]
			new_dia_opt.get_node("DialogueOption").text = text_option
			new_dia_opt.get_node("DialogueNumber").text = str(num) + ". "
			$ScrollContainer/AspectRatioContainer/VBoxContainer.add_child(new_dia_opt)
			num += 1
			
		# check if theres an function entry in the JSON
		# yes -> set the end function on the dialogue option
		if opt.has("function"):
			if opt.get("function") == "end_dialogue":
				new_dia_opt.end_function = true
				new_dia_opt.end_dialogue.connect(_end_dialogue)

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

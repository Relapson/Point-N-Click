extends Control

func _ready():
	# gamevent bus verbinden
	EventHandler.connect("dialogue_started_event", _start_dialogue)
	EventHandler.connect("dialogue_ended_event", _end_dialogue)

func _start_dialogue(npc_dialogue:Dialogue):
	EventHandler.emit_signal("set_player_movement", false)
	_instantiate_dialogue_options(npc_dialogue.dialogue_options)
	get_parent().show()
	
func _end_dialogue():
	EventHandler.emit_signal("set_player_movement", true)
	_reset_dialogue_options()
	get_parent().hide()

func _instantiate_dialogue_options(options:Array):
	var num = 1
	for opt in options:
		var text = opt["text"]
		var dia_opt = ResourceLoader.load("res://Characters/Dialogue/dialogue_option.tscn")
		var new_dia_opt = dia_opt.instantiate()
		new_dia_opt.get_node("DialogueNumber").text = str(num) + ". "
		new_dia_opt.get_node("DialogueOption").text = text
		if opt.has("function"):
			new_dia_opt.end_function = true
			new_dia_opt.end_dialogue.connect(_end_dialogue)
		
		$ScrollContainer/AspectRatioContainer/VBoxContainer.add_child(new_dia_opt)
		num += 1

# removes all child nodes from the vbox container if present
func _reset_dialogue_options():
	if $ScrollContainer/AspectRatioContainer/VBoxContainer.get_child_count() == 0:
		return
	for opt in $ScrollContainer/AspectRatioContainer/VBoxContainer.get_children():
		opt.queue_free()

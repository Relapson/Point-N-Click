extends Control

var test_dialogue_options

func _ready():
	
	test_dialogue_options = _load_dialogue()
	
	# gamevent bus verbinden
	EventHandler.connect("dialogue_started_event", _start_dialogue)
	EventHandler.connect("dialogue_ended_event", _end_dialogue)

func _start_dialogue():
	_instantiate_dialogue_options(test_dialogue_options)
	get_parent().show()
	
func _end_dialogue():
	_reset_dialogue_options()
	get_parent().hide()

func _load_dialogue():
	var file = FileAccess.open("res://Characters/Dialogue/Dialogue_Data/DialogNpc01.json", FileAccess.READ)
	var text = file.get_as_text()
	return JSON.parse_string(file.get_as_text())

func _instantiate_dialogue_options(options:Array):
	var num = 1
	for opt in options:
		var text = opt["text"]
		var dia_opt = ResourceLoader.load("res://Characters/Dialogue/dialogue_option.tscn")
		var new_dia_opt = dia_opt.instantiate()
		new_dia_opt.get_node("DialogueNumber").text = str(num) + ". "
		new_dia_opt.get_node("DialogueOption").text = text
		$ScrollContainer/AspectRatioContainer/VBoxContainer.add_child(new_dia_opt)
		num += 1

# removes all child nodes from the vbox container if present
func _reset_dialogue_options():
	if $ScrollContainer/AspectRatioContainer/VBoxContainer.get_child_count() == 0:
		return
	for opt in $ScrollContainer/AspectRatioContainer/VBoxContainer.get_children():
		opt.queue_free()

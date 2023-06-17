extends Control

func _ready():
	
	$Bars.hide()
	
	# gamevent bus verbinden
	EventHandler.connect("dialogue_started_event", _start_dialogue)
	EventHandler.connect("dialogue_ended_event", _end_dialogue)

func _start_dialogue():
	$Bars.show()
	get_parent().show()
	
func _end_dialogue():
	$Bars.hide()
	get_parent().hide()

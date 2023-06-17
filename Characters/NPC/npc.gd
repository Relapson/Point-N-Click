extends Node2D

signal dialogue_begin

var dialogue = "Hello cruel world..\nWhy are you procrastinating?"

func _ready():
	
	# signal, ob spieler am ziel angekommen ist, verbinden?
#	get_node("../Player").player_arrived.connect(_begin_dialogue)
	
	$Speech.hide()
	$Speech.set_text(dialogue)

func _on_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("mouse_left"):
		$Speech.show()

	if Input.is_action_just_pressed("mouse_right"):
		$Speech.hide()

func _begin_dialogue():
	$Speech.show()

func _on_playerbody_entered(body):
	if body.is_in_group("player"):
		EventHandler.emit_signal("dialogue_started_event")

func _on_playerbody_exited(body):
	if body.is_in_group("player"):
		EventHandler.emit_signal("dialogue_ended_event")

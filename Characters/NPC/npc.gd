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

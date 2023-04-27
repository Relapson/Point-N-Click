extends Area2D

@export var next_room: PackedScene
@export var room_name: String = ""
var showing = false

func _ready():
	$RoomName.set_text(room_name)
	$RoomName.hide()

func _on_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("mouse_left") and not showing:
		$RoomName.show()
		showing = true
		
	if Input.is_action_just_pressed("mouse_right") and showing:
		$RoomName.hide()
		showing = false

extends Area2D

@export_file("*.tscn", "*.scn") var next_room # pfad zur scene
@export var next_area_id: int
@export var this_area_id: int

var body_in_area = false
var clicked = false # TODO: geht vielleicht besser, funktioniert abers

func _ready():
	$RoomName.set_text(next_room if next_room != null else "")
	$RoomName.hide()

func _process(_delta): 
	if clicked and body_in_area and get_node("../Player").allow_movement:
		_room_switch()
		return

# wenn im bereich geklickt wurde -> true
func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		clicked = true
		# check for doubleclick for instant scene transition
		if event.double_click and get_node("../Player").allow_movement:
			_room_switch()
		if event.get_button_index() == 1 and body_in_area and get_node("../Player").allow_movement:
			clicked = true

func _on_player_body_entered(body):
	if body.name == "Player":
		body_in_area = true

func _on_player_body_exited(body):
	if body.name == "Player":
		body_in_area = false

func _room_switch():
	clicked = false
	RoomLoader.goto_scene(next_room, next_area_id)
	return

extends Area2D

@export_file("*.tscn", "*.scn") var next_room # pfad zur scene
@export var area_id: int

var body_in_area = false
var clicked = false # TODO: geht vielleicht besser, funktioniert aber
var polygon_enter_point: Vector2 # punkt auf den der spieler beim betreten gesetzt wird

var area_newly_left = false

func _ready():
	$RoomName.set_text(next_room if next_room != null else "")
	$RoomName.hide()
	var dings = get_tree().root.get_children()[1].find_child("Player")

func _process(_delta): 
	if clicked and body_in_area:
		_room_switch()
		return

# wenn im bereich geklickt wurde -> true
func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		clicked = true
		# check for doubleclick for instant scene transition
		if event.double_click:
			_room_switch()
		if event.get_button_index() == 1 and body_in_area:
			clicked = true

func _on_player_body_entered(body):
	if body.name == "Player":
		body_in_area = true

func _on_player_body_exited(body):
	if body.name == "Player":
		body_in_area = false

func _room_switch():
	clicked = false
	RoomLoader.room_name = name
	if area_newly_left:
		get_node("../Player").save_pos(area_id, $PlayerSpawnPoint.global_position)
	area_newly_left = !area_newly_left
	RoomLoader.goto_scene(next_room, area_id)
	return

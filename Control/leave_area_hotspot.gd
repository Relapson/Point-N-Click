extends Area2D

@export_file("*.tscn", "*.scn") var next_room # pfad zur scene
#@export var room_name: String

var body_in_area = false
var clicked = false # TODO: geht vielleicht besser, funktioniert aber
var polygon_enter_point: Vector2 # punkt auf den der spieler beim betreten gesetzt wird

func _ready():
	$RoomName.set_text(next_room if next_room != null else "")
	$RoomName.hide()
	var polygon_points = $CollisionPolygon2D.get_polygon()
	# mittig zwischen der unteren polygoin kante
	var pol_x = (polygon_points[2].x - polygon_points[1].x) / 2
	var pol_y = (polygon_points[2].y - polygon_points[1].y) / 2
	# TODO: position beim zurückgehen auf die letzte wieder setzen -> room script?
	polygon_enter_point = $PlayerSpawnPoint.global_position # globale position auf dem letzten screen
	#polygon_enter_point = Vector2(pol_x, pol_y)
	#polygon_enter_point = polygon_points[1].lerp(polygon_points[2], 0.5)

func _process(_delta):
	if clicked and body_in_area:
		RoomLoader.room_name = name
		RoomLoader.player_pos_last_screen = polygon_enter_point
		await get_tree().create_timer(0.2).timeout # TODO: kurz warten bevor szene gewechselt wird - evtl auch animation abspielen/abwarten dann
		RoomLoader.goto_scene(next_room)
		return

# wenn im bereich geklickt wurde -> true
func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		clicked = true
		# check for doubleclick for instant scene transition
		if event.double_click:
			clicked = false
			RoomLoader.room_name = name
			RoomLoader.player_pos_last_screen = polygon_enter_point
			RoomLoader.goto_scene(next_room)
			return
		if event.get_button_index() == 1 and body_in_area:
			clicked = true

func _on_player_body_entered(body):
	if body.name == "Player":
		body_in_area = true

func _on_player_body_exited(body):
	if body.name == "Player":
		body_in_area = false

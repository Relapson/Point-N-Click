extends Area2D

@export_file("*.tscn", "*.scn") var next_room # pfad zur scene

var body_in_area = false
var clicked = false # TODO: geht vielleicht besser, funktioniert aber
var polygon_enter_point: Vector2 # punkt auf den der spieler beim betreten gesetzt wird

func _ready():
	$RoomName.set_text(next_room if next_room != null else "")
	$RoomName.hide()
	if RoomLoader.player_pos_last_screen:
		get_node("../Player").load_pos()

func _process(_delta):
	if clicked and body_in_area:
		RoomLoader.room_name = name
		get_node("../Player").save_pos()
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
			get_node("../Player").save_pos()
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

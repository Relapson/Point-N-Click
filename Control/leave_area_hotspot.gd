extends Area2D

@export_file var next_room # pfad zur scene
@export var exit_position: Vector2 # stelle zum wiedereintritt
var body_in_area = false
var clicked = false # TODO: geht vielleicht besser, funktioniert aber

func _ready():
	$RoomName.set_text(next_room if next_room != null else "")
	$RoomName.hide()

func _process(delta):
	if clicked and body_in_area:
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

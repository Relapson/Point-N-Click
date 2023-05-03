extends Area2D

@export_file var next_room # ERROR: nicht die packed scene, sondern den pfad dazu referenzieren
@export var exit_position: Vector2
#@export var room_name: String = "" optional vielleicht
var showing = false
var body_in_area = false
# area left variable einführen, damit spieler durch die selbe stelle den bereich verlassen/betreten kann

func _ready():
	$RoomName.set_text(next_room)
	$RoomName.hide()

func _on_input_event(_viewport, event, _shape_idx):
	# check for doubleclick for instant scene transition
	if event is InputEventMouseButton:
		if event.get_button_index() == 1 and body_in_area:
			body_in_area = false
			RoomLoader.goto_scene(next_room)
			return
		if event.double_click:
			RoomLoader.goto_scene(next_room)
			return

# zusätzlich prüfen ob bereich geklickt wurde
func _on_player_body_entered(body):
	if body.name == "Player":
		body_in_area = true
		print(body_in_area)

func _on_player_body_exited(body):
	if body.name == "Player":
		body_in_area = false
		print(body_in_area)

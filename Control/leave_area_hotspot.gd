extends Area2D

@export_file var next_room # ERROR: nicht die packed scene, sondern den pfad dazu referenzieren
#@export var room_name: String = "" optional vielleicht
var showing = false
var clicked_on = false
# area left variable einführen, damit spieler durch die selbe stelle den bereich verlassen/betreten kann

func _ready():
	$RoomName.set_text(next_room)
	$RoomName.hide()

func _on_input_event(_viewport, event, _shape_idx):
	# check for doubleclick for instant scene transition
	if event is InputEventMouseButton:
		if event.double_click:
			clicked_on = false
			RoomLoader.goto_scene(next_room)
			return
		clicked_on = true

# zusätzlich prüfen ob bereich geklickt wurde
func _on_player_body_entered(body):
	if clicked_on:
		clicked_on = false
		RoomLoader.goto_scene(next_room)
		return
		
func set_clicked_on(click):
	clicked_on = click

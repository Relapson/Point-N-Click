extends Area2D

@export_file var next_room # ERROR: nicht die packed scene, sondern den pfad dazu referenzieren
#@export var room_name: String = "" optional vielleicht
var showing = false
# area left variable einführen, damit spieler durch die selbe stelle den bereich verlassen/betreten kann

func _ready():
	$RoomName.set_text(next_room)
	$RoomName.hide()
	# print(is_connected("input_event", _on_input_event)) debug print

# change the room to the 'next_room'
func change_room():
	pass

func _on_input_event(_viewport, event, _shape_idx):
	# check for doubleclick for instant scene transition
	if event is InputEventMouseButton:
		if event.double_click:
			RoomLoader.goto_scene(next_room)

# zusätzlich prüfen ob bereich geklickt wurde
func _on_player_body_entered(body):
	print(body)
	# switch the scene here

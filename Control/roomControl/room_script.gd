extends Node
class_name RoomScript

@export var scene_id: int
var area_id: int

var player_entered_area = false

func _ready():
	if player_entered_area:
		$Player.load_pos(scene_id)

func set_area_id(id):
	area_id = id

func get_scene_id():
	return scene_id

func invert_player_entered_area():
	player_entered_area = !player_entered_area

#func invert_player_entered_area(val):
#	if val != null:
#		player_entered_area = val
#	else:
#		player_entered_area = !player_entered_area

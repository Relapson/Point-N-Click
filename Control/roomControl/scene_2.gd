extends Node

var scene_id: int

var player_entered_area = false

func _ready():
	if player_entered_area:
		$Player.load_pos(scene_id)

func set_scene_id(id):
	scene_id = id

func invert_player_entered_area():
	player_entered_area = !player_entered_area

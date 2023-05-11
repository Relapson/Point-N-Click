extends Node

var scene_id: int

var player_entered_area = false

func _ready():
	$Player.load_pos(scene_id)

func set_scene_id(id):
	scene_id = id

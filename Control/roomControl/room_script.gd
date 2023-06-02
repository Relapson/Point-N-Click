extends Node
class_name RoomScript

@export var scene_id: int

# TODO: vielleicht später verwendung für sowas
# @onready var room_newly_entered = true

var player_entered_area = false

func _ready():
	add_to_group("scene")

func get_scene_id():
	return scene_id

extends Node

var current_scene = null
var player_pos = null # spieler position um diese bei wiedereintritt zu setzen
var room_name = null # raum namen merken um entsprechenden knoten wieder zu finden

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	
func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)
	
func _deferred_goto_scene(path):
	# free current scene
	current_scene.free()
	# load new scene
	var s = ResourceLoader.load(path)
	# instanciate new scene
	current_scene = s.instantiate()
	# add to active scene
	get_tree().root.add_child(current_scene)

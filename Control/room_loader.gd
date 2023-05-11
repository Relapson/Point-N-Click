extends Node

var current_scene = null
var player_pos_last_screen = null # spieler position um diese bei wiedereintritt zu setzen
var room_name = null # raum namen merken um entsprechenden knoten wieder zu finden

# testing
var area_positions = {
	1:Vector2(955, 533),
	2:Vector2(1344, 570)}

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	
func goto_scene(path, area_id):
	call_deferred("_deferred_goto_scene", path, area_id)
	
func _deferred_goto_scene(path, area_id):
	# free current scene
	current_scene.free()
	# load new scene
	var s = ResourceLoader.load(path)
	# instanciate new scene
	current_scene = s.instantiate()
	# call the function to set the area
	current_scene.call("set_scene_id", area_id)
	# add to active scene
	get_tree().root.add_child(current_scene)
	
	print("CALLED WITH AREA ID: " + str(area_id))

# funktion um area pos zu bekommen
func get_area_pos(area_id):
	if area_id in area_positions:
		return area_positions[area_id]
	else:
		return null

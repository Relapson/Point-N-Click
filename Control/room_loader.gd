extends Node

var current_scene = null

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1).get_child(0)
	
func goto_scene(path, area_id):
	call_deferred("_deferred_goto_scene", path, area_id)
	
func _deferred_goto_scene(path, area_id):
	# free current scene
	current_scene.free()
	# load new scene
	var s = ResourceLoader.load(path)
	# instanciate new scene
	current_scene = s.instantiate()
	# function call to find all doors in the newly loaded scene
	var possible_doors:Array = _find_all_scene_areas(current_scene)
	# set the player position in the new scene to the position
	# of the door the player wants to enter the newly instantiated room
	var door_pos = _find_scene_area_spawn_point(possible_doors, area_id)
	current_scene.get_node("Player").position = door_pos
	# add to active scene
	get_tree().root.add_child(current_scene)

# finds and returns the one specific door
func _find_scene_area_spawn_point(scene_areas:Array, area_id:int):
	for entry in scene_areas:
		
		if entry[1].this_area_id == area_id:
			#[0] scene_id [1] leavearea
			return entry[1].get_node("PlayerSpawnPoint").global_position

# finds all leaveable areas in the new scene
func _find_all_scene_areas(new_scene:Node):
	var doors = []
	for door in new_scene.get_children():
		if door.is_in_group("door"):
			# scene id hinzuzufügen fast schon überflussig, vorerst mal drinne lassen
			doors.append([new_scene.call("get_scene_id"), door])
	return doors

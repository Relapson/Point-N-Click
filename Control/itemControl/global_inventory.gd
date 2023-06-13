extends Node

signal dict_changed

# in array oder dict aufgehobene items verwalten
# in _ready() funktion bei den items die items nur dann zeichnen, falls nicht in dict
# dict anhand von csv oder so initialisieren? lieber nicht denk ich

var picked_up_items = {}

func add_item_to_dict(id:String, picked_up:bool, item_sprite:Sprite2D, 
						hover_name:String, 
						other_item_id:String, 
						destroyed_on_interaction:bool):
	if id not in picked_up_items:
		picked_up_items[id] = {
			"is_picked_up":picked_up,
			"item_sprite":item_sprite.texture.resource_path, # item wird beim aufheben zerstört -> referenz geht verloren
			"hover_name":hover_name,
			"other_item_id":other_item_id,
			"destroyed_on_interaction":destroyed_on_interaction
			}
		dict_changed.emit()
	#print(str(picked_up_items))
	
# returns item, else null
func get_item_from_dict(id:String):
	if id in picked_up_items:
		return picked_up_items.get(id)
	else:
		return null
		
func remove_item_from_dict(id:String):
	# possible to emit signal here
	picked_up_items.erase(id)

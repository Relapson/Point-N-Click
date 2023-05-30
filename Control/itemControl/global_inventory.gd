extends Node

# in array oder dict aufgehobene items verwalten
# in _ready() funktion bei den items die items nur dann zeichnen, falls nicht in dict
# dict anhand von csv oder so initialisieren? lieber nicht denk ich

var picked_up_items = {}

func add_item_to_dict(id:String, picked_up:bool):
	if id not in picked_up_items:
		picked_up_items[id] = picked_up
	#print(str(picked_up_items))
	
# returns boolean if item 
func get_item_from_dict(id:String):
	if id in picked_up_items:
		return picked_up_items.get(id)
	else:
		return false
		
func remove_item_from_dict(id:String):
	# possible to emit signal here
	picked_up_items.erase(id)

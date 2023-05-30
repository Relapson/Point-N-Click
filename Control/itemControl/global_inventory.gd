extends Node

# in array oder dict aufgehobene items verwalten
# in _ready() funktion bei den items die items nur dann zeichnen, falls nicht in dict
# dict anhand von csv oder so initialisieren? lieber nicht denk ich

var picked_up_items = {}

func add_item_to_dict(id, picked_up):
	picked_up_items[id] = picked_up
	
# returns boolean if item 
func get_item_from_dict(id):
	if id in picked_up_items:
		return picked_up_items[id]
	else:
		return false

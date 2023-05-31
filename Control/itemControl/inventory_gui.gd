extends Node

func _ready():
	for item in GlobalInventory.picked_up_items:
		$Control/ItemList.add_item(item)

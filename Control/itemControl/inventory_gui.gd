extends Node

func _input(_event):
	if Input.is_action_just_pressed("open_inv"):
#	if event is InputEventKey and event.keycode == KEY_I:
		$CenterContainer.visible = !$CenterContainer.visible

func _ready():
	$CenterContainer.visible = false
	
	for item_panel in $CenterContainer/ItemGridContainer.get_children():
		if randi() % 2 == 0:
			item_panel.get_node("ItemImage").visible = true
			item_panel.item_in_place = true
		else:
			item_panel.get_node("ItemImage").visible = false
	
func add_item_to_inventory():
	# adds an item to the first free position in the inventory
	pass
	
func update_inventory():
	# updated every position in the inventory
	pass

func update_inventory_at_position(position:int):
	# updates inventory at specific position
	pass

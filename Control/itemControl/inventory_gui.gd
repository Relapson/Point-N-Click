extends Node

func _input(_event):
	if Input.is_action_just_pressed("open_inv"):
#	if event is InputEventKey and event.keycode == KEY_I:
		$CenterContainer.visible = !$CenterContainer.visible

func _ready():
	$CenterContainer.visible = false
	
	# signal nur dann verbinden, wenn noch nicht verbunden
	get_node("/root/GlobalInventory").dict_changed.connect(receive_item_picked_up_signal)
	
	# TODO: jetzt schon funktion die das inventar serialisiert?
	# oder einfach immer leeres inventar in dem dann die aufgehobenen
	# items auftauchen?

	# testfunktion die einfach random die felder befüllt
#	for item_panel in $CenterContainer/ItemGridContainer.get_children():
#		if randi() % 2 == 0:
#			item_panel.get_node("ItemImage").visible = true
#			item_panel.item_in_place = true
#		else:
#			item_panel.get_node("ItemImage").visible = false
	
func receive_item_picked_up_signal():
	update_inventory()

func add_item_to_inventory():
	# adds an item to the first free position in the inventory
	pass
	
func update_inventory():
	# updated every position in the inventory
	# puts every item from the dict into a free spot (for now)
	for item_id in GlobalInventory.picked_up_items:
		var entry = GlobalInventory.picked_up_items.get(item_id)
		for slot in $CenterContainer/ItemGridContainer.get_children():
			if !slot.item_in_place:
				slot.item_in_place = true
				slot.get_node("ItemImage").texture = load(entry.get("item_sprite"))
				slot.get_node("ItemImage").visible = true
				slot.get_node("Label").set_text(entry.get("hover_name"))
				break
		break

func update_inventory_at_position(position:int):
	# updates inventory at specific position
	pass

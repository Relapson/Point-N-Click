extends Node

signal item_selected

var inventory_open = false

func _input(_event):
	if Input.is_action_just_pressed("open_inv"):
		pass

func _ready():
	
	# IDEE: mit signal das item mitschicken und das dann speichern
	# signal nur dann verbinden, wenn noch nicht verbunden
	get_node("/root/GlobalInventory").dict_changed.connect(receive_item_picked_up_signal)
	
	# signal, falls ein item panel angeklickt wurde
	# mit jedem slot verbinden
	for inv_pane in $CenterContainer/ItemGridContainer.get_children():
		inv_pane.item_slot_clicked.connect(receive_item_selected_signal)
	
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
	
func receive_item_selected_signal(item_sprite_path):
#	print("SIGNAL RECEIVED " + item_sprite_path if item_sprite_path else "meh")
	item_selected.emit(item_sprite_path)

func receive_item_picked_up_signal():
	add_item_to_inventory()

func add_item_to_inventory():
	# adds an item to the first free position in the inventory
	# puts every item from the dict into a free spot (for now)
	for item_id in GlobalInventory.picked_up_items:
		var item_already_in_inventory = false
		var entry = GlobalInventory.picked_up_items.get(item_id)
		for slot in $CenterContainer/ItemGridContainer.get_children():
			# abbruch bedingung wenn item mit gleicher id bereits existiert
			if slot.item_id == item_id:
				item_already_in_inventory = true
				break
			if !slot.item_in_place:
				slot.item_in_place = true
				slot.item_id = item_id
				slot.item_sprite_path = entry.get("item_sprite")
				slot.get_node("ItemImage").texture = load(entry.get("item_sprite"))
				slot.get_node("ItemImage").visible = true
				slot.get_node("Label").set_text(entry.get("hover_name"))
				break
		if item_already_in_inventory:
			continue
		break
	
func update_inventory():
	# updated every position in the inventory
	pass

func update_inventory_at_position(position:int):
	# updates inventory at specific position
	pass

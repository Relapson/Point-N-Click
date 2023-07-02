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
	
	EventHandler.connect("give_item_to_player", add_item_to_inventory)
	EventHandler.connect("item_interact", _add_item_to_inventory)
	
	# signal, falls ein item panel angeklickt wurde
	# mit jedem slot verbinden
	for inv_pane in $CenterContainer/ItemGridContainer.get_children():
		inv_pane.item_slot_clicked.connect(receive_item_selected_signal)
	
func receive_item_selected_signal(item_sprite_path, item_id):
#	print("SIGNAL RECEIVED " + item_sprite_path if item_sprite_path else "meh")
	item_selected.emit(item_sprite_path, item_id)
	print(item_id)

func receive_item_picked_up_signal():
	add_item_to_inventory()

func _add_item_to_inventory(item:Item):
	# TODO: item resource dem panel hinzufügen und das picked up dictionary nur ums item mit der id erweitern
	pass

func add_item_to_inventory(item_dict = null):
	# adds an item to the first free position in the inventory
	# puts every item from the dict into a free spot (for now)
	var dict = GlobalInventory.picked_up_items if not item_dict else DemoItems.demo_items
	
	for item_id in dict:
		var item_already_in_inventory = false
		var entry = dict.get(item_id)
		for slot in $CenterContainer/ItemGridContainer.get_children():
			# abbruch bedingung wenn item mit gleicher id bereits existiert
			if slot.item_id == item_id:
				item_already_in_inventory = true
				break
			if !slot.item_in_place:
				# item properties setzen
				slot.item_in_place = true
				slot.item_id = item_id
				slot.item_sprite_path = entry.get("item_sprite")
				
				slot.get_node("ItemImage").texture = load(entry.item_sprite) # muss items dafür noch umschreiben
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

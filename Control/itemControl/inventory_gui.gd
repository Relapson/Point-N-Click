extends Node

signal item_selected

var inventory_open = false

func _input(_event):
	if Input.is_action_just_pressed("open_inv"):
		pass

func _ready():
	
	# IDEE: mit signal das item mitschicken und das dann speichern
	# signal nur dann verbinden, wenn noch nicht verbunden
	EventHandler.connect("give_item_to_player", _add_item_to_inventory)
	EventHandler.connect("item_interact", _add_item_to_inventory)
	
	# signal, falls ein item panel angeklickt wurde
	# mit jedem slot verbinden
	for inv_pane in $CenterContainer/ItemGridContainer.get_children():
		inv_pane.item_slot_clicked.connect(receive_item_selected_signal)
	
func receive_item_selected_signal(item_sprite_path, item_id):
#	print("SIGNAL RECEIVED " + item_sprite_path if item_sprite_path else "meh")
	item_selected.emit(item_sprite_path, item_id)
	print(item_id)

func _add_item_to_inventory(item:Item):
	# TODO: item resource dem panel hinzufügen und das picked up dictionary nur ums item mit der id erweitern
	for slot in $CenterContainer/ItemGridContainer.get_children():
		if !slot.item_in_place:
			slot.item_in_place = true
			slot.item = item
			slot.set_item_information(item)
			break

func update_inventory():
	# updated every position in the inventory
	pass

func update_inventory_at_position(position:int):
	# updates inventory at specific position
	pass

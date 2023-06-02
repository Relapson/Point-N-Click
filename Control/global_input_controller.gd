extends Node

@onready var inventory_gui = load("res://Control/itemControl/inventory_gui.tscn")

var inventory_open = false

var item_pick_board # item beim aufheben hier zwischenlegen und danach wieder raus

func _input(event):
	pass
#	print(event)
#	if event is InputEventKey and event.keycode == KEY_I:
#		open_and_close_inventory()
#
#func _process(_delta):
#	if Input.is_action_just_pressed("open_inv"):
#		open_and_close_inventory()
		
func open_and_close_inventory():
	pass
#	if !inventory_open:
#		get_tree().root.add_child(inventory_gui.instantiate())
#	else:
#		get_tree().root.remove_child(find_child("inventory_gui"))
#	inventory_open = !inventory_open

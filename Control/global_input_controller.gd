extends Node

@onready var inventory_gui = load("res://Control/itemControl/inventory_gui.tscn")

var inventory_open = false

var item_pick_board # item beim aufheben hier zwischenlegen und danach wieder raus

func _ready():
	get_tree().root.get_node("MainScene/inventory_gui").item_selected.connect(_set_cursor_to_image)
	print()

func _set_cursor_to_image(item_sprite_path):
	if item_sprite_path:
		print("SETTING CURSOR IMAGE TO: " + item_sprite_path)
		# TODO: bild vor dem setzen noch anpassen (skalierung etc.)
		Input.set_custom_mouse_cursor(load(item_sprite_path))

func _input(event):
	if Input.is_action_just_pressed("mouse_right"):
		print(Input.get_current_cursor_shape())
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

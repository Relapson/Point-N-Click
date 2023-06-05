extends Node

@onready var inventory_gui = load("res://Control/itemControl/inventory_gui.tscn")

var inventory_open = false

var item_pick_board = null # item beim aufheben hier zwischenlegen und danach wieder raus

func _ready():
	get_tree().root.get_node("MainScene/GUI/inventory_gui").item_selected.connect(_set_cursor_to_image)

func _set_cursor_to_image(item_sprite_path, item_id):
	if item_sprite_path:
		print("SETTING CURSOR IMAGE TO: " + item_sprite_path + " " + item_id)
		item_pick_board = GlobalInventory.get_item_from_dict(item_id)
		# TODO: bild vor dem setzen noch anpassen (skalierung etc.)
		if item_pick_board:
			var item_sprite = load(item_pick_board.get("item_sprite"))
			Input.set_custom_mouse_cursor(item_sprite, 0, Vector2(100,100))

func _input(event):
	
	if Input.is_action_just_pressed("open_inv"):
		var gui_node = get_tree().root.get_node("MainScene/GUI")
		gui_node.visible = !gui_node.visible
		if !gui_node.visible:
			gui_node.process_mode = Node.PROCESS_MODE_DISABLED
		else:
			gui_node.process_mode = Node.PROCESS_MODE_INHERIT
		
	# reset cursor image
	if Input.is_action_just_pressed("mouse_right"):
		Input.set_custom_mouse_cursor(null)
		item_pick_board = null
	
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

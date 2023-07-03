extends Node

@onready var inventory_gui = load("res://Control/itemControl/inventory_gui.tscn")

@onready var game_cursor = load("res://Assets/cursor.png")
@onready var inventory_cursor = load("res://Assets/cursor.png")

var inventory_open = false

var item_pick_board = null # item beim aufheben hier zwischenlegen und danach wieder raus

func _ready():
	Input.set_custom_mouse_cursor(game_cursor, 0, Vector2(50,50))
	EventHandler.connect("item_selected", _set_cursor_to_image)

func _set_cursor_to_image(item:Item):
	if item:
#		print("SETTING CURSOR IMAGE TO: " + item_sprite_path + " " + item_id)
		item_pick_board = item
		# TODO: bild vor dem setzen noch anpassen (skalierung etc.)
		if item_pick_board:
			var item_sprite = item_pick_board.item_sprite
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
		Input.set_custom_mouse_cursor(game_cursor, 0, Vector2(50,50))
		item_pick_board = null

# TODO: nur vielleicht jeglichen input über den controller regeln
func open_and_close_inventory():
	pass
#	if !inventory_open:
#		get_tree().root.add_child(inventory_gui.instantiate())
#	else:
#		get_tree().root.remove_child(find_child("inventory_gui"))
#	inventory_open = !inventory_open

extends Node

@onready var inventory_gui = load("res://Control/itemControl/inventory_gui.tscn")

@onready var game_cursor = load("res://Assets/cursor.png")
@onready var inventory_cursor = load("res://Assets/cursor.png")

var inventory_open = false

var item_pick_board = null # item beim aufheben hier zwischenlegen und danach wieder raus

var allow_input = true

func _ready():
	Input.set_custom_mouse_cursor(game_cursor, 0, Vector2(50,50))
	EventHandler.connect("item_selected", _set_cursor_to_image)
	EventHandler.connect("set_player_input", _set_input)

func _set_cursor_to_image(item:Item):
	if item:
#		print("SETTING CURSOR IMAGE TO: " + item_sprite_path + " " + item_id)
		item_pick_board = item
		# TODO: bild vor dem setzen noch anpassen (skalierung etc.)
		if item_pick_board:
			var item_sprite = item_pick_board.item_sprite
			Input.set_custom_mouse_cursor(item_sprite, 0, Vector2(100,100))

func _input(event):
	
	if Input.is_action_just_pressed("open_inv") and allow_input:
		var gui_node = get_tree().root.get_node("MainScene/GUI")
		EventHandler.emit_signal("set_player_movement", gui_node.visible)
		_open_and_close_inventory(gui_node)
		
	# reset cursor image
	if Input.is_action_just_pressed("mouse_right"):
		Input.set_custom_mouse_cursor(game_cursor, 0, Vector2(50,50))
		item_pick_board = null

func _set_input(input:bool):
	var gui_node = get_tree().root.get_node("MainScene/GUI") as CanvasLayer
	if gui_node.visible:
		_open_and_close_inventory(gui_node)
	allow_input = input

func _open_and_close_inventory(gui_node:CanvasLayer):
	gui_node.visible = !gui_node.visible
	if !gui_node.visible:
		gui_node.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		gui_node.process_mode = Node.PROCESS_MODE_INHERIT

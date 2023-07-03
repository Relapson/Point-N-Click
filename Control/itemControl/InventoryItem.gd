extends Panel
class_name InventoryItem

signal item_slot_clicked(sprite_path, item_id)

var item_in_place = false
var item_description:String
var item_id
var item_sprite_path
var other_item_id

var item: Item

func _ready():
	$Label.hide()

func _process(delta):
	if item_in_place:
		var text_pos = get_local_mouse_position()
		$Label.position = text_pos
		
func _input(_event):
	if Input.is_action_just_pressed("mouse_left") and Rect2(Vector2(), size).has_point(get_local_mouse_position()):
		print(name)
		EventHandler.emit_signal("item_selected", item)
	#if Input.is_action_just_pressed("mouse_left"):
#		Input.set_custom_mouse_cursor($ItemImage.texture)

func _on_mouse_entered():
	$Label.show()

func _on_mouse_exited():
	$Label.hide()

func set_item_information(item:Item):
	$ItemImage.texture = item.item_sprite
	$Label.text = item.item_name

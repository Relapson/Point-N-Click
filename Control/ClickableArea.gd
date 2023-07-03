extends Area2D
class_name ClickableArea

# kommt noch nirgendwo an
signal item_picked_up

# variablen für items
var item_name: String # um den itemnamen zu setzen - später vielleicht anders setzbar
var is_clicked_on = false

func _ready():
	pass
	
func _process(_delta):
	var y_offset = -50
	var x_offset = 10
	var text_pos = get_local_mouse_position()
	# um den text offset zu setzen
	$Description.position.x = text_pos.x + x_offset
	$Description.position.y = text_pos.y + y_offset

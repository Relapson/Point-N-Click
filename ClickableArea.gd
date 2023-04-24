extends Area2D

@export var item_name = "" # um den itemnamen zu setzen - später vielleicht anders setzbar

func _ready():
	$Description.hide()
	$Description.set_text(item_name)
	
func _process(delta):
	var y_offset = -20
	var x_offset = 10
	var text_pos = get_local_mouse_position()
	# um den text offset zu setzen
	$Description.position.x = text_pos.x + x_offset
	$Description.position.y = text_pos.y + y_offset

func _on_mouse_entered():
	$Description.show()

func _on_mouse_exited():
	$Description.hide()

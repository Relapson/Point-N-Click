extends Area2D

@export var item_name = "" # um den itemnamen zu setzen - später vielleicht anders setzbar

func _ready():
	$AspCont/Description.hide()
	$AspCont/Description.set_text(item_name)
	
func _process(delta):
	var y_offset = -20
	var x_offset = 10
	var text_pos = get_local_mouse_position()
	# um den text offset zu setzen
	$AspCont/Description.position.x = text_pos.x + x_offset
	$AspCont/Description.position.y = text_pos.y + y_offset

func _on_mouse_entered():
	$AspCont/Description.show()

func _on_mouse_exited():
	$AspCont/Description.hide()
	

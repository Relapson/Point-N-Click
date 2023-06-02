extends Panel

var item_in_place = false
var item_description:String

func _ready():
	$Label.hide()

func _process(delta):
	if item_in_place:
		var text_pos = get_local_mouse_position()
		$Label.position = text_pos

func _on_mouse_entered():
	$Label.show()

func _on_mouse_exited():
	$Label.hide()

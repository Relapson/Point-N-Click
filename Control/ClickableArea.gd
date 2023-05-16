extends Area2D

@export var item_name = "" # um den itemnamen zu setzen - später vielleicht anders setzbar

var is_clicked_on = false

func _ready():
	$Description.hide()
	$Description.set_text(item_name)
	
func _process(_delta):
	var y_offset = -20
	var x_offset = 10
	var text_pos = get_local_mouse_position()
	# um den text offset zu setzen
	$Description.position.x = text_pos.x + x_offset
	$Description.position.y = text_pos.y + y_offset
	
	if get_node("../Player").is_arrived() and is_clicked_on:
		pickup_item()

# TODO: wird getriggert sobald der spieler geklickt hat und dann stehen bleibt - egal wo
func pickup_item():
	hide()
	# optional signal ans inventar emitten?
	$CollisionShape2D.set_deferred("disabled", true)

func _on_mouse_entered():
	$Description.show()

func _on_mouse_exited():
	$Description.hide()

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.get_button_index() == 1:
		print()
		print("ITEM " + str(item_name) + " CLICKED!")
		is_clicked_on = true

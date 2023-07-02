extends ClickableArea

# item als resource hier exportieren
@export var item: Item

func _ready():
	$ItemSprite.texture = item.item_sprite
	$Description.hide()
	$Description.text = item.item_name

# logik zum aufheben von items

# signale für body entered und exited

func _on_mouse_entered():
	$Description.show()

func _on_mouse_exited():
	$Description.hide()

func _on_player_body_entered(body):
	if body.is_in_group("player") and is_clicked_on:
		# trigger pickup function
		EventHandler.emit_signal("item_interact", item)
		print("pickup")
		pass

func _on_player_body_exited(body):
	if body.is_in_group("player"):
		print("pickup false")
		is_clicked_on = false

func _on_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("mouse_left"):
		is_clicked_on = true
		
	if Input.is_action_just_pressed("mouse_right"):
		pass

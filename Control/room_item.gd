extends ClickableArea

# item als resource hier exportieren
@export var item: Item

func _ready():
	$ItemSprite.texture = item.item_sprite
	$Description.hide()
	$Description.text = item.item_name
	# falls item aufgehoben -> nicht neu zeichnen
	if item in GlobalInventory.interacted_items:
		_disable_item()

# logik zum aufheben von items

# signale für body entered und exited

func _on_mouse_entered():
	$Description.show()

func _on_mouse_exited():
	$Description.hide()

func _on_player_body_entered(body):
	if body.is_in_group("player") and is_clicked_on:
		# trigger pickup function
		if item.is_item_interactable:
			_pickup_item(item)

func _on_player_body_exited(body):
	if body.is_in_group("player"):
		print("pickup false")
		is_clicked_on = false

func _on_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("mouse_left"):
		is_clicked_on = true
		
	if Input.is_action_just_pressed("mouse_right"):
		pass

func _disable_item():
	hide()
	$CollisionPolygon2D.set_deferred("disabled", true)
	queue_free()

func _pickup_item(item:Item):
	EventHandler.emit_signal("item_interact", item)
	GlobalInventory.interacted_items.append(item)
	_disable_item()

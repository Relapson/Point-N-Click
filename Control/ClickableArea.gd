extends Area2D

@export var item_name = "" # um den itemnamen zu setzen - später vielleicht anders setzbar
@export var item_id: String

@export var is_item_interactable:bool

var is_clicked_on = false
var body_in_area = false

func _ready():
	# prüfen ob item in dict ist - wenn ja, nicht zeichnen
	for item in get_tree().root.get_children():
		# falls item in dict nicht nochmal zeichnen
		if GlobalInventory.get_item_from_dict(item_id):
			_disable_item()
	$Description.hide()
	$Description.set_text(item_name)
	
func _process(_delta):
	var y_offset = -20
	var x_offset = 10
	var text_pos = get_local_mouse_position()
	# um den text offset zu setzen
	$Description.position.x = text_pos.x + x_offset
	$Description.position.y = text_pos.y + y_offset
	
	if body_in_area and is_clicked_on and get_node("../Player").is_arrived():
		if is_item_interactable:
			_pickup_item()
		# alternativ iwas dazu sagen oder so idk

func _disable_item():
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	queue_free()

# wird getriggert sobald der spieler geklickt hat und dann stehen bleibt
func _pickup_item():
	_disable_item()
	# optional signal ans inventar emitten?
	# TODO: aus item_name vlt noch item_id machen
	GlobalInventory.add_item_to_dict(item_id, true)
	# IDEE: signal an spieler zum animation abspielen senden bzw funktion aufrufen

func _on_mouse_entered():
	$Description.show()

func _on_mouse_exited():
	$Description.hide()

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.get_button_index() == 1:
		is_clicked_on = true

func _on_player_body_entered(body):
	if body.is_in_group("player"):
		body_in_area = true

func _on_player_body_exited(body):
	if body.is_in_group("player"):
		body_in_area = false

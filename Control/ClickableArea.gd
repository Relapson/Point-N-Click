extends Area2D

# kommt noch nirgendwo an
signal item_picked_up

# variablen für items
@export var item_name = "" # um den itemnamen zu setzen - später vielleicht anders setzbar
@export var item_id: String
@export var other_item_id: String # die id vom anderen item, mit dem man interagieren kann
@export var destroyed_on_interaction: bool
# item, welches der spieler nach erfolgreicher interaktion erhält
@export var item_received_on_interaction: String

@export var is_item_interactable:bool

@onready var item_sprite:Sprite2D = $ItemSprite

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
	var y_offset = -50
	var x_offset = 10
	var text_pos = get_local_mouse_position()
	# um den text offset zu setzen
	$Description.position.x = text_pos.x + x_offset
	$Description.position.y = text_pos.y + y_offset
	
	if body_in_area and is_clicked_on and get_node("../Player").is_arrived():
		if is_item_interactable or GlobalInputController.item_pick_board:
			_pickup_item()
		# alternativ iwas dazu sagen oder so idk

func _disable_item():
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	queue_free()

func _interact_or_combine_item():
	var other_item_id = GlobalInputController.item_pick_board.get("other_item_id")
	if other_item_id == item_id:
		print("INTERACT")
		if destroyed_on_interaction:
			_disable_item()
			# TODO: hier spieler neues item geben etc
	else:
		print("NO INTERACT")
	is_clicked_on = false

# wird getriggert sobald der spieler geklickt hat und dann stehen bleibt
func _pickup_item():
	if GlobalInputController.item_pick_board:
		_interact_or_combine_item()
		return
	_disable_item()
	# optional signal ans inventar emitten?
	item_picked_up.emit()
	# TODO: aus item_name vlt noch item_id machen
	GlobalInventory.add_item_to_dict(item_id, true, item_sprite, item_name, other_item_id, destroyed_on_interaction)
	# IDEE: signal an spieler zum animation abspielen senden bzw funktion aufrufen
	is_clicked_on = false

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

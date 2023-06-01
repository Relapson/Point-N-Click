extends Node

func _input(_event):
	if Input.is_action_just_pressed("open_inv"):
#	if event is InputEventKey and event.keycode == KEY_I:
		$CenterContainer.visible = !$CenterContainer.visible

func _ready():
	$CenterContainer.visible = false
	
func update_inventory():
	# updated every position in the inventory
	pass

func update_inventory_at_position(position:int):
	# updates inventory at specific position
	pass

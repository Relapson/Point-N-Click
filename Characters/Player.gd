extends Area2D

var move_speed = 200

func _process(delta):
	var target = Vector2.ZERO
	#var mouse_pos
	var velocity
	# normalize the distance to find the direction, then multiply it by the wanted speed and by the delta time passed
	
	if Input.is_action_pressed("mouse_left"):
		var mouse_pos = get_global_mouse_position()
		target = mouse_pos - position
		#position += global_position.direction_to(mouse_pos) * move_speed * delta
		position += target.normalized() * move_speed * delta
	#position += target.normalized() * move_speed * delta

extends CharacterBody2D

@export var move_speed = 500
var target = position

func _input(_event):
	if Input.is_action_just_pressed("mouse_left"):
		target = get_global_mouse_position()
			
func _physics_process(delta):
	velocity = position.direction_to(target) * move_speed
	# look_at(target) dreht den character optional
	if position.distance_to(target) > 10:
		move_and_slide()

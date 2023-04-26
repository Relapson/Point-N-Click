extends CharacterBody2D

@export var move_speed = 500
#@export var movement_target_position: Vector2 = Vector2(60.0,180.0) vielleicht egal
var target = position

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	
	call_deferred("actor_setup")
	
func actor_setup():
	await get_tree().physics_frame
	#set_movement_target(movement_target_position) vielleicht egal
	
func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

func _input(_event):
	if Input.is_action_just_pressed("mouse_left"):
		target = get_global_mouse_position()
		
	# momentan nur bewegung - später evtl auch auf geklickte objekte checken
	if Input.is_action_just_pressed("mouse_right"):
		target = get_global_mouse_position()

func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		return
	
	###
#	var current_agent_position: Vector2 = global_position
#    var next_path_position: Vector2 = navigation_agent.get_next_path_position()
#
#    var new_velocity: Vector2 = next_path_position - current_agent_position
#    new_velocity = new_velocity.normalized()
#    new_velocity = new_velocity * movement_speed
	###
	
	velocity = (set_movement_target(target) - global_position).normalized() * move_speed
	
	#velocity = position.direction_to(target) * move_speed
	# look_at(target) dreht den character optional
	if position.distance_to(target) > 10:
		move_and_slide()

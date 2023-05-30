extends CharacterBody2D

@export var move_speed = 500
var target = position

# pro spielszene dann ein agent, der GENAU SO heisst
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	#set_movement_target(position if RoomLoader.area_positions else RoomLoader.player_pos_last_screen)
	call_deferred("actor_setup")
	
func actor_setup():
	await get_tree().physics_frame
	
func set_movement_target(movement_target: Vector2):
	navigation_agent.set_target_position(movement_target)

func _input(_event):
	
	# alle items auf nicht-pickup setzen
	for child in get_tree().root.get_children():
		if child.is_in_group("items"):
			child.is_clicked_on = false
	
	if Input.is_action_just_pressed("mouse_left"):
		target = get_global_mouse_position()
		set_movement_target(target)
		
	# momentan nur bewegung - später evtl auch auf geklickte objekte checken
	if Input.is_action_just_pressed("mouse_right"):
		target = get_global_mouse_position()
		set_movement_target(target)

func is_arrived():
	return navigation_agent.is_navigation_finished()

func _physics_process(_delta):
	if is_arrived():
		return
	
	velocity = position.direction_to(navigation_agent.get_next_path_position()) * move_speed
	navigation_agent.set_velocity(velocity)
	if position.distance_to(target) > 10:
		move_and_slide()

# TODO: idee die animation welche abgespielt werden soll reinzureichen und dann hier abzuspielen
func handle_animation(animation_sequence):
	pass

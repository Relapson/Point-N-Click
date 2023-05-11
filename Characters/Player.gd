extends CharacterBody2D

@export var move_speed = 500
var target = position

# pro spielszene dann ein agent, der GENAU SO heisst
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	set_movement_target(position) # if RoomLoader.player_pos_last_screen == null else RoomLoader.player_pos_last_screen)
	call_deferred("actor_setup")
	
func actor_setup():
	await get_tree().physics_frame
	
func set_movement_target(movement_target: Vector2):
	navigation_agent.set_target_position(movement_target)

func _input(_event):
	if Input.is_action_just_pressed("mouse_left"):
		target = get_global_mouse_position()
		set_movement_target(target)
		
	# momentan nur bewegung - später evtl auch auf geklickte objekte checken
	if Input.is_action_just_pressed("mouse_right"):
		target = get_global_mouse_position()
		set_movement_target(target)

func _physics_process(_delta):
	if navigation_agent.is_navigation_finished():
		return
	
	velocity = position.direction_to(navigation_agent.get_next_path_position()) * move_speed
	navigation_agent.set_velocity(velocity)
	if position.distance_to(target) > 10:
		move_and_slide()

func save_pos():
	RoomLoader.player_pos_last_screen = position
	
func load_pos():
	position = RoomLoader.player_pos_last_screen

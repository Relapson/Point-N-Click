extends Node

func _ready():
	print(RoomLoader.room_name)
	
	if RoomLoader.room_name:
		var room_node = get_node(RoomLoader.room_name)
		if room_node:
			$Player.global_position = RoomLoader.player_pos_last_screen

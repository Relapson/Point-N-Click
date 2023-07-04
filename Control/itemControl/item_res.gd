extends Resource
class_name Item

@export var item_name: String
@export var item_id: String
@export var picked_up: bool
@export var item_sprite: Texture
@export var hover_name: String
@export var other_item_id: String
@export var destroyed_on_interaction: bool
@export var is_item_interactable:bool
@export var spawned_item: Item

func _init(i_name = "", i_id = "", i_pick = false, i_sprite = null, i_hover = "", i_other = "", i_destroy = false):
	item_name = i_name
	item_id = i_name
	picked_up = i_pick
	item_sprite = i_sprite
	hover_name = i_hover
	other_item_id = i_other
	destroyed_on_interaction = i_destroy

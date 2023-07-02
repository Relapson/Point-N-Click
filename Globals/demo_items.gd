extends Node

var demo_item_directory = "res://Demo Items/"
var demo_items = {}

func _ready():
	var dir = DirAccess.open(demo_item_directory)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			var item = ResourceLoader.load(demo_item_directory + file_name) as Item
			DemoItems.demo_items[item.item_id] = item
			file_name = dir.get_next()

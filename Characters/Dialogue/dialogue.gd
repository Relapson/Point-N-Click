extends Resource
class_name Dialogue

@export var avatar_texture: Texture
@export_file("*.json") var dialogue_file

var dialogue_options

func setup():
	dialogue_options = _load_dialogue()

func _load_dialogue():
	var file = FileAccess.open(dialogue_file, FileAccess.READ)
	return JSON.parse_string(file.get_as_text())

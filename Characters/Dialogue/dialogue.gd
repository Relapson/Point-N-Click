extends Resource
class_name Dialogue

@export var avatar_texture: Texture
@export_file("*.json") var dialogue_file

var dialogue = {}

func setup():
	var dialogue_options = _load_dialogue_file()
	_init_dialogue(dialogue_options)
	print()

func _load_dialogue_file():
	var file = FileAccess.open(dialogue_file, FileAccess.READ)
	return JSON.parse_string(file.get_as_text())

func _init_dialogue(dia_opt:Array) -> void:
	for opt in dia_opt:
		var talk_resource = load("res://Characters/Dialogue/talk_res.tres") as DialogueOption
		
		talk_resource.id = opt.get("id")
		talk_resource.welcome = opt.get("welcome_text")
		talk_resource.npc_name = opt.get("npc_name")
		
		for o in opt.get("options"):
			var talk = {}
			var t = o.get("talk")
			
			talk_resource.option_text = o.get("option_text")
			
			talk["npc"] = t.get("npc")
			talk["player"] = t.get("player")
			talk["signal"] = t.get("signal")
			talk["timer"] = t.get("timer")
			talk["is_talking"] = t.get("is_talking")
			talk["ends_dialogue"] = t.get("ends_dialogue")
			talk["goto_next"] = t.get("goto_next")
			
			talk_resource.options.append(talk)
			
		dialogue[opt.get("id")] = talk_resource # append the resource to the dictionary

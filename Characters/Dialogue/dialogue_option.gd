extends HBoxContainer
class_name DialogueOptionContainer

signal end_dialogue
signal selected_option

var npc_name: String
var number: int
var talk_option: Dictionary

func _ready():
	$DialogueOption.add_theme_color_override("font_hover_color", Color(0,1,0))
	$DialogueOption.text = talk_option.get("option_text")
	$DialogueNumber.text = str(number) + ". "

func _on_dialogue_option_pressed():
	print("PRESSED: " + $DialogueOption.text)
	selected_option.emit(talk_option, npc_name)

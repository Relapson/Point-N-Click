extends HBoxContainer

signal end_dialogue

var end_function = false

func _ready():
	$DialogueOption.add_theme_color_override("font_hover_color", Color(0,1,0))

func _on_dialogue_option_pressed():
	print("PRESSED: " + $DialogueOption.text)
	if end_function:
		print("END DIALOGUE")
		end_dialogue.emit()

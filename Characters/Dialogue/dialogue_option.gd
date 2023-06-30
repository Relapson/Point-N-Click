extends HBoxContainer
class_name DialogueOptionContainer

signal end_dialogue
signal selected_option

var number: int
var talk_option: Dictionary

var end_function = false
var npc_answer: String
var player_answer: String

func _ready():
	$DialogueOption.add_theme_color_override("font_hover_color", Color(0,1,0))

func _on_dialogue_option_pressed():
	print("PRESSED: " + $DialogueOption.text)
	selected_option.emit($DialogueOption.text, npc_answer, player_answer, end_function)
#	if end_function:
#		print("END DIALOGUE")
#		await get_tree().create_timer(2.0).timeout
##		end_dialogue.emit()
#		EventHandler.emit_signal("dialogue_ended_event")

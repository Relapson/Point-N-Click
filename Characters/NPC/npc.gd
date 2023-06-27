extends Node2D

signal dialogue_begin

@export var npc_dialogue: Dialogue

var clicked = false

func _ready():
	npc_dialogue.setup()
	pass
	# signal, ob spieler am ziel angekommen ist, verbinden?

func _on_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("mouse_left"):
		clicked = true

	if Input.is_action_just_pressed("mouse_right"):
		pass

func _on_playerbody_entered(body):
	if body.is_in_group("player") and clicked:
		EventHandler.emit_signal("dialogue_started_event", npc_dialogue)
		clicked = false

func _on_playerbody_exited(body):
	if body.is_in_group("player"):
		EventHandler.emit_signal("dialogue_ended_event")
		clicked = false

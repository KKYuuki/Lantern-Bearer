
extends Label


func _ready() -> void:
	add_to_group("interaction_prompt")
	hide()


func show_prompt(target: Interactable) -> void:
	text = "E - " + target.interaction_name
	show()


func hide_prompt(_target: Interactable = null) -> void:
	hide()

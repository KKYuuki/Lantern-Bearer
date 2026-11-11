
extends Area2D
class_name Interactable

signal interaction_available(target: Interactable)
signal interaction_unavailable(target: Interactable)

@export var interaction_name: String = "Interact"

var player_in_range: bool = false


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true

		body.current_interactable = self

		interaction_available.emit(self)

		var prompt = get_tree().get_first_node_in_group("interaction_prompt")

		if prompt:
			prompt.show_prompt(self)


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false

		if body.current_interactable == self:
			body.current_interactable = null

		interaction_unavailable.emit(self)

		var prompt = get_tree().get_first_node_in_group("interaction_prompt")

		if prompt:
			prompt.hide_prompt(self)


func interact(_player: Node) -> void:
	pass

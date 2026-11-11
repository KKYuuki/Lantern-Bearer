
extends Node
class_name InteractionManager

var nearby_interactables: Array[Interactable] = []


func register_interactable(target: Interactable) -> void:
	if not nearby_interactables.has(target):
		nearby_interactables.append(target)


func unregister_interactable(target: Interactable) -> void:
	nearby_interactables.erase(target)


func interact(player: Node) -> void:
	if nearby_interactables.is_empty():
		return

	var target := nearby_interactables[0]

	if is_instance_valid(target):
		target.interact(player)

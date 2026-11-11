
extends Node

signal memory_collected(memory_id: String)
signal player_died
signal player_respawned

var collected_memories: Array[String] = []
var player_dead: bool = false

var current_world: String = "forest"


func collect_memory(memory_id: String) -> void:
	if collected_memories.has(memory_id):
		return

	collected_memories.append(memory_id)
	memory_collected.emit(memory_id)


func die() -> void:
	if player_dead:
		return

	player_dead = true
	player_died.emit()


func respawn() -> void:
	player_dead = false
	player_respawned.emit()


func has_memory(memory_id: String) -> bool:
	return collected_memories.has(memory_id)

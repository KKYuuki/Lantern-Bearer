
extends Interactable

@export var memory_id: String = "memory_001"
@export var memory_energy_reward: float = 25.0

var activated: bool = false


func interact(player: Node) -> void:
	if activated:
		return

	if not player.lantern.is_active:
		return

	activated = true

	player.lantern.restore_energy(memory_energy_reward)

	GameManager.collect_memory(memory_id)

	player.current_interactable = null

	var prompt = get_tree().get_first_node_in_group("interaction_prompt")

	if prompt:
		prompt.hide_prompt(self)

	queue_free()


extends ProgressBar

var player: Node
var lantern: LanternComponent


func _ready() -> void:
	call_deferred("connect_to_lantern")


func connect_to_lantern() -> void:
	player = get_tree().get_first_node_in_group("player")

	if player == null:
		push_error("Lantern HUD: Player not found!")
		return

	lantern = player.get_node_or_null("LanternComponent")

	if lantern == null:
		push_error("Lantern HUD: LanternComponent not found!")
		return

	# Configure the progress bar.
	min_value = 0
	max_value = lantern.max_energy
	show_percentage = false

	# Connect to lantern energy updates.
	lantern.energy_changed.connect(update_energy)

	# Display the initial energy.
	update_energy(
		lantern.current_energy,
		lantern.max_energy
	)

	print("LANTERN HUD CONNECTED")


func update_energy(current_energy: float, maximum_energy: float) -> void:
	max_value = maximum_energy
	value = current_energy

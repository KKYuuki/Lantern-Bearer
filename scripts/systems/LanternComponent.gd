
extends Node
class_name LanternComponent

signal lantern_state_changed(is_active: bool)
signal energy_changed(current_energy: float, max_energy: float)

@export var max_energy: float = 100.0
@export var drain_rate: float = 10.0

var current_energy: float
var is_active: bool = false


func _ready() -> void:
	current_energy = max_energy


func _process(delta: float) -> void:
	if is_active:
		current_energy -= drain_rate * delta
		current_energy = max(current_energy, 0.0)

		energy_changed.emit(current_energy, max_energy)

		if current_energy <= 0.0:
			deactivate()


func toggle_lantern() -> void:
	if is_active:
		deactivate()
	elif current_energy > 0.0:
		activate()


func activate() -> void:
	is_active = true
	lantern_state_changed.emit(true)


func deactivate() -> void:
	is_active = false
	lantern_state_changed.emit(false)


func restore_energy(amount: float) -> void:
	current_energy = min(current_energy + amount, max_energy)
	energy_changed.emit(current_energy, max_energy)

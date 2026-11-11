
extends Control

func _ready() -> void:
	hide()


func show_death_screen() -> void:
	show()
	get_tree().paused = true


func _on_restart_pressed() -> void:
	get_tree().paused = false
	GameManager.respawn()
	get_tree().reload_current_scene()

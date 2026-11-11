extends Control

@export var full_heart: Texture2D
@export var half_heart: Texture2D
@export var empty_heart: Texture2D

@export var heart_size: Vector2 = Vector2(24, 24)
@export var health_per_heart: int = 20

@onready var hearts_container: HBoxContainer = $HeartsContainer

var player: Node
var health_component: HealthComponent


func _ready() -> void:
	print("HEALTH DISPLAY IS RUNNING")
	call_deferred("connect_to_player")
	

func connect_to_player() -> void:
	player = get_tree().get_first_node_in_group("player")

	if player == null:
		push_error("Player not found!")
		return

	health_component = player.get_node("HealthComponent")
	health_component.health_changed.connect(update_hearts)

	update_hearts(
		health_component.current_health,
		health_component.max_health
	)


func update_hearts(current_health: int, max_health: int) -> void:
	for child in hearts_container.get_children():
		child.queue_free()

	var total_hearts := ceili(float(max_health) / health_per_heart)

	for i in range(total_hearts):
		var heart := TextureRect.new()
		heart.custom_minimum_size = heart_size
		heart.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		heart.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED

		var heart_health := current_health - (i * health_per_heart)

		if heart_health >= health_per_heart:
			heart.texture = full_heart
		elif heart_health >= health_per_heart / 2.0:
			heart.texture = half_heart
		else:
			heart.texture = empty_heart

		hearts_container.add_child(heart)

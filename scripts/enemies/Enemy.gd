
extends CharacterBody2D

@export var move_speed: float = 55.0
@export var detection_range: float = 150.0
@export var attack_range: float = 25.0
@export var attack_damage: int = 10
@export var attack_cooldown: float = 1.0

@onready var health_component: HealthComponent = $HealthComponent

var player: Node2D
var can_attack: bool = true


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	health_component.died.connect(_on_enemy_died)


func _physics_process(_delta: float) -> void:
	if player == null:
		return

	var distance := global_position.distance_to(player.global_position)

	if distance <= detection_range:
		if distance > attack_range:
			var direction := global_position.direction_to(player.global_position)
			velocity = direction * move_speed
			move_and_slide()
		else:
			velocity = Vector2.ZERO
			attack_player()


func attack_player() -> void:
	if not can_attack:
		return

	can_attack = false

	if player.has_method("take_damage"):
		player.take_damage(attack_damage)

	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true


func take_damage(amount: int) -> void:
	health_component.take_damage(amount)


func _on_enemy_died() -> void:
	queue_free()


extends CharacterBody2D

@export var move_speed: float = 120.0
@export var attack_damage: int = 25

@onready var health_component: HealthComponent = $HealthComponent
@onready var attack_area: Area2D = $AttackArea
@onready var lantern: LanternComponent = $LanternComponent

var facing_direction: Vector2 = Vector2.DOWN
var can_attack: bool = true
var current_interactable: Interactable = null


func _ready() -> void:
	health_component.died.connect(_on_player_died)


func _physics_process(_delta: float) -> void:
	var input_direction := Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)

	print("Movement input: ", input_direction)

	if input_direction != Vector2.ZERO:
		facing_direction = input_direction

	velocity = input_direction * move_speed
	move_and_slide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		perform_attack()

	if event.is_action_pressed("lantern"):
		lantern.toggle_lantern()

	if event.is_action_pressed("interact"):
		if current_interactable != null:
			current_interactable.interact(self)


func perform_attack() -> void:
	if not can_attack:
		return

	can_attack = false

	attack_area.position = facing_direction * 20

	for body in attack_area.get_overlapping_bodies():
		if body.is_in_group("enemies"):
			body.take_damage(attack_damage)

	await get_tree().create_timer(0.3).timeout
	can_attack = true


func take_damage(amount: int) -> void:
	health_component.take_damage(amount)


func _on_player_died() -> void:
	GameManager.die()

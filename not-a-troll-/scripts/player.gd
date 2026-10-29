
extends CharacterBody2D

@export var speed: float = 250.0
@export var jump_velocity: float = -400.0

var is_dead: bool = false

func _physics_process(_delta: float) -> void:
	if is_dead:
		return

	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * _delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Horizontal movement
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed

	# Flip the character when moving left or right
	if direction != 0:
		$Visual.flip_h = direction < 0

	move_and_slide()

	update_animation()


func update_animation() -> void:
	if not is_on_floor():
		return

	if absf(velocity.x) > 1.0:
		$Visual.play("run")
	else:
		$Visual.play("idle")


func die() -> void:
	is_dead = true
	velocity = Vector2.ZERO
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/GameOver.tscn")

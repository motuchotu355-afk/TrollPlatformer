
extends CharacterBody2D

const SPEED = 260.0
const JUMP_VELOCITY = -420.0

var gravity = float(
	ProjectSettings.get_setting("physics/2d/default_gravity")
)

var is_dead = false


func _physics_process(delta: float) -> void:
	if is_dead:
		return

	# Apply gravity while the player is in the air.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Jump using Space, Up Arrow, or W.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Move left and right using the keyboard.
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED

	move_and_slide()


func die() -> void:
	if is_dead:
		return

	is_dead = true
	velocity = Vector2.ZERO

	# Brief pause before restarting the level.
	await get_tree().create_timer(0.4).timeout
	get_tree().change_scene_to_file(
        "res://scenes/GameOver.tscn"
	)

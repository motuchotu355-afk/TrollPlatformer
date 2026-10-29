
extends Node2D

@export var death_boundary_y: float = 580.0
@export var boundary_width: float = 2000.0


func _ready() -> void:
	create_death_boundary()


func create_death_boundary() -> void:
	var boundary = Area2D.new()
	boundary.name = "DeathBoundary"
	boundary.position = Vector2(-989, death_boundary_y)

	# Make sure the boundary detects the player.
	boundary.collision_layer = 0
	boundary.collision_mask = 1
	boundary.monitoring = true

	add_child(boundary)

	var collision = CollisionShape2D.new()
	var rectangle = RectangleShape2D.new()
	rectangle.size = Vector2(boundary_width, 40)
	collision.shape = rectangle
	boundary.add_child(collision)

	boundary.body_entered.connect(_on_death_boundary_entered)

	print("Death boundary created at: ", boundary.position)


func _on_death_boundary_entered(body: Node2D) -> void:
	print("Death boundary touched by: ", body.name)

	if body.has_method("die"):
		body.die()
	else:
		print("ERROR: The object has no die() function.")

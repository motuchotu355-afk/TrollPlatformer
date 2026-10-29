
@tool
extends Node2D

var activated: bool = false

@export var trigger_width: float = 100.0:
	set(value):
		trigger_width = maxf(value, 1.0)
		update_trigger()

@export var trigger_height: float = 60.0:
	set(value):
		trigger_height = maxf(value, 1.0)
		update_trigger()

@export var trigger_offset: Vector2 = Vector2(-60, 0):
	set(value):
		trigger_offset = value
		update_trigger()


func update_trigger() -> void:
	if not is_node_ready():
		return

	var trigger_shape = get_node_or_null("Trigger/CollisionShape2D")
	var trigger = get_node_or_null("Trigger")

	if trigger_shape and trigger:
		var rectangle = RectangleShape2D.new()
		rectangle.size = Vector2(trigger_width, trigger_height)
		trigger_shape.shape = rectangle
		trigger.position = trigger_offset


func _ready() -> void:
	if Engine.is_editor_hint():
		update_trigger()
		return

	$Visual.hide()
	$Hazard/CollisionShape2D.set_deferred("disabled", true)

	$Trigger.body_entered.connect(_on_trigger_body_entered)
	$Hazard.body_entered.connect(_on_hazard_body_entered)


func _on_trigger_body_entered(body: Node2D) -> void:
	if activated:
		return

	if not body is CharacterBody2D:
		return

	activated = true

	await get_tree().create_timer(0.2).timeout

	if not is_inside_tree():
		return

	$Visual.show()
	$Hazard/CollisionShape2D.set_deferred("disabled", false)


func _on_hazard_body_entered(body: Node2D) -> void:
	if body.has_method("die"):
		body.die()

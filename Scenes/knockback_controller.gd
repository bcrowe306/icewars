extends Node
class_name KnockbackController

@export var target: CharacterBody2D
@export var max_velocity: float = 1000.0
@export var min_velocity: float = 100.0

var knockback_velocity: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func do_knockback(vector: Vector2, knockback: float ):
	if target and target is CharacterBody2D:
		
		target.velocity = vector * lerpf(min_velocity, max_velocity, knockback)

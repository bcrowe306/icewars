extends HitBox
@onready var player_controller: PlayerController = $"../.."

var direction: bool = true

func _on_process(_delta: float):
	if player_controller.facing_direction != direction:
		for shape in collision_shapes:
			if player_controller.facing_direction:
				shape.position.x = abs(shape.position.x)
				shape.rotation = abs(shape.rotation)
			else:
				shape.position.x = -abs(shape.position.x)
				shape.rotation = -abs(shape.rotation)
		direction = player_controller.direction

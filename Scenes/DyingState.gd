extends State


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _enter(_previous_state: String):
	animated_sprite.speed_scale = 1
	animated_sprite.offset = Vector2(8,5)
	animated_sprite.play(animation_name)

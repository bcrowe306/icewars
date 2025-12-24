extends State
@onready var fall_counter: Counter = $FallCounter


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _update(delta: float):
	pass

func _enter(previous_state: String):
	fall_counter.start()
	animated_sprite.speed_scale = 1
	animated_sprite.offset = Vector2(0,-5)
	animated_sprite.play(animation_name)

func _exit(next_state: String):
	fall_counter.stop()
	fall_counter.reset()

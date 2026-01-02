extends State
@onready var player_controller: PlayerController = $"../.."
@onready var footsteps: AudioStreamPlayer2D = $"../../Footsteps"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
	
func _enter(_previous_state: String):
	animated_sprite.offset = Vector2(-5,0)
	animated_sprite.play(animation_name)

func _update(_delta: float):
	var velocity_percentage: float = player_controller.getVelocityPercentage()
	var current_animation := animation_name
	if velocity_percentage < .5:
		current_animation = "Walk"
		var perc = velocity_percentage / .5
		animated_sprite.speed_scale = lerpf(.5, 1.0, perc/ .5)
		animated_sprite.play(current_animation)
	else:
		animated_sprite.speed_scale = player_controller.getVelocityPercentage()
		animated_sprite.play(current_animation)
	
	

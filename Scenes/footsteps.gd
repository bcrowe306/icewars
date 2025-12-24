extends AudioStreamPlayer2D
@onready var player_animations: AnimatedSprite2D = $"../PlayerAnimations"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_animations_frame_changed() -> void:
	if player_animations.animation == "Run":
		if  player_animations.frame == 3 or player_animations.frame == 7:
			self.pitch_scale = randf_range(.9, 1.1)
			self.play()
			# Replace with function body.

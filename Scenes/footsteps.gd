extends AudioStreamPlayer2D
@onready var player_animations: AnimatedSprite2D = $"../PlayerAnimations"
@onready var dust_particles: CPUParticles2D = $"../DustParticles"


func _on_player_animations_frame_changed() -> void:
	if player_animations:
		if player_animations.animation == "Run":
			if  player_animations.frame == 3 or player_animations.frame == 7:
				self.pitch_scale = randf_range(.9, 1.1)
				self.play()
				dust_particles.emitting = true

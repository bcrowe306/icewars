extends State
@onready var blood_particles: CPUParticles2D = $"../../BloodParticles"
@onready var boar_hit_sound_player: AudioStreamPlayer2D = $"../../BoarHitSoundPlayer"
@onready var blood_splat_animations: AnimatedSprite2D = $"../../BloodSplatAnimations"


func _enter(previous_state: String):
	animated_sprite.play(animation_name)
	boar_hit_sound_player.stream = PigHitSounds.get_hit_sound()
	blood_splat_animations.playRandom()
	boar_hit_sound_player.play()

	
func state_guard(_next_state: String):
	return timeout_finished or _next_state == "Dying"

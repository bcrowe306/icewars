extends State
@onready var blood_particles: CPUParticles2D = $"../../BloodParticles"
@onready var boar_hit_sound_player: AudioStreamPlayer2D = $"../../BoarHitSoundPlayer"
@onready var blood_splat_animations: AnimatedSprite2D = $"../../BloodSplatAnimations"
@onready var collision_attack: Attack = $"../../CollisionAttack"


func _enter(_previous_state: String):
	collision_attack.finish_attack()
	animated_sprite.play(animation_name)
	boar_hit_sound_player.stream = PigHitSounds.get_hit_sound()
	blood_splat_animations.playRandom()
	boar_hit_sound_player.play()

	
func _exit(_next_attack: String):
	collision_attack.do_attack()
	
func state_guard(_next_state: String):
	return timeout_finished or _next_state == "Dying"

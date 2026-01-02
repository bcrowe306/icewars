extends State
@onready var boar: CharacterBody2D = $"../.."
@onready var hurt_box: HurtBox = $"../../HurtBox"
@onready var blood_particles: CPUParticles2D = $"../../BloodParticles"
@onready var boar_hit_sound_player: AudioStreamPlayer2D = $"../../BoarHitSoundPlayer"
@onready var blood_splat_animations: AnimatedSprite2D = $"../../BloodSplatAnimations"
@onready var collision_attack: Attack = $"../../CollisionAttack"



func _enter(_previous_state: String):
	collision_attack.finish_attack()
	animated_sprite.play(animation_name)
	blood_splat_animations.playRandom()
	hurt_box.monitoring = false
	boar_hit_sound_player.stream = PigHitSounds.get_hit_sound()
	boar_hit_sound_player.play()
	boar.set_collision_layer_value(2,false)
	boar.set_collision_mask_value(2,false)
	boar.set_collision_layer_value(3,false)
	boar.set_collision_mask_value(3,false)

func _on_timeout():
	boar.queue_free()
	
func state_guard(_next_state: String) -> bool:
	return false

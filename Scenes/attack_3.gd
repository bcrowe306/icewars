extends State
@onready var attack_3_weapon_sound: AudioStreamPlayer = $Attack3WeaponSound
@onready var attack_effects: AnimationPlayer = $"../../AttackEffects"
@onready var attack_3_smear: Sprite2D = $"../../Attack3Smear"
@onready var player_controller: PlayerController = $"../.."
@onready var dash_particles_1: CPUParticles2D = $"../../DashParticles1"
@onready var dash_particles_2: CPUParticles2D = $"../../DashParticles2"
@onready var dash_explosion: CPUParticles2D = $"../../DashExplosion"
@onready var attack_3: Attack = $"../../Attack3"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _enter(_previous_state: String):
	animated_sprite.speed_scale = 1
	animated_sprite.offset = Vector2(0,0)
	if abs(player_controller.velocity.x) > 0:
		animated_sprite.play("RunAttack3")
	else:
		animated_sprite.play(animation_name)
	
	

func _exit(_next_state: String):
	attack_3_smear.visible = false
	attack_3.finish_attack()
	

func state_guard(_next_state: String) -> bool:
	if animated_sprite.frame == 7:
		return true
	else:
		return false


func _on_player_animations_frame_changed() -> void:
	if animated_sprite.animation == animation_name or animated_sprite.animation == "RunAttack3":
		
		if animated_sprite.frame == 1:
			player_controller.doDash(4)
			dash_particles_1.emitting = true
			dash_particles_2.emitting = true
			dash_explosion.emitting = true
			attack_effects.play("Attack3Smear")
			self.audio_stream.pitch_scale = randf_range(.95, 1.05)
			self.audio_stream.play()
			attack_3_weapon_sound.pitch_scale = randf_range(.95, 1.05)
			attack_3_weapon_sound.play()
			
		if animated_sprite.frame == 2:
			var hv = attack_3.hit_vector
			if player_controller.facing_direction:
				hv.x = absf(attack_3.hit_vector.x)
			else:
				hv.x = -absf(attack_3.hit_vector.x)
			attack_3.do_attack(hv)
		if animated_sprite.frame == 5:
			attack_3.finish_attack()

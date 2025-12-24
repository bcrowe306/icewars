extends State
@onready var attack_effects: AnimationPlayer = $"../../AttackEffects"
@onready var player_controller: PlayerController = $"../.."
@onready var attack_2_smear: Sprite2D = $"../../Attack2Smear"
@onready var attack_2: Attack = $"../../Attack2"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 

@onready var attack_2_weapon_sound: AudioStreamPlayer = $Attack2WeaponSound

	
func _enter(previous_state: String):
	self.audio_stream.pitch_scale = randf_range(.95, 1.05)
	self.audio_stream.play()
	attack_2_weapon_sound.pitch_scale = randf_range(.95, 1.05)
	attack_2_weapon_sound.play(.05)
	timer.start()
	animated_sprite.speed_scale = 1
	animated_sprite.offset = Vector2(0,0)
	if abs(player_controller.velocity.x) > 0:
		animated_sprite.play("RunAttack2")
	else:
		animated_sprite.play(animation_name)
	if player_controller.facing_direction:
		attack_effects.play("Attack2SmearRight")
	else:
		attack_effects.play("Attack2SmearLeft")
	player_controller.doDash(3)

func _exit(_next_state: String):
	attack_2.finish_attack()
	attack_2_smear.visible = false

func state_guard(_next_state: String) -> bool:
	if animated_sprite.frame == 5:
		return true
	else:
		if not timer.is_stopped():
			if _next_state == "Attack3" or _next_state == "AirAttack":
				return true
				
			else:
				return false
		else:
			if _next_state == "Stomp":
				return true
			else:
				return false


func _on_player_animations_frame_changed() -> void:
	if animated_sprite.animation == animation_name or animated_sprite.animation == "RunAttack2":
		if animated_sprite.frame == 2:
			var hv = attack_2.hit_vector
			if player_controller.facing_direction:
				hv.x = absf(attack_2.hit_vector.x)
			else:
				hv.x = -absf(attack_2.hit_vector.x)
			attack_2.do_attack(hv)
		if animated_sprite.frame == 5:
			attack_2.finish_attack() 

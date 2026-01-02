extends State
@onready var attack_1_weapon_sound: AudioStreamPlayer = $Attack1WeaponSound
@onready var attack_effects: AnimationPlayer = $"../../AttackEffects"
@onready var player_controller: PlayerController = $"../.."
@onready var attack_1_smear: Sprite2D = $"../../Attack1Smear"
@onready var attack_1: Attack = $"../../Attack1"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _exit(_next_state: String):
	attack_1_smear.visible = false
	attack_1.finish_attack()

func _enter(_previous_state: String):
	self.audio_stream.pitch_scale = randf_range(.95, 1.05)
	self.audio_stream.play()
	attack_1_weapon_sound.pitch_scale =  randf_range(.95, 1.05)
	attack_1_weapon_sound.play()
	
	timer.start()
	animated_sprite.speed_scale = 1
	animated_sprite.offset = Vector2(0,0)
	if abs(player_controller.velocity.x) > 0:
		animated_sprite.play("RunAttack1")
	else:
		animated_sprite.play(animation_name)
	if player_controller.facing_direction:
		attack_effects.play("Attack1SmearRight")
	else:
		attack_effects.play("Attack1SmearLeft")
	player_controller.doDash(1)

func state_guard(_next_state: String) -> bool:
	if animated_sprite.frame == 5:
		return true
	else:
		if not timer.is_stopped():
			if _next_state == "Attack2" or _next_state == "AirAttack":
				return true
				
			else:
				return false
		else:
			return false

func _on_player_animations_frame_changed() -> void:
	if animated_sprite.animation == animation_name or animated_sprite.animation == "RunAttack1":
		if animated_sprite.frame == 1:
			var hv = attack_1.hit_vector
			if player_controller.facing_direction:
				hv.x = absf(attack_1.hit_vector.x)
			else:
				hv.x = -absf(attack_1.hit_vector.x)
			attack_1.do_attack(hv)
		if animated_sprite.frame == 5:
			attack_1.finish_attack() 

extends State
@onready var player_controller: PlayerController = $"../.."
@onready var jump_attack: Attack = $"../../JumpAttack"
@onready var attack_1_weapon_sound: AudioStreamPlayer = $"../Attack1/Attack1WeaponSound"
@onready var jump_sound: AudioStreamPlayer = $JumpSound
@onready var human_sound: AudioStreamPlayer = $HumanSound
@onready var wind_flury: AnimatedSprite2D = $"../../WindFlury"

func _enter(_previous_state: String):
	
	if player_controller.is_on_floor():
		player_controller.doJump(true, .5)
		jump_sound.play()
	else:
		pass
	animated_sprite.play(animation_name, 1.5)
	wind_flury.playAnimation()
	
	
func _update(_delta: float):
	pass
	
func _exit(_next_state: String):
	pass
	
func state_guard(_next_state: String) -> bool:
	if animated_sprite.animation == animation_name and animated_sprite.frame == 6:
		return true
	else:
		if player_controller.is_on_floor():
			return true
		else:
			return false
			
func _on_player_animations_frame_changed() -> void:
	if animated_sprite.animation == animation_name and active:
		if animated_sprite.frame == 1:
			jump_attack.do_attack(jump_attack.hit_vector)
			attack_1_weapon_sound.pitch_scale =  randf_range(.95, 1.05)
			attack_1_weapon_sound.play()
		if animated_sprite.frame == 4:
			jump_attack.finish_attack() 
	
	

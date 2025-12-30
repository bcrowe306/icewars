extends State

@onready var backflip_kick_attack: Attack = $"../../BackflipKickAttack"
@onready var backfilp_attack_sound: AudioStreamPlayer = $BackfilpAttackSound
@onready var player_hurt_box: HurtBox = $"../../PlayerHurtBox"


func _enter(_previous_state: String):
	player_hurt_box.disable_hurtbox()
	animated_sprite.play(animation_name)
	
func _update(_delta: float):
	pass
	
func _exit(_next_state: String):
	backflip_kick_attack.finish_attack()
	

func state_guard(_next_state: String) -> bool:
	if animated_sprite.frame > 4:
		return true
	else:
		return false

func _on_player_animations_frame_changed() -> void:
	if animated_sprite.animation == animation_name:
		if animated_sprite.frame == 1:
			backfilp_attack_sound.play()
		if animated_sprite.frame == 3:
			backflip_kick_attack.do_attack(backflip_kick_attack.hit_vector) 

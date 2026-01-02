extends State
@onready var collide_attack: Attack = $"../../CollideAttack"
@onready var snail_sound_player: AudioStreamPlayer2D = $"../../SnailSoundPlayer"
@onready var snail: Snail = $"../.."
@onready var snail_hurt_box: HurtBox = $"../../SnailHurtBox"
@onready var collide_hit_box: HitBox = $"../../CollideAttack/HitBox"


func _enter(_previous_state: String):
	snail_hurt_box.disable_hurtbox()
	collide_hit_box.disable_hitbox()
	snail.set_collision_mask_value(2,0)
	snail.set_collision_layer_value(3,0)
	collide_attack.finish_attack()
	snail_sound_player.stream = SnailHitSounds.get_dying_sound()
	snail_sound_player.play()
	animated_sprite.play(animation_name)

func _update(_delta: float):
	pass
	
func _exit(_next_state: String):
	pass	
	
func state_guard(_next_state: String):
	pass

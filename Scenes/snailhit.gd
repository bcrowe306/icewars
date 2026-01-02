extends State
@onready var collide_attack: Attack = $"../../CollideAttack"
@onready var snail_sound_player: AudioStreamPlayer2D = $"../../SnailSoundPlayer"
@onready var snail: Snail = $"../.."
const BLOOD_GFX = preload("res://Scenes/blood_gfx.tscn")

func _enter(_previous_state: String):
	collide_attack.finish_attack()
	snail_sound_player.stream = SnailHitSounds.get_hit_sound()
	snail_sound_player.play()
	create_blood_fx()
	animated_sprite.play(animation_name)

func _update(_delta: float):
	pass
	
func _exit(_next_state: String):
	collide_attack.do_attack()
	
func state_guard(_next_state: String):
	if animated_sprite.animation == animation_name and animated_sprite.frame == 15:
		return true

	if _next_state == "Dying":
		return true
	
	return false
	
func create_blood_fx():
	var new_bloodfx := BLOOD_GFX.instantiate()
	new_bloodfx.position = snail.position
	snail.get_parent().add_child(new_bloodfx)
	new_bloodfx.playFX()

extends State

@onready var player_hurt_box: HurtBox = $"../../PlayerHurtBox"
@onready var hit_sound_player_2d: AudioStreamPlayer2D = $HitSoundPlayer2D

func _enter(_previous_state: String):
	player_hurt_box.disable_hurtbox()
	hit_sound_player_2d.stream = PlayerHitSounds.get_hit_sound()
	hit_sound_player_2d.play()
	animated_sprite.play(animation_name)
	
	
func _exit(_next_state: String):
	timer.start()

func state_guard(_next_state: String) -> bool:
	return timeout_finished


func _on_recover_timer_timeout() -> void:
	player_hurt_box.enable_hurtbox() # Replace with function body.

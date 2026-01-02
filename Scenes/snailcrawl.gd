extends State
@onready var collide_attack: Attack = $"../../CollideAttack"
@onready var crawl_sound: AudioStreamPlayer2D = $CrawlSound


func _enter(_previous_state: String):
	collide_attack.do_attack()
	animated_sprite.play(animation_name)

func _update(_delta: float):
	pass
	
func _exit(_next_state: String):
	pass
	
func state_guard(_next_state: String):
	pass


func _on_animated_sprite_2d_frame_changed() -> void:
	if animated_sprite.animation == animation_name and animated_sprite.frame == 4:
		crawl_sound.play()

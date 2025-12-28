extends State
@onready var icewave_blast: AnimatedSprite2D = $"../../IcewaveBlast"
@onready var player_controller: PlayerController = $"../.."
const ICE_WAVE_PROJ_2 = preload("res://Scenes/ice_wave_proj_2.tscn")
@onready var icewave_blast_sfx: AudioStreamPlayer2D = $IcewaveBlastSFX
@onready var charge_player: AudioStreamPlayer2D = $"../IcewaveCharge/ChargePlayer"

func _enter(_previous_state: String):
	animated_sprite.play(animation_name)
	icewave_blast.visible = true
	
	
func _update(_delta: float):
	pass
	
func _exit(_next_state: String):
	pass
	
func state_guard(_next_state: String):
	
	return animated_sprite.frame == 4


func _on_player_animations_frame_changed() -> void:
	if animated_sprite.animation == animation_name and animated_sprite.frame == 1:
		charge_player.stop()
		icewave_blast.play("default")# Replace with function body.
		icewave_blast_sfx.play()
		var new_iw: IcewaveProjectile2 = ICE_WAVE_PROJ_2.instantiate()
		new_iw.position = player_controller.position
		player_controller.get_parent().add_child(new_iw)
		if player_controller.facing_direction:
			
			new_iw.set_direction(Vector2(1, 0))
		else:
			new_iw.set_direction(Vector2(-1, 0))
		
		

extends State
@onready var jump_poof: CPUParticles2D = $"../../JumpPoof"
@onready var jump_sound: AudioStreamPlayer = $"../Jump/JumpSound"
@onready var jump_impact: AudioStreamPlayer = $JumpImpact
@onready var jump_2_dash: AnimatedSprite2D = $"../../Jump2Dash"
@onready var jump_2_explosion: CPUParticles2D = $"../../Jump2Explosion"
const JUMP_WIND_1 = preload("res://Scenes/jump_wind_1.tscn")
@onready var player_controller: PlayerController = $"../.."
@onready var jump_attack: Attack = $"../../JumpAttack"
@onready var attack_1_weapon_sound: AudioStreamPlayer = $"../Attack1/Attack1WeaponSound"

func _enter(previous_state: String):
	var new_wind := JUMP_WIND_1.instantiate()
	new_wind.position = player_controller.position
	player_controller.get_parent().add_child(new_wind)
	new_wind.play("default")
	self.audio_stream.pitch_scale = randf_range(.95, 1.05)
	self.audio_stream.play()
	jump_sound.pitch_scale = randf_range(.95, 1.05)
	jump_sound.play()
	jump_impact.play()
	animated_sprite.speed_scale = 1
	animated_sprite.offset = Vector2(0,0)
	animated_sprite.play(animation_name)
	jump_poof.emitting = true
	jump_2_explosion.emitting = true
	
func _exit(_next_state: String):
	jump_attack.finish_attack()
	
func _on_player_animations_frame_changed() -> void:
	if animated_sprite.animation == animation_name and active:
		if animated_sprite.frame == 1:
			jump_attack.do_attack(jump_attack.hit_vector)
			attack_1_weapon_sound.pitch_scale =  randf_range(.95, 1.05)
			attack_1_weapon_sound.play()
		if animated_sprite.frame == 4:
			jump_attack.finish_attack() 

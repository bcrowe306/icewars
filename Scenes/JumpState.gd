extends State
@onready var human_sound: AudioStreamPlayer = $HumanSound
@onready var jump_sound: AudioStreamPlayer = $JumpSound
const JUMP_WIND_SMALL = preload("res://Scenes/jump_wind_small.tscn")
@onready var player_controller: PlayerController = $"../.."

func _enter(previous_state: String):
	var new_jump_wind := JUMP_WIND_SMALL.instantiate()
	new_jump_wind.position = player_controller.position
	player_controller.get_parent().add_child(new_jump_wind)
	new_jump_wind.visible
	new_jump_wind.play("default")
	
	self.audio_stream.pitch_scale = randf_range(.95, 1.05)
	self.audio_stream.play()
	jump_sound.pitch_scale = randf_range(.95, 1.05)
	jump_sound.play()
	animated_sprite.speed_scale = 1
	animated_sprite.offset = Vector2(0,0)
	animated_sprite.play(animation_name)

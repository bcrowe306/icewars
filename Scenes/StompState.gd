extends State
@onready var player_controller: PlayerController = $"../.."
@onready var stomp_particles: CPUParticles2D = $"../../StompParticles"
@onready var stomp_attack: Attack = $"../../StompAttack"


func _enter(_previous_state: String):
	stomp_attack.do_attack(stomp_attack.hit_vector)
	stomp_particles.emitting = true
	self.audio_stream.pitch_scale = randf_range(.95, 1.05)
	self.audio_stream.play()
	player_controller.gravity_multiplier = 4
	animated_sprite.speed_scale = 1
	animated_sprite.offset = Vector2(0,0)
	animated_sprite.play(animation_name)
	
func _exit(_next_state: String):
	stomp_particles.emitting = false
	player_controller.gravity_multiplier = 1
	stomp_attack.finish_attack()

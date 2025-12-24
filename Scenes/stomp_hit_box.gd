extends HitBox
@onready var bounce_sound: AudioStreamPlayer2D = $"../BounceSound"
@onready var punch_sound: AudioStreamPlayer2D = $"../PunchSound"
@onready var stomp_attack: Attack = $".."
const SMOKE_BURST = preload("res://Scenes/smoke_burst.tscn")
@onready var player_controller: PlayerController = $"../.."


func _on_hit_registered(target: Node) -> void:
	stomp_attack.finish_attack()
	var new_smoke_burst := SMOKE_BURST.instantiate()
	new_smoke_burst.position = player_controller.position
	new_smoke_burst.visible = true
	
	player_controller.get_parent().add_child(new_smoke_burst)
	new_smoke_burst.playAnimation()
	
	bounce_sound. pitch_scale = randf_range(.8, 1.2)
	bounce_sound.play() # Replace with function body.
	punch_sound.play()
	
	
	
	

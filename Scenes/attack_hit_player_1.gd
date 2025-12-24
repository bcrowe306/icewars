extends AudioStreamPlayer2D
@onready var attack_hit_thump: AudioStreamPlayer2D = $"../AttackHitThump"


var hit_sounds: Array[ AudioStreamWAV ]
const DESIGNED_PUNCH_1 = preload("res://Assets/SFX/Darkworld Audio - Survival Effects [Free]/Combat/DesignedPunch1.wav")
const DESIGNED_PUNCH_2 = preload("res://Assets/SFX/Darkworld Audio - Survival Effects [Free]/Combat/DesignedPunch2.wav")
const DESIGNED_PUNCH_3 = preload("res://Assets/SFX/Darkworld Audio - Survival Effects [Free]/Combat/DesignedPunch3.wav")
const DESIGNED_PUNCH_4 = preload("res://Assets/SFX/Darkworld Audio - Survival Effects [Free]/Combat/DesignedPunch4.wav")
var hit_sound_index: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hit_sounds = [
		DESIGNED_PUNCH_1,DESIGNED_PUNCH_2,DESIGNED_PUNCH_3,DESIGNED_PUNCH_4
	] 

func playHitSound():
	hit_sound_index = (hit_sound_index +  1) % hit_sounds.size()
	stream = hit_sounds[hit_sound_index]
	play()


func _on_player_attack_1_hitbox_hit_registered(target: Node) -> void:
	playHitSound() 
	attack_hit_thump.pitch_scale = randf_range(.9, 1.2)
	attack_hit_thump.play()


func _on_attack_2_hitbox_hit_registered(target: Node) -> void:
	playHitSound() 
	attack_hit_thump.pitch_scale = randf_range(.9, 1.2)
	attack_hit_thump.play() 


func _on_attack_3_hitbox_hit_registered(target: Node) -> void:
	playHitSound() 
	attack_hit_thump.pitch_scale = randf_range(.9, 1.2)
	attack_hit_thump.play() 


func _on_hit_box_hit_registered(target: Node) -> void:
	playHitSound() 
	attack_hit_thump.pitch_scale = randf_range(.9, 1.2)
	attack_hit_thump.play()  

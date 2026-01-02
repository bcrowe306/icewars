extends Area2D

class_name BouncerPlatform
@onready var bounce_animation_player: AnimationPlayer = $BounceAnimationPlayer
const BOUNCE_TWANG_SPRING_SHORT_02 = preload("res://Assets/SFX/BounceSFX/BOUNCE Twang Spring Short 02.ogg")
const BOUNCE_TWANG_SPRING_SHORT_03 = preload("res://Assets/SFX/BounceSFX/BOUNCE Twang Spring Short 03.ogg")
var bounces_sounds: Array[AudioStreamOggVorbis] = [
	BOUNCE_TWANG_SPRING_SHORT_02,
	BOUNCE_TWANG_SPRING_SHORT_03
]
var sound_index: int = 0
@export var bounce_velocity: float = 1.5
@onready var bounce_sfx_player: AudioStreamPlayer2D = $BounceSFXPlayer

func _ready() -> void:
	body_entered.connect(self._on_body_entered )
	

func _on_body_entered(body: Node2D):
	if body is PlayerController:
		if body.velocity.y > 0:
			bounce_animation_player.play("Bounce")
			body.position.y = self.position.y - 20
			body.resetJumpCount()
			body.velocity.y = -body.velocity.y
			body.doJump(true, bounce_velocity)
			playBounceSFX()

func playBounceSFX():
	sound_index = (sound_index + 1) % bounces_sounds.size()
	bounce_sfx_player.stream = bounces_sounds[sound_index]
	bounce_sfx_player.pitch_scale = randf_range(.8, 1.2)
	bounce_sfx_player.play()

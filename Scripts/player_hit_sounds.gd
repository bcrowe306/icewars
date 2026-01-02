extends Node
const VOCAL_CUTE_DISTRESS_PAIN_08 = preload("res://Assets/SFX/PenguineSounds/VOCAL CUTE Distress Pain 08.ogg")
const VOCAL_CUTE_DISTRESS_PAIN_10 = preload("res://Assets/SFX/PenguineSounds/VOCAL CUTE Distress Pain 10.ogg")
const VOCAL_CUTE_DISTRESS_PAIN_CALL_12 = preload("res://Assets/SFX/PenguineSounds/VOCAL CUTE Distress Pain Call 12.ogg")
const VOCAL_CUTE_DISTRESS_PAIN_CALL_14 = preload("res://Assets/SFX/PenguineSounds/VOCAL CUTE Distress Pain Call 14.ogg")
var hit_sound_index: int = 0
var hit_sounds: Array[AudioStreamOggVorbis]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hit_sounds = [
		VOCAL_CUTE_DISTRESS_PAIN_08,
		VOCAL_CUTE_DISTRESS_PAIN_10,
		VOCAL_CUTE_DISTRESS_PAIN_CALL_12,
		VOCAL_CUTE_DISTRESS_PAIN_CALL_14
	]
	
	
	
func get_hit_sound() -> AudioStreamOggVorbis:
	hit_sound_index = (hit_sound_index +  1) % hit_sounds.size()
	return hit_sounds[hit_sound_index]
	

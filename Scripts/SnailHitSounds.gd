extends Node
const VOCAL_CUTE_DISTRESS_PAIN_02 = preload("res://Assets/SFX/SnailSFX/VOCAL CUTE Distress Pain 02.ogg")
const VOCAL_CUTE_DISTRESS_PAIN_03 = preload("res://Assets/SFX/SnailSFX/VOCAL CUTE Distress Pain 03.ogg")
const VOCAL_CUTE_DISTRESS_PAIN_04 = preload("res://Assets/SFX/SnailSFX/VOCAL CUTE Distress Pain 04.ogg")
const VOCAL_CUTE_DISTRESS_PAIN_05 = preload("res://Assets/SFX/SnailSFX/VOCAL CUTE Distress Pain 05.ogg")
const VOCAL_CUTE_DISTRESS_PAIN_06 = preload("res://Assets/SFX/SnailSFX/VOCAL CUTE Distress Pain 06.ogg")
const VOCAL_CUTE_DISTRESS_PAIN_09 = preload("res://Assets/SFX/SnailSFX/VOCAL CUTE Distress Pain 09.ogg")
const VOCAL_CUTE_DISTRESS_PAIN_11 = preload("res://Assets/SFX/SnailSFX/VOCAL CUTE Distress Pain 11.ogg")
const VOCAL_CUTE_DISTRESS_PAIN_13 = preload("res://Assets/SFX/SnailSFX/VOCAL CUTE Distress Pain 13.ogg")

var snail_hit_sounds: Array[AudioStreamOggVorbis] = []
var snail_dying_sounds: Array[AudioStreamOggVorbis] = []
var sound_index: int = 0
var dying_index: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	snail_hit_sounds = [
		VOCAL_CUTE_DISTRESS_PAIN_02,
		VOCAL_CUTE_DISTRESS_PAIN_03,
		VOCAL_CUTE_DISTRESS_PAIN_04,
		VOCAL_CUTE_DISTRESS_PAIN_05
	]
	snail_dying_sounds = [
		VOCAL_CUTE_DISTRESS_PAIN_06,
		VOCAL_CUTE_DISTRESS_PAIN_09,
		VOCAL_CUTE_DISTRESS_PAIN_11,
		VOCAL_CUTE_DISTRESS_PAIN_13
	]

	
	
	
func get_hit_sound() -> AudioStreamOggVorbis:
	sound_index = (sound_index +  1) % snail_hit_sounds.size()
	return snail_hit_sounds[sound_index]
	
func get_dying_sound() -> AudioStreamOggVorbis:
	dying_index = (dying_index +  1) % snail_dying_sounds.size()
	return snail_dying_sounds[dying_index]
	
	

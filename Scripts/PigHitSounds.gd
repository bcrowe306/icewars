extends Node

var audioPlayer: AudioStreamPlayer = AudioStreamPlayer.new()
const HIT_SOUND_001 = preload("res://Assets/SFX/Pig Sounds/Hit Sound-001.wav")
const HIT_SOUND_002 = preload("res://Assets/SFX/Pig Sounds/Hit Sound-002.wav")
const HIT_SOUND_003 = preload("res://Assets/SFX/Pig Sounds/Hit Sound-003.wav")
const HIT_SOUND_004 = preload("res://Assets/SFX/Pig Sounds/Hit Sound-004.wav")
const HIT_SOUND_005 = preload("res://Assets/SFX/Pig Sounds/Hit Sound-005.wav")
var hit_sound_index: int = 0
var hit_sounds: Array[AudioStreamWAV]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hit_sounds = [
		HIT_SOUND_001,
		HIT_SOUND_002,
		HIT_SOUND_003,
		HIT_SOUND_004,
		HIT_SOUND_005
	]
	
	
	
func get_hit_sound() -> AudioStreamWAV:
	hit_sound_index = (hit_sound_index +  1) % hit_sounds.size()
	return hit_sounds[hit_sound_index]
	

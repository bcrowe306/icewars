extends Node2D
@onready var main_camera: Camera2D = $CharacterBody2D/MainCamera
@onready var main_hitstop: Node = $MainHitstop


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CameraShakeManager2.main_camera = main_camera
	HitstopManager.hitstop =  main_hitstop# Replace with function body.

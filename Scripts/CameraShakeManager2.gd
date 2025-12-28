extends Node

var main_camera: Camera2D


func apply_shake(weight: float):
	if main_camera and main_camera is Camera2D:
		main_camera.apply_shake(weight)

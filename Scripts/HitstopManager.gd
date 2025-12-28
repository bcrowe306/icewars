extends Node

var hitstop: Hitstop
# Called when the node enters the scene tree for the first time.

func triggerHitstop(weight: float):
	if hitstop and hitstop is Hitstop:
		hitstop.trigger_hitstop(weight)

extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_finished.connect( self.on_finished ) # Replace with function body.

func playAnimation():
	visible = true
	play("default")
	
func on_finished():
	visible = false
	
	

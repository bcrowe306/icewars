extends AnimatedSprite2D
class_name BloodGFX

var animations: PackedStringArray

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animations = sprite_frames.get_animation_names()
	self.visible = false
	animation_finished.connect(self.on_finished) # Replace with function body.

func playFX():
	self.visible = true
	self.animation = animations[randi_range(0,animations.size() -1)]
	self.flip_h = bool(randi_range(0,1))
	self.play()
	
func on_finished():
	self.visible = false
	self.queue_free()

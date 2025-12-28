extends AnimatedSprite2D

var animation_names: Array[String] = ["A","B","C"]
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	animation_finished.connect(on_finished) # Replace with function body.



func on_finished():
	visible = false
	queue_free()
	
func playAnimation():
	visible = true
	#var animation_name = animation_names[ randi_range(0,2)]
	self.play(animation_names[randi_range(0,2)])

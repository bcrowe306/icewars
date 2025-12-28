extends CharacterBody2D
class_name IcewaveProjectile
@onready var icewave_attack: Attack = $IcewaveAttack
@onready var projectile_anims: AnimatedSprite2D = $ProjectileAnims

func _ready() -> void:
	projectile_anims.play()

const SPEED = 700.0
var direction: Vector2 = Vector2.ZERO

func set_direction(dir: Vector2):
	direction = dir
	
	#icewave_attack.hit_vector = dir
	
func _physics_process(delta: float) -> void:
	if direction.x > 0:
		projectile_anims.flip_h = false
	elif direction.x < 0:
		projectile_anims.flip_h = true
	velocity.x = direction.x * SPEED


	if move_and_slide():
		self.queue_free()

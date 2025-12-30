extends HitBox
class_name IcewaveProjectile2
@onready var collision_shape_2d_2: CollisionShape2D = $CollisionShape2D2
@onready var impact_sound_1: AudioStreamPlayer2D = $ImpactSound1
@onready var impact_explosion: AudioStreamPlayer2D = $ImpactExplosion
@onready var queue_free_timer: Timer = $QueueFreeTimer
@onready var wind_impact_anims: AnimatedSprite2D = $WindImpactAnims
@onready var trail_particles: CPUParticles2D = $TrailParticles

@onready var projectile_anims: AnimatedSprite2D = $ProjectileAnims
@onready var icewave_attack_2: Attack = $IcewaveAttack2

const SPEED = 2000.0
var direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO
var is_hit = false

func set_direction(dir: Vector2):
	direction = dir
	wind_impact_anims.rotation = randf_range(0,1)
	if direction.x > 0:
		projectile_anims.flip_h = false
		projectile_anims.position.x = -abs(projectile_anims.position.x)
		wind_impact_anims.position.x = abs(wind_impact_anims.position.x)
		trail_particles.position.x = abs(trail_particles.position.x)
		collision_shape_2d_2.position.x = abs(collision_shape_2d_2.position.x)
	elif direction.x < 0:
		projectile_anims.flip_h = true
		projectile_anims.position.x = abs(projectile_anims.position.x)
		wind_impact_anims.position.x = -abs(wind_impact_anims.position.x)
		trail_particles.position.x = -abs(trail_particles.position.x)
		collision_shape_2d_2.position.x = -abs(collision_shape_2d_2.position.x)
	#icewave_attack.hit_vector = dir
	hit_vector = icewave_attack_2.hit_vector
	hit_vector.x = direction.x
	
func _ready() -> void:
	self.area_entered.connect(self._on_area_entered)
	self.body_entered.connect(self._on_body_entered)
	self.area_exited.connect(self._on_area_exited)
	
	
	# Gather all collision shapes
	_gather_collision_shapes()
	
	# Disable collision shapes by default
	#disable_hitbox()
	_on_ready()
	parent_attack = icewave_attack_2
	monitoring = true
	enable_hitbox()
	projectile_anims.play("default")
	trail_particles.emitting = true
	
	
func _process(delta: float) -> void:
	if not is_hit:
		position.x += SPEED * delta * direction.x 
	
	var bodies := get_overlapping_bodies()
	var areas := get_overlapping_areas()
	if not bodies.is_empty():
		hit()
		
	if not areas.is_empty():
		hit()


func _on_hit_registered(target: Node) -> void:
	icewave_attack_2.finish_attack()
	
	CameraShakeManager2.apply_shake(icewave_attack_2.camera_shake)
	HitstopManager.triggerHitstop(icewave_attack_2.hitstop)
	wind_impact_anims.visible = true
	wind_impact_anims.play("default")
	impact_sound_1.play()
	impact_explosion.play() # Replace with function body.
	
func _on_queue_free_timer_timeout() -> void:
	queue_free() # Replace with function body.
	

func hit(success: bool = true):
	trail_particles.emitting = false
	is_hit = true
	self.monitoring = false
	collision_shape_2d_2.disabled = true
	if queue_free_timer.is_stopped():
		projectile_anims.visible = false
		queue_free_timer.start()
			

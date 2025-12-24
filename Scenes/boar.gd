extends CharacterBody2D
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var collision_attack: Attack = $CollisionAttack
@onready var sm: StateMachine = $BoarStateMachine
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var boar_hit_sound_player: AudioStreamPlayer2D = $BoarHitSoundPlayer
@onready var boar_knockback_controller: Node = $BoarKnockbackController

@export var stats: Stats
var direction: float = 1

func _ready() -> void:
	collision_attack.do_attack()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		rotation = get_floor_normal().angle() + deg_to_rad(90)


	if ray_cast_left.is_colliding():
		direction = 1
	
	if ray_cast_right.is_colliding():
		direction = -1
		
	
	if sm.state == "Walk" or sm.state == "Run" or sm.state == "Idle":
		velocity.x = direction * stats.speed * .5
		if direction == 1:
			animated_sprite_2d.flip_h = true
		else:
			animated_sprite_2d.flip_h = false
		move_and_slide()
	else:
		# Hit State
		if sm.state == "Hit":
			if is_on_floor():
				velocity.x += direction * 400  * delta
			if velocity.x > 0:
				animated_sprite_2d.flip_h = true
			
			if velocity.x < 0:
				animated_sprite_2d.flip_h = false
			
			move_and_slide()
		# Dying State
		else:
			if velocity.x > 0:
				animated_sprite_2d.flip_h = true
			
			if velocity.x < 0:
				animated_sprite_2d.flip_h = false
			
			
		
	determineState()
	
	
func determineState():
	if abs(velocity.x) > 0:
		if abs(velocity.x) > 100:
			sm.state = "Run"
			
		else:
			sm.state = "Walk"
	


func _on_hurt_box_damaged(attack: Attack, hit_vector: Vector2, amount: float, new_health: float) -> void:
	if new_health > 0.0:
		if sm.state == "Hit":
			var hitstate := sm.get_state("Hit")
			hitstate.reset_counters()
			hitstate._enter("Hit")
			
		else:
			sm.state = "Hit"
	else:
		sm.state = "Dying"

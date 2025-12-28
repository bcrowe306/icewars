extends KnockbackController


func _on_hurt_box_damaged(attack: Attack, hit_vector: Vector2, _amount: float, _new_health: float) -> void:
	do_knockback(hit_vector, clampf(attack.knockback, 0, 1.0))

extends KnockbackController


func _on_hurt_box_damaged(attack: Attack, hit_vector: Vector2, amount: float, new_health: float) -> void:
	print(attack.knockback, hit_vector)
	do_knockback(hit_vector, clampf(attack.knockback, 0, 1.0))

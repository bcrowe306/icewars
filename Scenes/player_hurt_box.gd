extends HurtBox


func _on_attack_started() -> void:
	disable_hurtbox()


func _on_attack_finished() -> void:
	enable_hurtbox()

extends Hitstop



func _on_character_body_2d_attack_successful(attack: Attack) -> void:
	trigger_hitstop(attack.hitstop) # Replace with function body.

extends Area2D

func _on_body_entered(body):
	if body.is_in_group("Player"):
		if not GameManager.has_pickaxe:
			print("You need a pickaxe to use this portal!")
			# Optional: play locked sound or show UI message
			return

		# Player has the pickaxe → go to ending scene
		get_tree().change_scene_to_file("res://scenes/ending_scene.tscn")

extends Area2D

func _on_cutscene_transition_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("entered")
		get_tree().change_scene_to_file("res://scenes/cutscene.tscn")

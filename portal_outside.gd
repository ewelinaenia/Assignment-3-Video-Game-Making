extends Area2D


@export var target_scene : String
@export var target_spawn : String = "SpawnPoint"

func _on_body_entered(body):
	if body.name == "Player":
		var new_scene = load(target_scene).instantiate()
		get_tree().change_scene_to_packed(load(target_scene))

		# Save the spawn name so the new scene knows where to place player
		body.set_meta("spawn_target", target_spawn)

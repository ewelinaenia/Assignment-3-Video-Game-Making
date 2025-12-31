extends Area2D


#@export var target_scene : String
#@export var target_spawn : String = "SpawnPoint"

func _on_body_entered(body):
	if body.is_in_group("Player"):
		#print("collided")
		
		if not GameManager.has_key:
			print("Portal is locked")
			return  # stop here
		
		var current_scene_file = get_tree().current_scene.scene_file_path
		var next_scene_file = ""
		
		if current_scene_file == "res://scenes/outdoors.tscn":
			next_scene_file = "res://scenes/outdoors_2.tscn"
		elif current_scene_file == "res://scenes/outdoors_2.tscn":
			next_scene_file = "res://scenes/outdoors.tscn"
			GameManager.spawn_target = "SpawnPoint"
			
		#print(next_scene_file)
		#get_tree().change_scene_to_file(next_scene_file)
		SceneTransition.change_scene(next_scene_file)

		#var new_scene = load(target_scene).instantiate()
		#get_tree().change_scene_to_packed(load(target_scene))
#
		## Save the spawn name so the new scene knows where to place player
		#body.set_meta("spawn_target", target_spawn)

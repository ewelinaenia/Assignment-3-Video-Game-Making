extends StaticBody2D

signal pickaxe_collected
@export var item: InventoryItem
var player = null
var axetaken = false

func _on_interactible_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and not axetaken:
		axetaken = true
		GameManager.has_pickaxe = true
		player = body
		playercollect()
		emit_signal("pickaxe_collected")
		queue_free()
		#if axetaken == false:
			#axetaken = true
			#GameManager.has_pickaxe = true
			#queue_free()
			#emit_signal("pickaxe_collected")
		#player = body
		#playercollect()
		#await get_tree().create_timer(0.1).timeout
		#self.queue_free()
	
func playercollect():
	player.collect(item)

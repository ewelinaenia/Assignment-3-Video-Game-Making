extends StaticBody2D

signal key_collected
@export var item: InventoryItem
var player = null
var keytaken = false

func _on_interactible_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if keytaken == false:
			keytaken = true
			GameManager.has_key = true
			emit_signal("key_collected")
		player = body
		playercollect()
		await get_tree().create_timer(0.1).timeout
		self.queue_free()
	
func playercollect():
	player.collect(item)

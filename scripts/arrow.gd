extends Node2D

var velocity_:Vector2

func set_velocity(velocity:Vector2):
	velocity_ = velocity

func _physics_process(delta: float) -> void:
	look_at(position+velocity_)
	position += velocity_ * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(velocity_.length())


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

extends StaticBody2D

#var can_open: bool = false
@onready var doorL: CollisionShape2D = $CollisionShape2D
@onready var doorR: CollisionShape2D = $CollisionShape2D2

func _ready() -> void:
	doorL.disabled = false
	doorR.disabled = false

func _on_lu_card_card_collected() -> void:
	doorL.set_deferred("disabled",true)
	doorR.set_deferred("disabled",true)
	print("opened")

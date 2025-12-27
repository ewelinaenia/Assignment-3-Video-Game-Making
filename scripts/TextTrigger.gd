extends Area2D

@onready var label = $Label
@onready var label_2 = get_node_or_null("Label2")

func _ready():
	label.visible = false 
	if label_2 != null:
		label_2.visible = false 

func _on_body_entered(body):
	if body.is_in_group("Player"):
		label.visible = true
		if label_2 != null:
			label_2.visible = true


func _on_body_exited(body):
	if body.is_in_group("Player"):
		label.visible = false
		if label_2 != null:
			label_2.visible = false 
			

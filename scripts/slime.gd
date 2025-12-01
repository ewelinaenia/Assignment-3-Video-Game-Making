'''
TODO:
	1. Change slime animation to wold
	2. Integrate and test with the player
'''
extends CharacterBody2D

var speed = 0.7
var health = 100

var dead = false
var player_in_area = false
var player 

func _ready():
	dead = false
	
func _physics_process(_delta: float) -> void:
	if not dead:
		$detection/CollisionShape2D.disabled = false
		if player_in_area:
			position += (player.position - position).normalized() * speed 
			$AnimatedSprite2D.play("move")
		else:
			$AnimatedSprite2D.play("idle")
	else:
		$detection/CollisionShape2D.disabled = true


func _on_detection_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player = body
		player_in_area = true


func _on_detection_body_exited(body: Node2D) -> void:
	if body.name == "player":
		player_in_area = false

func enemy():
	pass


func _on_hitbox_area_entered(area: Area2D) -> void:
	var damage
	if area.has_method("attack"):
		damage = 50
		take_damage(damage)
		
func take_damage(damage):
	health = health - damage
	if health <= 0 and !dead:
		death()
		
func death():
	dead = true
	$AnimatedSprite2D.play("death")
	await get_tree().create_timer(1).timeout
	queue_free()
	
	
	
	
	
	
	

extends CharacterBody2D

#TODO invincibility frames...?

var knockback = Vector2.ZERO
var knockback_timer = 0.0
var health = 100
var speed = 100.0
var player_state
var death_animation_played = false

@export var bag: Inventory

func _physics_process(delta: float) -> void:
	if player_state != "dead":
		var direction = Input.get_vector("left", "right", "up", "down")
		if knockback_timer > 0.0:
			velocity = knockback
			knockback_timer -= delta
			if knockback_timer <= 0.0:
				knockback = Vector2.ZERO
			$AnimatedSprite2D.play("HURT")
		else:
			
			if direction.x == 0 and direction.y == 0:
				player_state = "idle"
			elif direction.x != 0 or direction.y != 0:
				player_state = "walking"
			
			velocity = direction * speed
			play_animation(direction)
		move_and_slide()
		
	elif !death_animation_played:
		death_animation_played = true
		play_animation(0)
	
func play_animation(direction):
	if player_state == "idle":
		$AnimatedSprite2D.play("idle")
	elif player_state == "walking":
		if direction.y == -1:
			$AnimatedSprite2D.play("n-walk")
		elif direction.x == 1:
			$AnimatedSprite2D.play("e-walk")
		elif direction.y == 1:
			$AnimatedSprite2D.play("s-walk")
		elif direction.x == -1:
			$AnimatedSprite2D.play("w-walk")
		# diagonal walk
		elif direction.x > 0.5 and direction.y < -0.5:
			$AnimatedSprite2D.play("ne-walk")
		elif direction.x > 0.5 and direction.y > 0.5:
			$AnimatedSprite2D.play("se-walk")
		elif direction.x > -0.5 and direction.y < -0.5:
			$AnimatedSprite2D.play("nw-walk")
		elif direction.x < -0.5 and direction.y > 0.5:
			$AnimatedSprite2D.play("sw-walk")
	elif player_state == "dead":
		$AnimatedSprite2D.play("death")
			

func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		health -= 20
		var knockback_direction = (position - body.position).normalized()
		apply_knockback(knockback_direction, 200, 0.15)
	if health <= 0:
		player_state = "dead"
	
func apply_knockback(direction: Vector2, force: float, duration: float) -> void:
	knockback = direction * force
	knockback_timer = duration
		

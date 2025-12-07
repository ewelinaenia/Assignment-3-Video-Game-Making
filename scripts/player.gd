extends CharacterBody2D

#TODO invincibility frames...?

var knockback_force = 100
var health = 100
var speed = 100.0
var player_state
var death_animation_played = false

var knockback = Vector2.ZERO
var knockback_timer = 0.0

@export var bag: Inventory

#temp
var max_temperature: float = 100.0
var temperature: float = 100.0

var temp_loss_per_sec: float = 5.0
var temp_gain_per_sec: float = 20.0

var near_fire: bool = false
@onready var temperature_bar: ProgressBar = $"../CanvasLayer2/TemperatureBar"
var bow:Node2D

func _ready() -> void:
	bow = $Bow
	
func is_player()->bool:
	return true

func _physics_process(delta: float) -> void:
	if player_state != "dead":
		if knockback_timer > 0.0:
			velocity = knockback
			knockback_timer -= delta
			if knockback_timer <= 0.0:
				knockback = Vector2.ZERO
		else:
			var direction = Input.get_vector("left", "right", "up", "down")
			
			if direction.x == 0 and direction.y == 0:
				player_state = "idle"
			elif direction.x != 0 or direction.y != 0:
				player_state = "walking"
			
			play_animation(direction)
			velocity = direction * speed
		move_and_slide()
	
		
	elif !death_animation_played:
		death_animation_played = true
		play_animation(0)
#temp
func _process(delta: float) -> void:
	_update_temperature(delta)
	_update_ui()
	bow.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("use_item"):
		bow.charging()
	if Input.is_action_just_released("use_item"):
		bow.shoot()
	
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
			
func collect(item):
	bag.insert(item)

func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		health -= 20
		print(health)
		var knockback_direction = (position - body.position).normalized()
		apply_knockback(knockback_direction, 200, 0.15)
	if health <= 0:
		player_state = "dead"

#for temp
func _update_temperature(delta: float) -> void:
	if near_fire:
		temperature += temp_gain_per_sec * delta
	else:
		temperature -= temp_loss_per_sec * delta
	temperature = clamp(temperature, 0.0, max_temperature)
	
	if temperature <= 0.0:
		player_state = "dead"
	
func _update_ui() -> void:
	if temperature_bar:
		temperature_bar.value = temperature			
		
func apply_knockback(direction, force, knockback_duration)->void:
	knockback = direction * force
	knockback_timer = knockback_duration

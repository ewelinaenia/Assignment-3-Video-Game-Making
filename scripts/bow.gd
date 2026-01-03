extends Node2D

@export
var arrowScene : PackedScene
var animatedSprite : AnimatedSprite2D
var streamPlayer: AudioStreamPlayer2D

@export
var shootStream: AudioStream

@export
var chargingStream: AudioStream

@export
var errorStream1:AudioStream

var charge_start_time: float = 0.0
@export var max_speed: float = 200.0
@export var min_speed: float = 20.0
@export var max_charge_time: float = 2.0
@export var bag: Inventory


func _ready() -> void:
	animatedSprite = $AnimatedSprite2D
	streamPlayer= $AudioStreamPlayer2D

func charging():
	if animatedSprite == null:
		print("animatedSprite is not yet ready")
		return
	if animatedSprite.is_playing():
		print("animatedSprite is playing")
		return
	if bag == null:
		print("bag is null")
		return
	if bag.get_item_count("arrow")<=0:
		playStream(errorStream1)
		return
	z_index = 1
	charge_start_time = Time.get_ticks_msec() / 1000.0
	animatedSprite.play("default")
	playStream(chargingStream)

func playStream(stream:AudioStream):
	streamPlayer.stream = stream
	streamPlayer.play()
	


func shoot():
	z_index = 1
	animatedSprite.pause()
	animatedSprite.frame = 0
	if arrowScene == null:
		print("The bow does not specify an arrow")
		return
	if bag == null:
		print("bag is null")
		return
	if bag.get_item_count("arrow")<=0:
		return
	bag.remove_one_by_name("arrow")
	playStream(shootStream)
	var now = Time.get_ticks_msec() / 1000.0
	var charge_time = now - charge_start_time
	charge_time = min(charge_time, max_charge_time)
	var t = charge_time / max_charge_time
	var speed = min_speed + (max_speed - min_speed) * t
	var target = get_global_mouse_position() - global_position
	var direction = target.normalized()
	var velocity = direction * speed
	var arrow = arrowScene.instantiate()
	arrow.set_velocity(velocity)
	arrow.global_position = global_position
	get_node("/root").add_child(arrow)
	z_index = -1

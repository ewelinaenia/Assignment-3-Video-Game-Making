extends Node2D

var audioStreamPlayer2D:AudioStreamPlayer2D

func _ready() -> void:
	audioStreamPlayer2D = $AudioStreamPlayer2D

func _on_area_2d_body_exited(body: Node2D) -> void:
	if !body.has_method("is_player"):
		return
	var player = body.is_player()
	if !player:
		return
	EventBus.add_arrow()
	visible = false
	if audioStreamPlayer2D.playing:
		return
	audioStreamPlayer2D.play()


func _on_audio_stream_player_2d_finished() -> void:
	queue_free()

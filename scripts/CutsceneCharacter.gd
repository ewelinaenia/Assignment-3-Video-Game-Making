extends AnimatedSprite2D

func walk():
	$".".play("walk down")
	
func walk_right():
	$".".play("walk right")
	
func idle():
	$".".play("idle")

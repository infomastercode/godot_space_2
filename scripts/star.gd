extends Sprite

export var velocity = Vector2()

func _physics_process(delta):
	#position += velocity * delta #(Delta)x = (Delta)v * (Delta)t
	translate(velocity * delta)
	
	if position.y >= get_viewport_rect().size.y:
		position = Vector2(0, -180)
	
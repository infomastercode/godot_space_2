extends "res://assets/sprites/powerup.gd"


func ready():
	connect("area_entered", self, "on_area_enter")
	

func on_area_enter(other):
	if other.is_in_group("ship"):
		other.armor += 1
		queue_free()
		
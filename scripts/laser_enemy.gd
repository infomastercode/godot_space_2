extends "res://scripts/laser.gd"

func _ready():
	connect("area_entered", self, "_on_area_enter")

func _on_area_enter(other):
	if other.is_in_group("ship"):
		other.armor -= 1
		create_flare()
		utils.remote_call("camera", "shake", 3, 0.13)
		queue_free()
		
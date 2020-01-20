extends Area2D

# apply vcelocity
# instantiate a flare
# self-destory when out of screen

export var velocity = Vector2()
const scn_flare = preload("res://scenes/flare.tscn")

func _ready():
	create_flare()
	
	yield(get_node("vis_notifer"), "screen_exited")
	queue_free()
	
func _physics_process(delta):
	translate(velocity * delta)
	
func create_flare():
	var flare = scn_flare.instance()
	flare.position = position
	utils.main_node.add_child(flare)
extends Node

#const enemy_kamikaza = preload("res://scenes/enemy_kamikaze.tscn")
const enemies = [
	preload("res://scenes/enemy_kamikaze.tscn"),
	preload("res://scenes/enemy_clever.tscn")
]

func _ready():
	spawn()
	
func spawn():
	while true:
		randomize()
		
		#var enemy = enemy_kamikaza.instance()
		var enemy = utils.choose(enemies).instance()
		var pos = Vector2()
		pos.x = rand_range(0+16, get_viewport().get_visible_rect().size.x-16)
		pos.y = 0-16
		enemy.position = pos
		get_node("container").add_child(enemy)
		#yield(utils.create_timer(rand_range(0.5, 1.25)), "timeout")
		yield(get_tree().create_timer(rand_range(0.5, 1.25)), "timeout") 
	
	
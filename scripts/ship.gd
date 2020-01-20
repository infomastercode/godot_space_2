extends Area2D

var armor = 4 setget set_armor
var is_double_shooting = false setget set_double_shooting

const scn_laser = preload("res://scenes/laser_ship.tscn")
const scn_explosion = preload("res://scenes/explosion.tscn")
const scn_flash = preload("res://scenes/flash.tscn")

signal armor_changed

func _ready():
	add_to_group("ship")
	yield(utils.create_timer(0.5), "timeout")
	shoot()
	pass # Replace with function body.

func _physics_process(delta):

	var mouse = get_global_mouse_position()
	var motion = (mouse.x - position.x) * 0.2
	position.x += motion
	

	#position.x = lerp(position.x, get_global_mouse_position().x, 0.2)
	
	var max_rect = get_viewport_rect().size.x
	#print(clamp(position.x, 16, max_rect - 16))
	position.x = clamp(position.x, 16, max_rect - 16)

	pass
	
func shoot():
	while true:
		var pos_left = get_node("cannons/left").get_global_position()
		var pos_right = get_node("cannons/right").get_global_position()
		create_laser(pos_left)
		create_laser(pos_right)
		
		if is_double_shooting:
			var laser_left = create_laser(pos_left)
			var laser_right = create_laser(pos_right)
			laser_left.velocity.x -= 25
			laser_right.velocity.x = 25
			
		yield(utils.create_timer(0.25), "timeout")
		
func set_armor(new_value):
	if new_value > 4: return
	
	if new_value < armor:
		utils.main_node.add_child(scn_flash.instance())
	
	armor = new_value
	emit_signal("armor_changed", armor)
	
	if armor <= 0:
		create_explosion()
		queue_free()

func set_double_shooting(new_value):
	is_double_shooting = new_value
	
	if is_double_shooting:
		yield(utils.create_timer(5), "timeout")
		is_double_shooting = false
	
func create_laser(pos):
	var laser = scn_laser.instance()
	laser.position = pos
	utils.main_node.add_child(laser)
	return laser
	
func create_explosion():
	var explosion = scn_explosion.instance()
	explosion.position = get_position()
	utils.main_node.add_child(explosion)
	
	
	
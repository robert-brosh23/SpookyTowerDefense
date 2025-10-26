class_name Turret extends Node2D

@export var shot_cooldown : float = 1.0
@export_range(0, 2.0 * PI) var shot_direction: float
@export var detection_radius: float
@export var shot_speed : float = 200.0
@export var sprite : Sprite2D


var timer: Timer

static func create_new_turret(turret_shot_cooldown := 1.0, turret_shot_direction := 0, turret_shot_speed := 200.0, detection_radius := 400.0) -> Turret:
	var turret = preload("res://turret/turret.tscn").instantiate()
	turret.shot_cooldown = turret_shot_cooldown
	turret.shot_direction = turret_shot_direction
	turret.shot_speed = turret_shot_speed
	turret.detection_radius = detection_radius
	turret.sprite.texture = preload("res://sprites/turret_temp.png")
	return turret

func _ready() -> void:
	timer = Timer.new()
	timer.one_shot = false
	timer.wait_time = shot_cooldown
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	timer.start()
	
func _on_timer_timeout():
	var target = _get_nearest_enemy()
	if target:
		shot_direction = global_position.angle_to_point(target.hurtbox.global_position)
		var bullet = Bullet.spawn_bullet(shot_direction, shot_speed)
		var offset = 50.0
		bullet.position += offset * Vector2(cos(shot_direction), sin(shot_direction) / 2)
		add_child(bullet)
		
	timer.start()

func _get_nearest_enemy() -> Enemy:
	var enemies = get_tree().get_nodes_in_group("enemies")
	var nearest : Enemy = null
	var nearest_dist := INF
	for e in enemies:
		if not e or not e.is_inside_tree():
			continue
		var dist = global_position.distance_to(e.global_position)
		if dist < nearest_dist and dist < detection_radius:
			nearest = e
			nearest_dist = dist
	return nearest

class_name Turret extends Node2D

@export var shot_cooldown : float = 1.0
@export_range(0, 2.0 * PI) var shot_direction: float
@export var shot_speed : float = 200.0
@export var sprite : Sprite2D

var timer: Timer

static func create_new_turret(turret_shot_cooldown := 1.0, turret_shot_direction := 0, turret_shot_speed := 200.0) -> Turret:
	var turret = preload("res://turret/turret.tscn").instantiate()
	turret.shot_cooldown = turret_shot_cooldown
	turret.shot_direction = turret_shot_direction
	turret.shot_speed = turret_shot_speed
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
	var bullet = Bullet.spawn_bullet(shot_direction, shot_speed)
	var offset = 50.0
	bullet.position += offset * Vector2(cos(shot_direction), sin(shot_direction) / 2)
	add_child(bullet)
	timer.start()

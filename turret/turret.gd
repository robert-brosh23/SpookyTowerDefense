class_name Turret extends Node2D

@export var shot_cooldown : float = 1.0

var timer: Timer

func _ready() -> void:
	timer = Timer.new()
	timer.one_shot = false
	timer.wait_time = shot_cooldown
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	timer.start()
	
func _on_timer_timeout():
	var direction := PI/4.0
	var bullet = Bullet.spawn_bullet(direction)
	bullet.position.y -= 30
	var offset = 50.0
	bullet.position += offset * Vector2(cos(direction), sin(direction) / 2)
	add_child(bullet)
	timer.start()

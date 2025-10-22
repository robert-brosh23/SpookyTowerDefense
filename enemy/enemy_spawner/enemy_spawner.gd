class_name EnemySpawner extends Node2D

@export var spawn_cooldown : float
@export var enemy_path : Path2D

var active_enemies : Array[Enemy]

var timer: Timer

func _ready() -> void:
	timer = Timer.new()
	timer.one_shot = false
	timer.wait_time = spawn_cooldown
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	timer.start()
	
func _on_timer_timeout():
	var enemy := Enemy.spawn_at_location(enemy_path, Vector2(0,0))
	active_enemies.append(enemy)
	enemy.destroyed.connect(func(): active_enemies.erase(enemy))

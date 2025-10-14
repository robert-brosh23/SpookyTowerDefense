class_name Bullet extends Node2D

const SPEED := 300.0
const time_to_live = 4.0

var direction := 0.0

static func spawn_bullet(bullet_direction: float) -> Bullet:
	var bullet_scene = preload("res://turret/bullet/bullet.tscn")
	var bullet : Bullet = bullet_scene.instantiate()
	bullet.direction = bullet_direction
	return bullet

func _physics_process(delta: float) -> void:
	position += delta * SPEED * Vector2(cos(direction),sin(direction) * 0.5)

func _ready() -> void:
	var timer = Timer.new()
	add_child(timer)
	timer.start(time_to_live)
	timer.timeout.connect(func(): queue_free())

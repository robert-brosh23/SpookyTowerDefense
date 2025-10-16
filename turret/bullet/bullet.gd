class_name Bullet extends Node2D

const DEFAULT_SPEED := 100.0
const time_to_live = 4.0

@export var shadow : Sprite2D
@export var hitbox : Hitbox

var base_layer : TileMapLayer
var direction := 0.0
var speed : float

static func spawn_bullet(bullet_direction: float, bullet_speed: float = DEFAULT_SPEED) -> Bullet:
	var bullet_scene = preload("res://turret/bullet/bullet.tscn")
	var bullet : Bullet = bullet_scene.instantiate()
	bullet.direction = bullet_direction
	bullet.speed = bullet_speed
	return bullet

func _physics_process(delta: float) -> void:
	position += delta * speed * Vector2(cos(direction),sin(direction) * 0.5)
	
	if base_layer != null:
		if base_layer.get_cell_source_id(base_layer.local_to_map(global_position + Vector2(0, 60))) == -1:
			shadow.visible = false
		else:
			shadow.visible = true

func _ready() -> void:
	var timer = Timer.new()
	base_layer = get_tree().get_first_node_in_group("base_layer")
	add_child(timer)
	timer.start(time_to_live)
	timer.timeout.connect(func(): queue_free())
	
	hitbox.hit_connected.connect(func(): queue_free())

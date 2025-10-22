class_name Enemy extends PathFollow2D

const STARTING_HEALTH := 100

signal destroyed

@export var hurtbox : Hurtbox
@export var animation_player : AnimationPlayer

var speed := 100
var health := STARTING_HEALTH:
	set(value):
		health = max(value, 0)
		if health == 0:
			destroy_enemy()

func _ready() -> void:
	hurtbox.damaged.connect(take_damage)
	progress = 0
	
func _process(delta: float) -> void:
	progress += delta * speed
	
static func spawn_at_location(context: Node, location: Vector2) -> Enemy:
	var enemy := preload("res://enemy/enemy.tscn").instantiate()
	enemy.global_position = location
	context.add_child(enemy)
	return enemy
	
func take_damage(damage: int):
	health -= damage
	animation_player.play("take_damage")
	
func destroy_enemy():
	print("destroyed")
	destroyed.emit()
	queue_free()

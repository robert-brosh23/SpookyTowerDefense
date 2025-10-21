class_name Enemy extends Node2D

const STARTING_HEALTH := 100

signal destroyed

@export var hurtbox : Hurtbox

var health := STARTING_HEALTH:
	set(value):
		health = max(value, 0)
		if health == 0:
			destroy_enemy()

func _ready() -> void:
	hurtbox.damaged.connect(take_damage)
	
static func spawn_at_location(context: Node, location: Vector2) -> Enemy:
	var enemy := preload("res://enemy/enemy.tscn").instantiate()
	enemy.global_position = location
	context.add_child(enemy)
	return enemy
	
func take_damage(damage: int):
	health -= damage
	
func destroy_enemy():
	print("destroyed")
	destroyed.emit()
	queue_free()

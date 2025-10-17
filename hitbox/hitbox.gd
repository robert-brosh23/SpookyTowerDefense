class_name Hitbox extends Area2D

@export var damage := 10

signal hit_connected

func _ready() -> void:
	area_entered.connect(_area_entered)
	
func _area_entered(a: Area2D) -> void:
	if a is Hurtbox:
		hit_connected.emit()
		a.take_damage(damage)

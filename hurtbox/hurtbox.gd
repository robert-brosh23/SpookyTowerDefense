class_name Hurtbox extends Area2D

signal damaged(damage: int)

func take_damage(damage: int):
	damaged.emit(damage)

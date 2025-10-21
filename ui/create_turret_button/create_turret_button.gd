class_name CreateTurretButton extends Control

var preview_scene := preload("res://turret/turret_preview/turret_preview.tscn")

func _on_button_pressed() -> void:
	var turret = Turret.create_new_turret()
	var turret_preview := TurretPreview.create_preview(turret)
	get_tree().get_first_node_in_group("main").add_child(turret_preview)

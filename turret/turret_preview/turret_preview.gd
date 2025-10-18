class_name TurretPreview extends Node2D

@export var preview_sprite : Sprite2D

var select_layer : TileMapLayer
var base_layer : TileMapLayer
var main : Node2D
var previewing_turret : Turret

static func create_preview(turret: Turret) -> TurretPreview:
	var preview = preload("res://turret/turret_preview/turret_preview.tscn").instantiate()
	preview.preview_sprite.texture = turret.sprite.texture
	preview.previewing_turret = turret
	return preview

func _process(delta: float) -> void:
	var select_tile_coords = select_layer.local_to_map(get_global_mouse_position())
	var tile_pos = select_layer.map_to_local(select_tile_coords)
	global_position = tile_pos
	
	if base_layer.get_cell_source_id(select_tile_coords + Vector2i(0, 2)) == 2:
		visible = true
		if Input.is_action_just_pressed("click"):
			main.add_child(previewing_turret)
			previewing_turret.global_position = tile_pos
			queue_free()
	else:
		visible = false
		
	
	
func _ready() -> void:
	select_layer = get_tree().get_first_node_in_group("select_layer")
	base_layer = get_tree().get_first_node_in_group("base_layer")
	main = get_tree().get_first_node_in_group("main")

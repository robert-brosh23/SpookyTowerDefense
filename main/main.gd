extends Node2D

const GRID_DIMENSIONS := [16, 20]

@export var select_layer : TileMapLayer

var prev_tile_selection_coords := Vector2(0,0)


func _process(delta):
	_process_input()
	
func _process_input():
	select_layer.erase_cell(prev_tile_selection_coords)
	
	var select_tile_coords = select_layer.local_to_map(get_global_mouse_position())
	prev_tile_selection_coords = select_tile_coords
			
	select_layer.set_cell(select_tile_coords, 1, Vector2(0,0))

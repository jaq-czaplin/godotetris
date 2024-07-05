class_name TileGrid extends TileMap

const TILESET_ID: int = 0
const EMPTY_ATLAS_COORDS = Vector2i(-1, -1)


#region Tiles

func _draw_tile(layer: int, coords: Vector2i, atlas_coords: Vector2i):
	set_cell(layer, coords, TILESET_ID, atlas_coords)

func _clear_tile(layer: int, coords: Vector2i):
	erase_cell(layer, coords)

func _is_tile_empty(layer: int, coords: Vector2i) -> bool:
	return get_cell_source_id(layer, coords) == -1
#endregion



#region Shapes

func _draw_shape(layer: int, shape: ShapeData, coords: Vector2i, atlas_coords: Vector2i):
	for v in shape.cells: _draw_tile(layer, coords + v, atlas_coords)

func _clear_shape(layer: int, shape: ShapeData, coords: Vector2i):
	for v in shape.cells: _clear_tile(layer, coords + v)

func _is_shape_empty(layer: int, shape: ShapeData, coords: Vector2i):
	for v in shape.cells: 
		if not _is_tile_empty(layer, coords + v):
			return false
	return true
#endregion

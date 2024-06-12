class_name Grid extends TileMap

enum GridLayer {
	Board, Locked, Shadow, Active, Preview
}

const EMPTY_ATLAS_COORDS = Vector2i(-1, -1)
const SHADOW_ATLAS_COORDS = Vector2i(1, 1)
const TILESET_ID: int = 0;



func draw_tile(layer: GridLayer, coords: Vector2i, atlas_coords: Vector2i):
	set_cell(layer, coords, TILESET_ID, atlas_coords)

func clear_tile(layer: GridLayer, coords: Vector2i):
	erase_cell(layer, coords)

func draw_shape(layer: GridLayer, shape: Shape, coords: Vector2i, atlas_coords: Vector2i):
	for v in shape.cells: 
		var tile_coords = coords + v
		draw_tile(layer, tile_coords, atlas_coords)

func clear_shape(layer: GridLayer, shape: Shape, coords: Vector2i):
	for v in shape.cells: 
		clear_tile(layer, coords + v)

func clear_range(layer: GridLayer, from: Vector2i, to: Vector2i):
	for col in range(from.x, to.x):
		for row in range(from.y, to.y): 
			clear_tile(layer, Vector2i(col, row))

func is_tile_empty(layer: GridLayer, coords: Vector2i) -> bool:
	return get_cell_source_id(layer, coords) == -1
	
func count_not_empty_tiles_in_range(layer: GridLayer, from: Vector2i, to: Vector2i) -> int:
	var not_empty_tiles = 0
	for col in range(from.x, to.x):
		for row in range(from.y, to.y): 
			if is_tile_empty(layer, Vector2i(col, row)):
				not_empty_tiles +=1
	return not_empty_tiles;


func draw_piece_shape(piece_shape: Shape, pos: Vector2i, atlas_coords: Vector2i):
	draw_shape(GridLayer.Active, piece_shape, pos, atlas_coords)

func clear_piece_shape(piece_shape: Shape, pos: Vector2i):
	clear_shape(GridLayer.Active, piece_shape, pos)
	
func draw_shadow_shape(piece_shape: Shape, pos: Vector2i):
	draw_shape(GridLayer.Shadow, piece_shape, pos, SHADOW_ATLAS_COORDS)

func clear_shadow_shape(piece_shape: Shape, pos: Vector2i):
	clear_shape(GridLayer.Shadow, piece_shape, pos)
	
func lock_piece_shape(piece_shape: Shape, pos: Vector2i, atlas_coords: Vector2i):
	for v in piece_shape.cells:
		clear_tile(GridLayer.Active, v + pos)
		draw_tile(GridLayer.Locked, v + pos,  atlas_coords)

func is_piece_shape_empty(piece_shape: Shape, pos: Vector2i) -> bool:
	for v in piece_shape.cells: 
		if not is_tile_empty(GridLayer.Locked, pos + v) or not is_tile_empty(GridLayer.Board, pos + v) :
			return false
	return true


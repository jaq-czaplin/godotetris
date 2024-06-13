class_name Grid extends TileMap

enum GridLayer {
	Board, Locked, Shadow, Active, Preview
}

const TILESET_ID: int = 0;
const COLS: int = 10
const ROWS: int = 20
const EMPTY_ATLAS_COORDS = Vector2i(-1, -1)
const BOARD_ATLAC_CORDS = Vector2i(4, 1)
const SHADOW_ATLAS_COORDS = Vector2i(1, 1)
const BOARD_POS = Vector2i(0, 0)

func _ready():
	draw_board()

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

func draw_board():
	for col in range(BOARD_POS.x, BOARD_POS.x + COLS + 2):
		draw_tile(GridLayer.Board, Vector2i(col, BOARD_POS.y), BOARD_ATLAC_CORDS)
		draw_tile(GridLayer.Board, Vector2i(col, BOARD_POS.y + ROWS + 1), BOARD_ATLAC_CORDS)
	for row in range(BOARD_POS.y + 1, BOARD_POS.y + ROWS + 1):
		draw_tile(GridLayer.Board, Vector2i(BOARD_POS.x, BOARD_POS.y + row), BOARD_ATLAC_CORDS)
		draw_tile(GridLayer.Board, Vector2i(BOARD_POS.x + COLS + 1, BOARD_POS.y + row), BOARD_ATLAC_CORDS)

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

func is_locked_position(pos: Vector2i):
	return not is_tile_empty(GridLayer.Locked, pos)

func count_full_tiles_in_row(row: int) -> int:
	var count = 0
	for col in range(COLS):
		if is_locked_position(Vector2i(col + BOARD_POS.x + 1, row)):
			count += 1
	return count

func is_row_full(row: int):
	return count_full_tiles_in_row(row) == COLS

func shift_rows(from_row: int):
	var atlas_coords: Vector2i
	for row in range(from_row, BOARD_POS.y + 1, -1):
		for col in range(COLS):
			atlas_coords = get_cell_atlas_coords(GridLayer.Locked, Vector2i(col + BOARD_POS.x + 1, row - 1))
			if atlas_coords == EMPTY_ATLAS_COORDS:
				clear_tile(GridLayer.Locked, Vector2i(col + BOARD_POS.x + 1, row))
			else:
				draw_tile(GridLayer.Locked, Vector2i(col + BOARD_POS.x + 1, row), atlas_coords)

func clear_full_rows() -> int:
	var cleared_rows = 0
	var row : int = ROWS + BOARD_POS.y + 1
	while row > 0 :
		if is_row_full(row):
			shift_rows(row)
			cleared_rows += 1
		else :
			row -= 1
	return cleared_rows

func clear_all():
	#for row in range(ROWS):
		#for col in range(COLS):
			#clear_tile(GridLayer.Board, Vector2i(col + BOARD_POS.x, row + BOARD_POS.y))
	clear_layer(GridLayer.Active)
	clear_layer(GridLayer.Shadow)
	clear_layer(GridLayer.Locked)
	clear_layer(GridLayer.Preview)

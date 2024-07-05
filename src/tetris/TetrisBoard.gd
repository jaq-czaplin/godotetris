@tool
class_name TetrisBoard extends TileGrid

enum GridLayer {
	BACKGROUND,
	BORDER,
	LOCKED,
	SHADOW,
	PIECE
}

@export var cols: int = 10
@export var rows: int = 20
@export var background_atlas_coords: Vector2i = Vector2i(6, 1)
@export var board_atlas_coords: Vector2i = Vector2i(7, 1)


func _ready():
	reset()

func reset():
	for layer in GridLayer: clear_layer(GridLayer[layer])
	_draw_border()
	_draw_background()

func _process(_delta: float):
	if Engine.is_editor_hint():
		_draw_border()
		_draw_background()

#region Border and Background

func _draw_border():
	clear_layer(GridLayer.BORDER)
	for col in range(0, cols + 2):
		_draw_tile(GridLayer.BORDER, Vector2i(col, 0), board_atlas_coords)
		_draw_tile(GridLayer.BORDER, Vector2i(col, rows + 1), board_atlas_coords)
	for row in range(1, rows + 1):
		_draw_tile(GridLayer.BORDER, Vector2i(0, row), board_atlas_coords)
		_draw_tile(GridLayer.BORDER, Vector2i(cols + 1, row), board_atlas_coords)

func _draw_background():
	clear_layer(GridLayer.BACKGROUND)
	for col in range(1, cols + 1):
		for row in range(1, rows + 1):
			_draw_tile(GridLayer.BACKGROUND, Vector2i(col, row), background_atlas_coords)

#endregion



#region Pieces

func draw_piece_shape(shape: ShapeData, coords: Vector2i, atlas_coords: Vector2i):
	clear_layer(GridLayer.PIECE)
	_draw_shape(GridLayer.PIECE, shape, coords, atlas_coords)

func draw_shadow_shape(shape: ShapeData, coords: Vector2i, atlas_coords: Vector2i):
	clear_layer(GridLayer.SHADOW)
	_draw_shape(GridLayer.SHADOW, shape, coords, atlas_coords)

func lock_piece_shape(shape: ShapeData, coords: Vector2i, atlas_coords: Vector2i):
	_draw_shape(GridLayer.LOCKED, shape, coords, atlas_coords)

func clear_piece():
	clear_layer(GridLayer.PIECE)

func is_free_shape_space(shape: ShapeData, coords: Vector2i) -> bool:
	return _is_shape_empty(GridLayer.LOCKED, shape, coords) and _is_shape_empty(GridLayer.BORDER, shape, coords)

#endregion



#region Rows

func set_row_atlas_cords(row: int, atlas_coords: Vector2i):
	for col in range(cols):
		_draw_tile(GridLayer.LOCKED, Vector2i(col + 1, row), atlas_coords) 

func is_locked_position(pos: Vector2i):
	return not _is_tile_empty(GridLayer.LOCKED, pos)

func is_row_full(row: int):
	return _count_full_tiles_in_row(row) == cols

func shift_rows(from_row: int):
	var current_pos: Vector2i
	for row in range(from_row, 1, -1):
		for col in range(cols):
			current_pos =  Vector2i(col + 1, row)
			_shift_locked_tile(current_pos)

func _shift_locked_tile(pos: Vector2i):
	var up_pos = pos + Vector2i.UP
	var atlas_coords = get_cell_atlas_coords(GridLayer.LOCKED, up_pos)
	if atlas_coords == EMPTY_ATLAS_COORDS:
		_clear_tile(GridLayer.LOCKED, pos)
	else:
		_draw_tile(GridLayer.LOCKED, pos, atlas_coords)

func _count_full_tiles_in_row(row: int) -> int:
	var count = 0
	for col in range(cols):
		if is_locked_position(Vector2i(col + 1, row)):
			count += 1
	return count

#endregion

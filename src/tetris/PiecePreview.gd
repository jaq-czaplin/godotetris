@tool
class_name PiecePreview extends TileGrid

func _ready():
	reset()
	if Engine.is_editor_hint():
		var piece: PieceData = PiecesCollection.get_random() as PieceData
		draw_piece_shape(piece.shapes[0], piece.atlas_coords)

func reset():
	clear_layer(0)
	
func draw_piece_shape(shape: ShapeData, atlas_coords: Vector2i):
	clear_layer(0)
	_draw_shape(0, shape, Vector2i.ZERO, atlas_coords)

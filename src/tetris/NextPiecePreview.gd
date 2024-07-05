class_name NextPiecePreview extends Control

@onready var preview = $Preview as PiecePreview

func draw_piece_preview(shape: ShapeData, atlas_cords: Vector2i):
	preview.draw_piece_shape(shape, atlas_cords)

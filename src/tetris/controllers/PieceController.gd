class_name PieceController extends Node

var current: PieceData
var next: PieceData
var position: Vector2i = Vector2i.ZERO
var rotation: int = 0

func _ready():
	reset()
	
func reset():
	position =  Vector2i.ZERO
	rotation = 0
	next = PiecesCollection.get_random()
	next_piece()
	
func next_piece():
	rotation = 0
	current = next
	next = PiecesCollection.get_random()

func rotate():
	rotation = _calculate_next_rotation_index()
	
func get_current_shape() -> ShapeData:
	return current.shapes[rotation]

func get_next_shape() -> ShapeData:
	return next.shapes[0]

func get_rotated_shape() -> ShapeData:
	return current.shapes[_calculate_next_rotation_index()]

func get_current_atlas_coords() -> Vector2i:
	return current.atlas_coords;
	
func _calculate_next_rotation_index() -> int:
	return (rotation + 1) % current.shapes.size()

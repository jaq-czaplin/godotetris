class_name PiecesCollectionPreload extends Node

var _all = [
	
	# Tetromino I
	PieceData.new([
		ShapeData.new([Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(3, 1)]), 
		ShapeData.new([Vector2i(2, 0), Vector2i(2, 1), Vector2i(2, 2), Vector2i(2, 3)]), 
		ShapeData.new([Vector2i(0, 2), Vector2i(1, 2), Vector2i(2, 2), Vector2i(3, 2)]), 
		ShapeData.new([Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2), Vector2i(1, 3)])
	], Vector2i(0, 0)),
	
	# Tetromino T
	PieceData.new([
		ShapeData.new([Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]), 
		ShapeData.new([Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1), Vector2i(1, 2)]), 
		ShapeData.new([Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(1, 2)]), 
		ShapeData.new([Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 2)])
	], Vector2i(1, 0)),
	
	# Tetromino O
	PieceData.new([
		ShapeData.new([Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)])
	], Vector2i(2, 0)),

	# Tetromino Z
	PieceData.new([
		ShapeData.new([Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1)]), 
		ShapeData.new([Vector2i(2, 0), Vector2i(1, 1), Vector2i(2, 1), Vector2i(1, 2)]), 
		ShapeData.new([Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 2), Vector2i(2, 2)]), 
		ShapeData.new([Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(0, 2)])
	], Vector2i(3, 0)),

	# Tetromino S
	PieceData.new([
		ShapeData.new([Vector2i(1, 0), Vector2i(2, 0), Vector2i(0, 1), Vector2i(1, 1)]), 
		ShapeData.new([Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1), Vector2i(2, 2)]), 
		ShapeData.new([Vector2i(1, 1), Vector2i(2, 1), Vector2i(0, 2), Vector2i(1, 2)]), 
		ShapeData.new([Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 2)])
	], Vector2i(4, 0)),

	# Tetromino L
	PieceData.new([
		ShapeData.new([Vector2i(2, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]), 
		ShapeData.new([Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2), Vector2i(2, 2)]), 
		ShapeData.new([Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(0, 2)]), 
		ShapeData.new([Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2)])
	], Vector2i(5, 0)),

	# Tetromino J
	PieceData.new([
		ShapeData.new([Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]),
		ShapeData.new([Vector2i(1, 0), Vector2i(2, 0), Vector2i(1, 1), Vector2i(1, 2)]), 
		ShapeData.new([Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(2, 2)]), 
		ShapeData.new([Vector2i(1, 0), Vector2i(1, 1), Vector2i(0, 2), Vector2i(1, 2)])
	], Vector2i(6, 0))
]

var last_index : int = -1

func _get_random_index() -> int :	
	# reducing chance of geting same piece inspired by NES Tetris	
	var random_index = randi_range(0, _all.size())
	if random_index == last_index or random_index == _all.size():
		random_index = randi_range(0, _all.size() - 1)
	last_index = random_index
	return random_index
	
func get_by_index(index: int) -> PieceData :
	return _all[index]
	
func get_random() -> PieceData :
	return get_by_index(_get_random_index())

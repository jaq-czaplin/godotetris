extends Node

var all := [
	
	# Tetromino I
	PieceBlueprint.new([
		Shape.new([Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(3, 1)]), 
		Shape.new([Vector2i(2, 0), Vector2i(2, 1), Vector2i(2, 2), Vector2i(2, 3)]), 
		Shape.new([Vector2i(0, 2), Vector2i(1, 2), Vector2i(2, 2), Vector2i(3, 2)]), 
		Shape.new([Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2), Vector2i(1, 3)])
	], Vector2i(0, 0)),
	
	# Tetromino T
	PieceBlueprint.new([
		Shape.new([Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]), 
		Shape.new([Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1), Vector2i(1, 2)]), 
		Shape.new([Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(1, 2)]), 
		Shape.new([Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 2)])
	], Vector2i(1, 0)),
	
	# Tetromino O
	PieceBlueprint.new([
		Shape.new([Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]), 
		Shape.new([Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]), 
		Shape.new([Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]), 
		Shape.new([Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)])
	], Vector2i(2, 0)),

	# Tetromino Z
	PieceBlueprint.new([
		Shape.new([Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1)]), 
		Shape.new([Vector2i(2, 0), Vector2i(1, 1), Vector2i(2, 1), Vector2i(1, 2)]), 
		Shape.new([Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 2), Vector2i(2, 2)]), 
		Shape.new([Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(0, 2)])
	], Vector2i(3, 0)),

	# Tetromino S
	PieceBlueprint.new([
		Shape.new([Vector2i(1, 0), Vector2i(2, 0), Vector2i(0, 1), Vector2i(1, 1)]), 
		Shape.new([Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1), Vector2i(2, 2)]), 
		Shape.new([Vector2i(1, 1), Vector2i(2, 1), Vector2i(0, 2), Vector2i(1, 2)]), 
		Shape.new([Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 2)])
	], Vector2i(4, 0)),

	# Tetromino L
	PieceBlueprint.new([
		Shape.new([Vector2i(2, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]), 
		Shape.new([Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2), Vector2i(2, 2)]), 
		Shape.new([Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(0, 2)]), 
		Shape.new([Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2)])
	], Vector2i(5, 0)),

	# Tetromino J
	PieceBlueprint.new([
		Shape.new([Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]),
		Shape.new([Vector2i(1, 0), Vector2i(2, 0), Vector2i(1, 1), Vector2i(1, 2)]), 
		Shape.new([Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(2, 2)]), 
		Shape.new([Vector2i(1, 0), Vector2i(1, 1), Vector2i(0, 2), Vector2i(1, 2)])
	], Vector2i(6, 0))
]

func get_random_blueprint_index() -> int :
	return randi_range(0, all.size() -1)
	
func get_blueprint_by_index(index: int) -> PieceBlueprint :
	return all[index]

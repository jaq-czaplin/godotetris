class_name Tetris extends Node2D

@onready var grid = $Grid as Grid
@onready var ui = $UI as UI
@onready var movement_timer = $MovementTimer as MovementTimer

const SPAWN_POS = Vector2i(5, 1)
var current_piece: Piece

func _ready():
	movement_timer.move_direction.connect(move_current_piece)
	new_game()

func _process(_delta):
	pass



func new_game():
	spawn_piece()
	
func spawn_piece():
	var current_blueprint_index = Blueprints.get_random_blueprint_index()
	var current_blueprint = Blueprints.get_blueprint_by_index(current_blueprint_index) as PieceBlueprint
	current_piece = Piece.new(current_blueprint, SPAWN_POS)
	grid.draw_piece_shape(current_piece.shapes[0], current_piece.position, current_piece.atlas_coords)

func move_current_piece(direction: Vector2i):
	if can_piece_move(current_piece, direction):
		grid.clear_piece_shape(current_piece.shapes[0], current_piece.position)
		current_piece.position += direction
		grid.draw_piece_shape(current_piece.shapes[0], current_piece.position, current_piece.atlas_coords)

func can_piece_move(piece: Piece, direction: Vector2i) -> bool:
	return grid.is_piece_shape_empty(piece.shapes[0], current_piece.position + direction)

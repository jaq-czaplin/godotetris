class_name Tetris extends Node2D

@onready var grid = $Grid as Grid
@onready var ui = $UI as UI
@onready var movement_timer = $MovementTimer as MovementTimer

const SPAWN_POS = Vector2i(5, 1)
var current_blueprint: PieceBlueprint
var current_piece: Piece
var next_blueprint: PieceBlueprint
var shadow_pos: Vector2i
#var next_piece: Piece

func _ready():
	movement_timer.move_direction.connect(move_current_piece)
	new_game()

func _process(_delta):
	handle_user_input()



func new_game():
	spawn_next_piece()

func spawn_next_piece():
	# if current_piece : current_piece = null
	
	if next_blueprint : current_blueprint = next_blueprint
	else : current_blueprint = Blueprints.get_random_blueprint() as PieceBlueprint
	
	next_blueprint = Blueprints.get_random_blueprint() as PieceBlueprint
	current_piece = Piece.new(current_blueprint, SPAWN_POS)
	
	shadow_pos = calculate_shadow_position();
	grid.draw_shadow_shape(current_piece.shapes[current_piece.rotation], shadow_pos)
	grid.draw_piece_shape(current_piece.shapes[current_piece.rotation], current_piece.position, current_piece.atlas_coords)

func move_current_piece(direction: Vector2i):
	var next_position = current_piece.position + direction
	if grid.is_piece_shape_empty(current_piece.shapes[current_piece.rotation], next_position):
		grid.clear_shadow_shape(current_piece.shapes[current_piece.rotation], shadow_pos)
		grid.clear_piece_shape(current_piece.shapes[current_piece.rotation], current_piece.position)
		current_piece.position += direction
		shadow_pos = calculate_shadow_position();
		grid.draw_shadow_shape(current_piece.shapes[current_piece.rotation], shadow_pos)
		grid.draw_piece_shape(current_piece.shapes[current_piece.rotation], current_piece.position, current_piece.atlas_coords)
	else: 
		if direction == Vector2i.DOWN:
			grid.clear_shadow_shape(current_piece.shapes[current_piece.rotation], shadow_pos)
			grid.lock_piece_shape(current_piece.shapes[current_piece.rotation], current_piece.position, current_piece.atlas_coords)
			spawn_next_piece()

func calculate_shadow_position() -> Vector2i :
	# TODO: Limit?
	var temp_shadow_pos = current_piece.position
	while grid.is_piece_shape_empty(current_piece.shapes[current_piece.rotation], temp_shadow_pos + Vector2i.DOWN):
		temp_shadow_pos += Vector2i.DOWN
	return temp_shadow_pos;

func rotate_current_piece():
	var next_rotation = current_piece.get_next_rotation()
	if grid.is_piece_shape_empty(current_piece.shapes[next_rotation], current_piece.position) :
		grid.clear_shadow_shape(current_piece.shapes[current_piece.rotation], shadow_pos)
		grid.clear_piece_shape(current_piece.shapes[current_piece.rotation], current_piece.position)
		current_piece.rotation = next_rotation
		shadow_pos = calculate_shadow_position();
		grid.draw_shadow_shape(current_piece.shapes[current_piece.rotation], shadow_pos)
		grid.draw_piece_shape(current_piece.shapes[current_piece.rotation], current_piece.position, current_piece.atlas_coords)

func handle_user_input():
	if Input.is_action_pressed("ui_left"):
		movement_timer.add_left_movement(10)
	elif Input.is_action_pressed("ui_right"):
		movement_timer.add_right_movement(10)
	elif Input.is_action_pressed("ui_down"):
		movement_timer.add_down_movement(10)
	elif Input.is_action_just_pressed("ui_up"):
		rotate_current_piece()
	#elif Input.is_action_just_pressed("ui_accept"):
	#	hard_drop()

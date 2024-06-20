class_name Tetris extends Node2D

@onready var grid = $Grid as Grid
@onready var ui = $UI as UI
@onready var movement_timer = $MovementTimer as MovementTimer

const SPAWN_POS = Vector2i(5, 1)
var current_blueprint: PieceBlueprint
var current_piece: Piece
var next_blueprint: PieceBlueprint
var shadow_pos: Vector2i
var row_to_clear: int = -1
var score = 0
var bonus_root = 3
const REWARD = 100

func _ready():
	movement_timer.move_direction.connect(move_current_piece)
	ui.new_game_request.connect(new_game)
	new_game()

func _process(_delta):
	if movement_timer.active :
		handle_user_input()
	ui.set_score(score)



func new_game():
	row_to_clear = -1
	score = 0;
	movement_timer.reset()
	movement_timer.active = true;
	ui.hide_game_over()
	ui.show_next_piece_label()
	clear_board()
	spawn_next_piece()


func draw_current_piece():
	shadow_pos = calculate_shadow_position();
	grid.draw_shadow_shape(current_piece.shapes[current_piece.rotation], shadow_pos)
	grid.draw_piece_shape(current_piece.shapes[current_piece.rotation], current_piece.position, current_piece.atlas_coords)

func clear_current_piece():
	grid.clear_shadow_shape()
	grid.clear_piece_shape()

func lock_current_piece():
	grid.clear_shadow_shape()
	grid.lock_piece_shape(current_piece.shapes[current_piece.rotation], current_piece.position, current_piece.atlas_coords)
	clear_full_rows()

func draw_next_piece():
	grid.draw_next_piece_preview(next_blueprint.shapes[0], next_blueprint.atlas_coords)

func clear_next_piece():
	grid.clear_next_piece_preview(next_blueprint.shapes[0])

func calculate_shadow_position() -> Vector2i :
	# TODO: Limit?
	var temp_shadow_pos = current_piece.position
	while grid.is_piece_shape_empty(current_piece.shapes[current_piece.rotation], temp_shadow_pos + Vector2i.DOWN):
		temp_shadow_pos += Vector2i.DOWN
	return temp_shadow_pos;

func clear_full_rows():
	var cleared_rows =  await grid.clear_full_rows()
	score += cleared_rows * REWARD + (pow(bonus_root, cleared_rows)-1)
	if cleared_rows > 0: 
		movement_timer.speed_up()

func spawn_next_piece():
	if next_blueprint : 
		clear_next_piece()
		current_blueprint = next_blueprint
	else : current_blueprint = Blueprints.get_random_blueprint() as PieceBlueprint
	
	next_blueprint = Blueprints.get_random_blueprint() as PieceBlueprint
	if current_piece : current_piece.reset(current_blueprint, SPAWN_POS)
	else : current_piece = Piece.new(current_blueprint, SPAWN_POS)
	
	if is_game_over() :
		movement_timer.active = false;
		ui.hide_next_piece_label()
		ui.show_game_over()
	else :
		draw_next_piece()
		draw_current_piece()

func move_current_piece(direction: Vector2i):
	var next_position = current_piece.position + direction
	if grid.is_piece_shape_empty(current_piece.shapes[current_piece.rotation], next_position):
		clear_current_piece()
		current_piece.position += direction
		draw_current_piece()
	else: 
		if direction == Vector2i.DOWN:
			lock_current_piece()
			spawn_next_piece()

func rotate_current_piece():
	var next_rotation = current_piece.get_next_rotation()
	if grid.is_piece_shape_empty(current_piece.shapes[next_rotation], current_piece.position) :
		clear_current_piece()
		current_piece.rotation = next_rotation
		draw_current_piece()

func drop_current_piece():
	clear_current_piece()
	current_piece.position = shadow_pos
	draw_current_piece()
	lock_current_piece()
	spawn_next_piece()

func is_game_over() -> bool:
	return not grid.is_piece_shape_empty(current_piece.shapes[current_piece.rotation], current_piece.position)

func clear_board():
	grid.clear_all()

func handle_user_input():
	if Input.is_action_pressed("ui_left"):
		movement_timer.add_left_movement(10)
	elif Input.is_action_pressed("ui_right"):
		movement_timer.add_right_movement(10)
	elif Input.is_action_pressed("ui_down"):
		movement_timer.add_down_movement(10)
	elif Input.is_action_just_pressed("ui_up"):
		rotate_current_piece()
	elif Input.is_action_just_pressed("ui_accept"):
		drop_current_piece()

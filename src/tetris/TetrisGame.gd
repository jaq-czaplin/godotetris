class_name TetrisGame extends Node2D

signal on_game_over

const EXPLOSION = preload("res://scenes/effects/explosion.tscn")

@onready var score = $Score as ScoreController
@onready var speed = $Speed as SpeedController
@onready var piece = $Piece as PieceController
@onready var move = $Move as MoveController
@onready var board = $Board as TetrisBoard
@onready var sfx = $SfxController as SfxController

@export var enabled = true
@export var shadow_atlas_coords = Vector2i(7, 0)
@export var full_row_atlas_cords = Vector2i(5, 1)

func _ready():
	new_game()
	
func _process(_delta: float):
	if enabled :
		_handle_keyboard_input()
		_apply_current_piece_gravity()
		_draw_current_piece()

func play():
	enabled = true

func stop():
	enabled = false

func get_next_piece_data() -> PieceData:
	return piece.next

func get_current_score() -> int:
	return score.value

func get_current_speed() -> int:
	return speed.speed

func new_game():
	board.reset()
	piece.reset()
	score.reset()
	speed.reset()
	move.reset()
	_spawn_next_piece()
	
func game_over():
	stop()
	on_game_over.emit()

func get_spawn_position() -> Vector2i:
	return Vector2i(floor(board.cols/2), 1)


func _apply_current_piece_gravity():
	var move_vector = move.add_y(speed.value)
	if move_vector != Vector2i.ZERO :
		var move_success = _move_current_piece(move_vector)
		if move_success :
			pass
			## add sound ?
		elif move_vector == Vector2i.DOWN:
			_apply_lock_current_piece()

func _apply_lock_current_piece():
	_lock_current_piece()
	_clear_full_rows()
	if _is_game_over():
		game_over()
	else :
		_spawn_next_piece()

func _apply_move_current_piece(v: Vector2i):
	var move_vector = move.add(v)
	if move_vector != Vector2i.ZERO :
		var move_success = _move_current_piece(move_vector)
		if move_success :
			sfx.play_move_sfx()
		elif move_vector == Vector2i.DOWN:
			_apply_lock_current_piece()

func _apply_rotate_current_piece():
	var rotation_success = _rotate_current_piece()
	if rotation_success :
		sfx.play_rotate_sfx()

func _apply_drop_current_piece():
	piece.position = _calculate_shadow_position()
	sfx.play_drop_sfx()
	_apply_lock_current_piece()

func _move_current_piece(move_vector: Vector2i) -> bool:
	var next_position = piece.position + move_vector
	var can_piece_move = board.is_free_shape_space(piece.get_current_shape(), next_position)
	if can_piece_move:
		piece.position = next_position
		return true
	else:
		
		return false

func _rotate_current_piece():
	var can_piece_rotate = board.is_free_shape_space(piece.get_rotated_shape(), piece.position)
	if can_piece_rotate :
		piece.rotate()
		return true
	else :
		return false

func _spawn_next_piece():
	piece.next_piece()
	piece.position = get_spawn_position()

func _draw_current_piece():
	board.draw_piece_shape(piece.get_current_shape(), piece.position, piece.get_current_atlas_coords())
	board.draw_shadow_shape(piece.get_current_shape(), _calculate_shadow_position(), shadow_atlas_coords)

func _lock_current_piece():
	board.lock_piece_shape(piece.get_current_shape(), piece.position, piece.get_current_atlas_coords())

func _calculate_shadow_position() -> Vector2i :
	var temp_shadow_pos = piece.position
	while board.is_free_shape_space(piece.get_current_shape(), temp_shadow_pos + Vector2i.DOWN):
		temp_shadow_pos += Vector2i.DOWN
	return temp_shadow_pos;

func _clear_full_rows() :
	var cleared_rows = 0
	var row : int = board.rows + 1
	while row > 0 :
		if board.is_row_full(row):
			board.set_row_atlas_cords(row, full_row_atlas_cords)
			await get_tree().create_timer(0.2).timeout
			_explode_row(row)
			board.shift_rows(row)
			await get_tree().create_timer(0.1).timeout
			score.add(cleared_rows)
			cleared_rows += 1
			sfx.play_clear_sfx()
		else :
			row -= 1
	if cleared_rows > 0 :
		speed.add(1)

func _explode_row(row: int):
	for col in range(board.cols): _explode_tile(Vector2i(col + 1, row))

func _explode_tile(coords: Vector2i):
	var explosion = EXPLOSION.instantiate()
	board.add_child(explosion)
	var pos = board.map_to_local(coords)
	explosion.position = pos

func _is_game_over() -> bool:
	return not board.is_free_shape_space(piece.get_next_shape(), get_spawn_position())

func _handle_keyboard_input():
	if Input.is_action_pressed("key_left"):
		_apply_move_current_piece(Vector2i.LEFT * 10)
	elif Input.is_action_pressed("key_right"):
		_apply_move_current_piece(Vector2i.RIGHT * 10)
	elif Input.is_action_pressed("key_down"):
		_apply_move_current_piece(Vector2i.DOWN * 10)
	elif Input.is_action_just_pressed("key_up"):
		_apply_rotate_current_piece()
	elif Input.is_action_just_pressed("key_apply"):
		_apply_drop_current_piece()

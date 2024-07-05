class_name Main extends Node2D

enum GameState {
	IN_GAME,
	PAUSE,
	GAME_OVER
}

@onready var game = $Game as TetrisGame
@onready var next_piece_preview = $NextPiecePreview as NextPiecePreview
@onready var stats_preview = $StatsPreview as StatsPreview
@onready var game_over_screen = $GameOverScreen as GameOverScreen
@onready var pause_screen = $PauseScreen
@onready var music = $Music as MusicController


var state: GameState = GameState.GAME_OVER

func _ready():
	game_over_screen.on_new_game.connect(start_new_game)
	game.on_game_over.connect(game_over)
	start_new_game()

func _process(_delta: float):
	
	var next_piece = game.get_next_piece_data()
	next_piece_preview.draw_piece_preview(next_piece.shapes[0], next_piece.atlas_coords)
	
	stats_preview.set_score(game.get_current_score())
	stats_preview.set_speed(game.get_current_speed())
	
	_handle_keyboard_input()

func start_new_game():
	game_over_screen.unfocus()
	game_over_screen.hide()
	pause_screen.hide()
	game.new_game()
	game.play()
	music.next_music()
	music.play_music()
	state = GameState.IN_GAME

func game_over():
	game_over_screen.show()
	game_over_screen.focus()
	pause_screen.hide()
	game.stop()
	music.play_game_over()
	state = GameState.GAME_OVER

func pause():
	game_over_screen.unfocus()
	game_over_screen.hide()
	pause_screen.show()
	game.stop()
	music.pause_music()
	state = GameState.PAUSE

func unpause():
	game_over_screen.unfocus()
	game_over_screen.hide()
	pause_screen.hide()
	game.play()
	music.unpause_music()
	state = GameState.IN_GAME

func _handle_keyboard_input():
	if Input.is_action_just_pressed("key_pause"):
		if state == GameState.IN_GAME: pause()
		elif state == GameState.PAUSE: unpause()

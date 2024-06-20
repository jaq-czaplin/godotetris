class_name UI extends CanvasLayer

signal new_game_request

@onready var score = $Score as Label
@onready var next_piece_label = $NextPieceLabel as Label
@onready var game_over_label = $GameOverLabel as Label
@onready var new_game_button = $NewGameButton as Button
@onready var pause_label = $PauseLabel


func _ready():
	new_game_button.pressed.connect(new_game_button_pressed)

func set_score(value):
	score.text = str(value)

func show_next_piece_label():
	next_piece_label.show()

func hide_next_piece_label():
	next_piece_label.hide()

func show_game_over():
	game_over_label.show()
	
func hide_game_over():
	game_over_label.hide()
	
func show_pause():
	pause_label.show()
	
func hide_pause():
	pause_label.hide()

func focus_new_game_button():
	new_game_button.grab_focus()

func new_game_button_pressed():
	new_game_button.release_focus()
	new_game_request.emit()

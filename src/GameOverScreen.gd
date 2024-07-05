class_name GameOverScreen extends Control

signal on_new_game

@onready var new_game_button = $NewGameButton as Button

func _ready():
	new_game_button.pressed.connect(new_game_button_pressed)

func focus():
	new_game_button.grab_focus()

func unfocus():
	new_game_button.release_focus()

func new_game_button_pressed():
	on_new_game.emit()

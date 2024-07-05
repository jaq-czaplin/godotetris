class_name SfxController extends Node

@onready var move_sfx = $MoveSfx
@onready var rotate_sfx = $RotateSfx
@onready var drop_sfx = $DropSfx
@onready var clear_sfx = $ClearSfx


func play_move_sfx():
	move_sfx.play()

func play_rotate_sfx():
	rotate_sfx.play()

func play_drop_sfx():
	drop_sfx.play()

func play_clear_sfx():
	clear_sfx.play()

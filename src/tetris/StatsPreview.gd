class_name StatsPreview extends Control

@onready var score = $Score as Label
@onready var speed = $Speed as Label

func _ready():
	reset()
	
func reset():
	set_score(0)
	set_speed(0)

func set_score(val: int):
	score.text = str(val)
	
func set_speed(val: int):
	speed.text = str(val)

class_name UI extends CanvasLayer

@onready var score = $Score as Label

func set_score(value):
	score.text = str(value)

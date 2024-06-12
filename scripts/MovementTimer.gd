class_name MovementTimer extends Node

signal move_direction(Vector2i)

const DIRECTIONS = [Vector2i.LEFT, Vector2i.RIGHT, Vector2i.DOWN]

const MAX_TICKS: int = 50
var ticks: Array[float] = [0, 0, 0] # LEFT, RIGHT, DOWN
var active: bool = true;
var base_speed: float = 1.0
var speed: float = base_speed
var acceleration: float = 0.1

func _ready():
	reset()

func _process(_delta):
	if active :
		# always fall down
		add_down_movement(1)
		
		# emit movement signal
		for i in range(ticks.size()) :
			if ticks[i] > MAX_TICKS :
				move_direction.emit(DIRECTIONS[i])
				ticks[i] = 0

func add_left_movement(val: int):
	ticks[0] += val
	
func add_right_movement(val: int):
	ticks[1] += val
	
func add_down_movement(val: int):
	ticks[2] += val

func clear_movment():
	ticks = [0, 0, 0]

func speed_up():
	speed += acceleration

func clear_speed():
	speed = base_speed
	
func reset():
	clear_movment()
	clear_speed()

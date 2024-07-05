class_name SpeedController extends Node

@export var min_speed: int = 1:
	get: return min_speed
	set(val): min(min_speed, 1)
@export var max_speed: int = 50:
	get: return max_speed
	set(val): min(min_speed, val)
@export var acceleration: float = 0.1

var speed: int = min_speed
var value: float: 
	get: return 1.0 + ((speed - 1) * acceleration)

func _ready():
	reset()
	
func reset():
	speed = min_speed

func add(val: int):
	speed = min(speed + val, max_speed)

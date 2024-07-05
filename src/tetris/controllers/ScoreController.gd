class_name ScoreController extends Node

var value: int = 0

@export var revard: int = 100:
	get: return revard
	set(val): max(revard, 1)
@export var bonus_root: int = 35:
	get: return bonus_root
	set(val): max(bonus_root, 0)

func _ready():
	reset()

func add(val: int):
	value += revard + _calculate_bonus(val)

func reset():
	value = 0;

func _calculate_bonus(val: int) -> int:
	return bonus_root * val

class_name MoveController extends Node

var vector: Vector2i = Vector2i.ZERO
@export var limit: int = 50

func reset():
	vector = Vector2i.ZERO

func add(v: Vector2i) -> Vector2i:
	var v_x = add_x(v.x)
	var v_y = add_y(v.y)
	return v_x + v_y

func add_x(x: int) -> Vector2i:
	if (x > 0 and vector.x < 0) or (x < 0 and vector.x > 0):
		vector.x = 0
	vector.x += x
	if abs(vector.x) >= limit :
		var next_v = Vector2i(vector.sign().x, 0)
		vector.x = 0
		return next_v
	return Vector2i.ZERO
	
func add_y(y: int) -> Vector2i:
	vector.y += y
	if abs(vector.y) >= limit :
		var next_v = Vector2i(0, vector.sign().y)
		vector.y = 0;
		return next_v
	return Vector2i.ZERO

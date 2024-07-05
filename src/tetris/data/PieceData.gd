class_name PieceData

var shapes: Array[ShapeData]
var atlas_coords: Vector2i

func _init(shapes_arr: Array[ShapeData], atlas_coords_vector: Vector2i):
	self.shapes = shapes_arr
	self.atlas_coords = atlas_coords_vector

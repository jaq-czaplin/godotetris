class_name PieceBlueprint

var shapes: Array[Shape]
var atlas_coords: Vector2i

func _init(shapes_arr: Array[Shape], atlas_coords_vector: Vector2i):
	self.shapes = shapes_arr
	self.atlas_coords = atlas_coords_vector

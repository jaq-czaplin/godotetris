class_name Piece

var shapes: Array[Shape]
var atlas_coords: Vector2i
var position: Vector2i = Vector2i.ZERO

func _init(blueprint: PieceBlueprint, pos: Vector2i):
	self.shapes = blueprint.shapes
	self.atlas_coords = blueprint.atlas_coords
	self.position = pos

class_name Piece

var shapes: Array[Shape]
var atlas_coords: Vector2i
var position: Vector2i = Vector2i.ZERO
var rotation: int = 0

func _init(blueprint: PieceBlueprint, pos: Vector2i):
	self.shapes = blueprint.shapes
	self.atlas_coords = blueprint.atlas_coords
	self.position = pos

func reset(blueprint: PieceBlueprint, pos: Vector2i):
	self.shapes = blueprint.shapes
	self.atlas_coords = blueprint.atlas_coords
	self.position = pos
	self.rotation = 0

func get_next_rotation():
	return (self.rotation + 1) % self.shapes.size()
	

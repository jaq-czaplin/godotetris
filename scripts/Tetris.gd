class_name Tetris extends Node2D

@onready var grid = $Grid as Grid
@onready var ui = $UI as UI

const SPAWN_POS = Vector2i(5, 1)



func _ready():
	new_game()

func _process(_delta):
	pass



func new_game():
	var current_blueprint_index = Blueprints.get_random_blueprint_index()
	var current_blueprint = Blueprints.get_blueprint_by_index(current_blueprint_index) as PieceBlueprint
	var current_shape = current_blueprint.shapes[0]
	grid.draw_piece_shape(current_shape, SPAWN_POS, current_blueprint.atlas_coords)
	
	
	
	pass

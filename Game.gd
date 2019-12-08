extends Node2D

export (PackedScene) var Tile

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

################
### 3-D Indexed ITEM arrays -> Really a 4-D list
#######
### Access: map_items[x_coord][y_coord][z-_coord] = {list of Item scenes}
var map_items = [] #items that can be picked up...
var map_buildings = [] #building items (no diff between top and bottom) -> Always under creature
var neighboorhood_layout #will hold the neighborhood layout data
var neighboorhood_flow_map #Will hold the layout flow data
var wall_indices = [102] #tile indices that creatures can't walk through
var street_blocks = [] #will hold the street block objects

#STANDARD GAME SCENE GLOBALS
var world_width #the size of the map (in pixels)
var world_height #the size of the map (in pixels)
var map_width #the size of the map (in cells/tiles) SCREEN DIMS!!
var map_height #the size of the map (in cells/tiles) SCREEN DIMS!!
var cell_size = 16 #the amount of pixels in a cell/tile
#BROADER WORLD VARS
var max_x_block = 17
var max_y_block = 17
var max_x_map = 8 * max_x_block #How big the generated map is... (8 tiles per block)
var max_y_map = 8 * max_y_block
var min_x_map = 0
var min_y_map = 0
var max_z_map = 20 #How high the map goes
var min_z_map = 0 #The lowest level


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	randomize(); 
	
	#Screen Dimension stuff
	world_width = get_viewport().size.x
	world_height = get_viewport().size.y
	map_width = int($TileMap.world_to_map(Vector2(world_width,0)).x)
	map_height = int($TileMap.world_to_map(Vector2(0,world_height)).y)
	
	#Generate some perlin noise...
	var perlin_values = RogueGen.GeneratePerlinImage(70,70,10,10)
			
			
#	#Iterate over the noise values
#	var max_val = -9999
#	var min_val = 9999
#	for i in range(perlin_values.size()):
#		for j in range(perlin_values[0].size()):
#			if perlin_values[i][j] > max_val:
#				max_val = perlin_values[i][j]
#			if perlin_values[i][j] < min_val:
#				min_val = perlin_values[i][j]
#
#	print(max_val)
#	print(min_val)

	#ITerate over the noise values and create tiles
	for i in range(perlin_values.size()):
		for j in range(perlin_values[0].size()):
			var value = perlin_values[i][j]
			#var color_value = Color(value, value, value, 1.0)
			var color_value = Color(value, value, value, 1.0)
			var temp_tile = Tile.instance()
			temp_tile.position.x = i * cell_size
			temp_tile.position.y = j * cell_size
			temp_tile.get_child(0).modulate = color_value
			add_child(temp_tile)
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

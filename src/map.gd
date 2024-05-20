class_name Map
extends Node2D

@onready var tileSpawner = preload ("res://tile.tscn")

# 2D grid of tiles
var tiles: Array[Array] = []

# Map size
@export var map_size = Vector2i(41, 23)

# Tile size
@export var tile_size = 32

func _ready():
	# Set the tile size
	for x in range(0, map_size.x):
		tiles.append([])
		for y in range(0, map_size.y):
			var tile = tileSpawner.instantiate() as Tile
			tile.position = Vector2(x, y) * tile_size
			tile.map_pos = Vector2i(x, y)
			if x == 0 or x == map_size.x - 1 or y == 0 or y == map_size.y - 1:
				tile.state = Tile.State.WALL
			else:
				tile.state = Tile.State.EMPTY
			add_child(tile)
			tile.size = tile_size
			tiles[x].push_back(tile)

func spawn_food():
	var coordx = (randi() % (map_size.x - 2)) + 1
	var coordy = (randi() % (map_size.y - 2)) + 1

	get_tile(coordx, coordy).state = Tile.State.FOOD

func middle_tile() -> Tile:
	return tiles[floor(map_size.x / 2)][floor(map_size.y / 2)]

func get_tile(x: int, y: int) -> Tile:
	return tiles[x][y]

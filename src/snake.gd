class_name Snake
extends Node2D

signal snip(value: int)

# Controls WASD

@onready var segmentSpawner = preload ("res://Segment.tscn")
@export var map: Map

var segments: Array[Segment] = []

var speed = 100
var direction = Vector2i(1, 0)

func move() -> void: # Called by the main loop
	var target = segments[0].map_pos + direction
	var targetTile = map.get_tile(target.x, target.y)

	if targetTile.state == Tile.State.WALL:
		# Game over
		get_tree().reload_current_scene()
		return
	
	var length = segments.size()

	for i in range(0, length - 1):
		if segments[i].map_pos == target:
			var deadSegments = segments.slice(i, length)
			snip.emit(deadSegments.size())

			for segment in deadSegments:
				segment.wither()
				
			segments = segments.slice(0, i)
			break

	# Add new segment at the front
	_add_head(targetTile)

	if targetTile.state != Tile.State.FOOD:
		# Remove the last segment
		var tail = segments.pop_back()
		tail.queue_free()
	
	targetTile.state = Tile.State.EMPTY

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up") and direction != Vector2i(0, 1):
		direction = Vector2i(0, -1)
	elif event.is_action_pressed("ui_down") and direction != Vector2i(0, -1):
		direction = Vector2i(0, 1)
	elif event.is_action_pressed("ui_left") and direction != Vector2i(1, 0):
		direction = Vector2i( - 1, 0)
	elif event.is_action_pressed("ui_right") and direction != Vector2i( - 1, 0):
		direction = Vector2i(1, 0)

func _ready() -> void:
	var start = map.middle_tile()
	_add_head(start)

func _add_head(targetTile: Tile) -> void:
	var head = segmentSpawner.instantiate() as Segment
	add_child(head)
	head.size = map.tile_size * 0.8
	head.position = targetTile.position
	head.map_pos = targetTile.map_pos
	segments.push_front(head)

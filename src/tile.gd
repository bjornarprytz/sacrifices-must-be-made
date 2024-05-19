class_name Tile
extends Node2D

enum State {EMPTY, WALL, FOOD}

var size: float:
	set(value):
		color.size = Vector2(value, value)

var map_pos = Vector2i(0, 0)

var state: State = State.EMPTY:
	set(value):
		state = value
		match state:
			State.EMPTY:
				$Color.color = Color(1, 1, 1)
			State.WALL:
				$Color.color = Color(0, 0, 0)
			State.FOOD:
				$Color.color = Color(0, 1, 0)

@onready var color: ColorRect = $Color

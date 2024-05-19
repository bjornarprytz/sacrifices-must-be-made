extends Node2D

@onready var snake: Snake = $Snake
@onready var map: Map = $Map
@onready var score: RichTextLabel = $Camera/UI/Score

var speed = 100
var points: int

# Move the player each tick

var interval = 0.2
var food_interval = 10

func _process(delta):

	interval -= delta

	if interval <= 0:
		interval = 0.1
		snake.move()
		food_interval -= 1
		if food_interval <= 0:
			food_interval = 10
			map.spawn_food()


func _on_snake_points(value: int) -> void:
	points += value
	
	score.text = str(points)

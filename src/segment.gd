class_name Segment
extends Node2D

var size: float:
	set(value):
		color.size = Vector2(value, value)

var map_pos: Vector2i

@onready var color: ColorRect = $Color

func wither():
	var tween = create_tween().tween_property(self, "scale", Vector2(0, 0), 1.0)

	await tween.finished

	queue_free()

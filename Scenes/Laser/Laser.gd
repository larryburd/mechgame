extends Area2D


const SPEED = 1000.0
var area_direction = Vector2(0, 0)
var debounce = false

func _process(delta):
	self.translate(area_direction * SPEED * delta)

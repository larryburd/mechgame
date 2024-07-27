extends Node2D

@onready var level_music = $LevelMusic

# Called when the node enters the scene tree for the first time.
func _ready():
	level_music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !level_music.playing:
		level_music.play()

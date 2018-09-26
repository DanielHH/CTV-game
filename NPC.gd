extends KinematicBody2D

signal hit
signal dead

export (int) var speed
export (int) var health

var screensize


func _ready():
	$AnimatedSprite.animation = "walk_right"
	screensize = get_viewport_rect().size
	hide()

# Controls
func _process(delta):
	pass

# Starting a new game
func start(pos):
    position = pos
    show()
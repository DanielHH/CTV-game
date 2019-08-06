extends KinematicBody2D

signal hit
signal dead

export (int) var speed
export (int) var health

var screensize

onready var parent = get_parent()

func _ready():
	screensize = get_viewport_rect().size
	hide()

# Controls
func _process(delta):
	pass

func take_damage(damage):
	health -= damage
	if health > 0:
		$AnimatedSprite.animation = "get_shot"
		$getshottimer.start()
	else:
		$CollisionShape2D.disabled = true
		$AnimatedSprite.animation = "die_right"
	

# Starting a new game
func start(pos):
	position = pos
	show()

func _on_getshottimer_timeout():
	print("walk_right")
	$AnimatedSprite.animation = "walk_right"
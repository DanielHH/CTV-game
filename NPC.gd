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

func take_damage(damage):
	health -= damage
	if health <= 0:
		$AnimatedSprite.animation = "die_right"
		$dietimer.start()
	else:
		$AnimatedSprite.animation = "get_shot"
		$getshottimer.start()
	

# Starting a new game
func start(pos):
    position = pos
    show()

func _on_getshottimer_timeout():
	$AnimatedSprite.animation = "walk_right"


func _on_dietimer_timeout():
	queue_free()

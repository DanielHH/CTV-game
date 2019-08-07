extends KinematicBody2D

signal hit
signal dead

export (int) var speed
export (int) var health

var velocity = Vector2()
var alive = true

func _ready():
	#hide()
	pass

# Controls
func _process(delta):
	if health <= 0:
		$CollisionShape2D.set_disabled(true)
		set_z_index(0)

func control(delta):
	pass
		
func _physics_process(delta):
	if not alive:
		return
	control(delta)
	move_and_slide(velocity)

func take_damage(damage):
	health -= damage
	if health > 0:
		$AnimatedSprite.animation = "get_shot"
		$getshottimer.start()
	else:
		$AnimatedSprite.animation = "die_right"

"""
# Starting a new game
func start(pos):
	position = pos
	show()
"""

func _on_getshottimer_timeout():
	$AnimatedSprite.animation = "walk_right"
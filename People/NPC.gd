extends KinematicBody2D

onready var parent = get_parent()

signal hit
signal dead

export (int) var speed
export (int) var health

export (bool) var infected

var velocity = Vector2()
var alive = true

func _ready():
	if not infected:
		$InfectedSmoke.set_visible(false)
		speed = 100

# Controls
func _process(delta):
	if health <= 0:
		$CollisionShape2D.set_disabled(true)
		set_z_index(0)

func control(delta):
	if parent is PathFollow2D and health > 0:
		parent.set_offset(parent.get_offset() + speed * delta)
		position = Vector2()
	
func _physics_process(delta):
	if not alive:
		return
	control(delta)
	move_and_collide(velocity)

func take_damage(damage):
	health -= damage
	if health > 0:
		$AnimatedSprite.animation = "get_shot"
		$getshottimer.start()
	else:
		alive = false
		$AnimatedSprite.animation = "die_right"

"""
# Starting a new game
func start(pos):
	position = pos
	show()
"""

func _on_getshottimer_timeout():
	$AnimatedSprite.animation = "walk_right"
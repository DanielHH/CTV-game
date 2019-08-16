extends KinematicBody2D

onready var parent = get_parent()

signal hit
signal dead
signal is_infected

export (int) var speed
export (int) var health

export (bool) var infected

var velocity = Vector2()
var alive = true

func _ready():
	speed = 0
	if not infected:
		$InfectionArea/CollisionShape2D.set_disabled(true)
		$InfectedSmoke.set_visible(false)

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
		emit_signal("dead", infected)
		$getshottimer.stop()
		$AnimatedSprite.animation = "die_right"

func become_infected():
	if not infected:
		infected = true
		$InfectedSmoke.set_visible(true)
		$InfectionArea/CollisionShape2D.set_disabled(false)
		speed = 60
		emit_signal("is_infected")

func start_walking():
	if not infected:
		speed = 100
	else:
		speed = 125

func _on_getshottimer_timeout():
	$AnimatedSprite.animation = "walk_right"

func _on_InfectionArea_body_entered(body):
	if body.has_method('become_infected'):
		body.become_infected()

func is_infected():
	if infected:
		emit_signal("is_infected")

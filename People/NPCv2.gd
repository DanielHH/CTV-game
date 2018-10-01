extends Area2D

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
		var transform = get_node("CollisionShape2D").get_transform()
		Get_node("CollisionShape2D").Set_scale(Vector2(0, 0))
		#queue_free()

# Starting a new game
func start(pos):
    position = pos
    show()
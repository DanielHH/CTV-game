extends Area2D

signal hit
signal dead

export (PackedScene) var Bullet
export (int) var speed
export (int) var health

var screensize


func _ready():
	screensize = get_viewport_rect().size
	hide()

# Controls
func _process(delta):
	pass
	
# Colliding with another body
func _on_Player_body_entered(body):
    hide() # Player disappears after being hit.
    emit_signal("hit")
    $CollisionShape2D.disabled = true

# Starting a new game
func start(pos):
    position = pos
    show()
    $CollisionShape2D.disabled = false
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
	var velocity = Vector2() # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	if velocity.x != 0:
    	$AnimatedSprite.animation = "right"
    	$AnimatedSprite.flip_v = false
    	$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
    	$AnimatedSprite.animation = "up"
    	$AnimatedSprite.flip_v = velocity.y > 0
	
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
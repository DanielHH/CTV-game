extends KinematicBody2D

signal hit
signal shoot
signal dead

export (PackedScene) var Bullet
export (int) var speed
export (int) var health
export (float) var gun_cooldown

var screensize

var can_shoot = true
var alive = true


func _ready():
	screensize = get_viewport_rect().size
	$GunTimer.wait_time = gun_cooldown
	hide()

# Controls
func _process(delta):
	move_and_collide(Vector2(0, 0))
	var velocity = Vector2() # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_just_pressed("shoot"):
		shoot()

	if (velocity.length() > 0):
		velocity = velocity.normalized() * speed
		$Body.play()
	else:
		$Body.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	if velocity.x != 0:
    	$Body.animation = "right"
    	$Body.flip_v = false
    	$Body.flip_h = velocity.x < 0
	elif velocity.y != 0:
    	$Body.animation = "up"
    	$Body.flip_v = velocity.y > 0

func shoot():
	if can_shoot:
		can_shoot = false
		$GunTimer.start()
		var dir = Vector2(1, 0)
		var pos = $Muzzleright.global_position
		if $Body.animation == "right":
			if $Body.flip_h == true:
				dir = Vector2(-1, 0)
				pos = $Muzzleleft.global_position
		elif $Body.animation == "up":
			dir = Vector2(0, -1)
			pos = $Muzzleup.global_position
			if $Body.flip_v == true:
				dir = Vector2(0, 1)
				pos = $Muzzledown.global_position
		emit_signal('shoot', Bullet, pos, dir)

# Starting a new game
func start(pos):
    position = pos
    show()
    $CollisionShape2D.disabled = false

func _on_GunTimer_timeout():
	can_shoot = true
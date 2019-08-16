extends KinematicBody2D

signal hit
signal shoot
signal dead
signal reloading
signal reloaded

export (PackedScene) var Bullet
export (int) var speed
export (int) var health
export (float) var gun_cooldown
export (float) var reload_time
export (int) var mags_left

var screensize

var can_shoot = false
var alive = true
var bullets_left = 8

### Introduce reload action
func _ready():
	$GunTimer.wait_time = gun_cooldown
	$ReloadTimer.wait_time = reload_time
	screensize = get_viewport_rect().size
	#hide()

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
	if Input.is_action_just_pressed("reload"):
		reload()

	if (velocity.length() > 0):
		velocity = velocity.normalized() * speed
		$Body.play()
	else:
		$Body.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	var col_right = Vector2(0, 4.181)
	var col_left = Vector2(0, -4.181)
	var col_down = Vector2(-4.181, 0)
	var col_up = Vector2(4.181, 0)
	
	if velocity != Vector2(0, 0):
		if not $Sounds/StepSound.is_playing():
			$Sounds/StepSound.play()
		if velocity.x > 0: # Move right
			adjust_body("right", false, 90, col_right)
		elif velocity.x < 0: # Move left
			adjust_body("right", true, 90, col_left)
		elif velocity.y > 0: # Move down
	    	adjust_body("up", true, 0, col_down)
		elif velocity.y < 0: # Move up
			adjust_body("up", false, 0, col_up)
	else:
		if $Sounds/StepSound.is_playing():
			$Sounds/StepSound.stop()

func shoot():
	if can_shoot:
		if bullets_left > 0:
			bullets_left -= 1
			can_shoot = false
			$GunTimer.start()
			var dir = Vector2(1, 0)
			var pos = $Muzzle/Muzzleright.global_position
			if $Body.animation == "right":
				if $Body.flip_h == true:
					dir = Vector2(-1, 0)
					pos = $Muzzle/Muzzleleft.global_position
			elif $Body.animation == "up":
				dir = Vector2(0, -1)
				pos = $Muzzle/Muzzleup.global_position
				if $Body.flip_v == true:
					dir = Vector2(0, 1)
					pos = $Muzzle/Muzzledown.global_position
			emit_signal('shoot', Bullet, pos, dir, bullets_left)
			$Sounds/ShotSound.play()
		else:
			$Sounds/ClickSound.play()

func reload():
	if$ReloadTimer.is_stopped():
		if mags_left > 0:
			if bullets_left < 8:
				mags_left -= 1
				$GunTimer.stop()
				can_shoot = false
				$ReloadTimer.start()
				emit_signal('reloading', mags_left)
				$Sounds/ReloadSound.play()

# Starting a new game
func start(pos):
    position = pos
    show()
    $BodyCollisionShape.disabled = false

func adjust_body(anim, is_flip, rot, pos):
		$Body.animation = anim
		$Body.flip_h = is_flip
		$Body.flip_v = is_flip
		$BodyCollisionShape.set_rotation_degrees(rot)
		$BodyCollisionShape.set_position(pos)

func _on_GunTimer_timeout():
	can_shoot = true

func _on_ReloadTimer_timeout():
	can_shoot = true
	bullets_left = 8
	emit_signal('reloaded', bullets_left)

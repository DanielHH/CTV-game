extends CanvasLayer

signal start_level
signal reset_level

var fresh_game = true

func _ready():
	pass

func _input(ev):
	if ev is InputEventKey and $StartButton.is_visible():
		_on_StartButton_pressed()

func show_message(text):
    $MessageLabel.text = text
    $MessageLabel.show()
    $MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	$MessageLabel.text = "The Virus got out..."
	$StartButton.text = "Restart"
	$MessageLabel.show()
	$StartButton.show()
	
func update_chamber(bullets_left):
	bullets_left = str(bullets_left)
	$BulletLabel.text = "Chamber: " + bullets_left + "/8"

func update_mags(mags_left):
	mags_left = str(mags_left)
	$MagLabel.text = "Mags: " + mags_left
	
func reloading():
	$BulletLabel.text = "Reloading..."

func _on_StartButton_pressed():
	if fresh_game:
		$StartButton.hide()
		emit_signal("start_level")
		fresh_game = false
	else:
		emit_signal("reset_level")

func _on_MessageTimer_timeout():
	$MessageLabel.hide()




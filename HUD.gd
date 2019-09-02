extends CanvasLayer

signal start_level
signal reset_level
signal next_level

var fresh_game = true

func _ready():
	pass

func _input(ev):
	if ev is InputEventKey and $StartButton.is_visible() and $StartButton.get_text() == "Start":
		_on_StartButton_pressed()

func show_message(text):
    $MessageLabel.text = text
    $MessageLabel.show()
    $MessageTimer.start()
	
func update_chamber(bullets_left):
	bullets_left = str(bullets_left)
	$BulletLabel.text = "Gun: " + bullets_left + "/8"

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
	elif $StartButton.get_text() == "Restart":
		emit_signal("reset_level")
	elif $StartButton.get_text() == "Next Level":
		emit_signal("next_level")

func _on_MessageTimer_timeout():
	$MessageLabel.hide()
	
func show_game_over(message):
	show_message(message)
	yield($MessageTimer, "timeout")
	$MessageLabel.text = "Game Over"
	$StartButton.text = "Restart"
	$MessageLabel.show()
	$StartButton.show()

func show_level_cleared(reward):
	$RewardLabel.text = "$" + str(global.total_money - reward) + " + " + "$" + str(reward)
	$MessageLabel.text = "Level Secured"
	$StartButton.text = "Next Level"
	$MessageLabel.show()
	$StartButton.show()



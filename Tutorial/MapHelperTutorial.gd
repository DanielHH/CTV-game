extends Node2D

var infected_left = 0

func _ready():
	$NPC/AnimatedSprite._set_playing(false)
	$NPC.is_infected()
	get_tree().call_group("NPCs", "is_infected")
	get_tree().call_group("NPCs", "stand_still")
	get_tree().call_group("NPCs", "hide")
	$HUD.update_mags($Player.mags_left)

func _on_Player_shoot(bullet, _position, _direction, bullets_left):
	var b = bullet.instance()
	add_child(b)
	b.start(_position, _direction)
	_on_Player_reloaded(bullets_left)
	
func _on_Player_reloading(mags_left):
	$HUD.reloading()
	$HUD.update_mags(mags_left)

func _on_Player_reloaded(bullets_left):
	$HUD.update_chamber(bullets_left)

func _on_Infected_Exit_game_over():
	$HUD.show_game_over()

func _start_level():
	$HUD/MessageLabel.hide()
	$TutorialCanvas.show_timed_message("This is Hector.")
	yield($TutorialCanvas/MessageTimer, "timeout")
	$TutorialCanvas.show_timed_message("He was sent by the company to contain this... mess.")
	yield($TutorialCanvas/MessageTimer, "timeout")
	$TutorialCanvas.show_triggered_message("Use the arrow keys to walk around.")
	$Player.can_walk = true

func _reset_level():
	get_tree().reload_current_scene()
	_start_level()

func _on_NPC_dead(is_infected):
	if is_infected:
		infected_left -= 1
		if infected_left == 0:
			$HUD.show_message("Level Secured")

func _on_NPC_is_infected():
	infected_left += 1
	$TutorialCanvas.show_timed_message("Oh shit! Another one got infected!")

func _on_Player_has_walked():
	$TutorialCanvas/MessageTimer.start()
	yield($TutorialCanvas/MessageTimer, "timeout")
	$TutorialCanvas.show_timed_message("Great job walking.")
	yield($TutorialCanvas/MessageTimer, "timeout")
	$TutorialCanvas.show_timed_message("See that 'smoky' guy? He's infected")
	yield($TutorialCanvas/MessageTimer, "timeout")
	$TutorialCanvas.show_triggered_message("Tap SPACEBAR to shoot him.")
	$Player.can_shoot = true

func _on_Player_first_shot():
	$TutorialCanvas.show_timed_message("Fine shooting!")
	yield($TutorialCanvas/MessageTimer, "timeout")
	$TutorialCanvas.show_timed_message("You may have noticed your gun carries limited ammo.")
	yield($TutorialCanvas/MessageTimer, "timeout")
	$TutorialCanvas.show_triggered_message("Press R to reload.")
	$Player.can_reload = true
	
func _on_Player_first_reload():
	$TutorialCanvas/MessageTimer.start()
	yield($TutorialCanvas/MessageTimer, "timeout")
	$TutorialCanvas.show_timed_message("Great reload! Notice your mags are also finite?")
	yield($TutorialCanvas/MessageTimer, "timeout")
	$TutorialCanvas.show_timed_message("Woah! Don't let the infected reach the Exit")
	get_tree().call_group("NPCs", "show")
	get_tree().call_group("NPCs", "start_walking")

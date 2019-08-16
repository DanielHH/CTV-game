extends Node2D

var infected_left = 0

func _ready():
	get_tree().call_group("NPCs", "is_infected")
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
	$HUD.show_message("Get Ready")
	yield($HUD/MessageTimer, "timeout")
	$Player.can_shoot = true
	get_tree().call_group("NPCs", "start_walking")

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
	print(infected_left)

extends Node2D

var infected_left = 0
var reward = 0
var game_over = false

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

func _on_HUD_start_level():
	$HUD.show_message("Get Ready")
	yield($HUD/MessageTimer, "timeout")
	$Player.can_shoot = true
	$Player.can_move = true
	get_tree().call_group("NPCs", "start_walking")

func _on_HUD_reset_level():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
	_on_HUD_start_level()

func _on_NPC_dead(is_infected):
	if is_infected:
		infected_left -= 1
		if infected_left == 0:
			global.total_money += reward
			$HUD.show_level_cleared(reward)
	else:
		reward -= 100

func _on_NPC_is_infected():
	infected_left += 1
	reward -= 100

func _on_Exit_game_over():
	if not game_over:
		game_over = true
		$HUD.show_game_over("The Virus got out...")

func _on_Player_game_over():
	if not game_over:
		game_over = true
		$HUD.show_game_over("Hector got infected")

func _on_NPC_reward():
	reward += 100

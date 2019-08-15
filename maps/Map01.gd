extends Node2D

var infected_left = 0

func _ready():
	get_tree().call_group("NPCs", "is_infected")
	$TileMap/Playerv2.start($TileMap/Playerstartposition.position)
	$HUD.update_mags($TileMap/Playerv2.mags_left)
	pass

func _on_Player_shoot(bullet, _position, _direction, bullets_left):
	var b = bullet.instance()
	add_child(b)
	b.start(_position, _direction)
	_on_reloaded(bullets_left)
	
func _on_Playerv2_reloading(mags_left):
	$HUD.reloading()
	$HUD.update_mags(mags_left)

func _on_reloaded(bullets_left):
	$HUD.update_chamber(bullets_left)

func _on_Infected_Exit_game_over():
	$HUD.show_game_over()

func new_game():
	$HUD.show_message("Get Ready")
	yield($HUD/MessageTimer, "timeout")
	$TileMap/Playerv2.can_shoot = true
	get_tree().call_group("NPCs", "start_walking")

func reset_level():
	get_tree().reload_current_scene()
	new_game()

func _on_NPC_dead(infected):
	if infected:
		infected_left -= 1
		if infected_left == 0:
			$HUD.show_message("Level Secured")

func _on_NPC_is_infected():
	infected_left += 1

extends Node2D

func _ready():
	$TileMap/Playerv2.start($TileMap/Playerstartposition.position)
	pass

func _on_Player_shoot(bullet, _position, _direction, bullets_left):
	var b = bullet.instance()
	add_child(b)
	b.start(_position, _direction)
	_on_reloaded(bullets_left)
	
func _on_Playerv2_reloading():
	$HUD.reloading()

func _on_reloaded(bullets_left):
	bullets_left = str(bullets_left)
	$HUD.update_chamber(bullets_left)

func _on_Infected_Exit_game_over():
	$HUD.show_game_over()

func new_game():
	$HUD.show_message("Get Ready")
	yield($HUD/MessageTimer, "timeout")
	get_tree().call_group("NPCs", "start_walking")

func reset_level():
	get_tree().reload_current_scene()
	new_game()


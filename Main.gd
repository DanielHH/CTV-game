extends Node2D

export (PackedScene) var Mob
var score

func _ready():
    randomize()

func game_over():
	$HUD.show_game_over()

func new_game():
	$Player.start($StartPosition.position)
	$HUD.show_message("Get Ready")

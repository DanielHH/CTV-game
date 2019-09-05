extends Node2D


func _ready():
	$MapHelper/HUD.show_start_message("Level 1")

func _on_HUD_next_level():
	get_tree().change_scene("res://Tutorial/MapTutorial.tscn")
	


extends Node2D


func _ready():
	pass

func _on_HUD_next_level():
	get_tree().change_scene("res://Tutorial/MapTutorial.tscn")

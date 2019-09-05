extends Node2D

func _ready():
	pass # Replace with function body.



func _on_HUD_next_level():
	get_tree().change_scene("res://maps/Map01.tscn")

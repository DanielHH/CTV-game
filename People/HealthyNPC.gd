extends "res://People/NPC.gd"

onready var parent = get_parent()

func control(delta):
	if parent is PathFollow2D and health > 0:
		parent.set_offset(parent.get_offset() + speed * delta)
		position = Vector2()
	else:
		# other movement code
		pass
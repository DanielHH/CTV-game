extends Node2D

func _ready():
	$Player.start($Playerstartposition.position)
	$NPC.start($NPCstartposition.position)

func _on_Killer_shoot(bullet, _position, _direction):
	var b = bullet.instance()
	add_child(b)
	b.start(_position, _direction)
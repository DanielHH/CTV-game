extends Node2D

func _ready():
	$TileMap/Playerv2.start($TileMap/Playerstartposition.position)
	#$TileMap/Exit.start($TileMap/Exitposition.position)
	#$TileMap/NPC.start($TileMap/NPCstartposition.position)
	pass

func _on_Player_shoot(bullet, _position, _direction):
	var b = bullet.instance()
	add_child(b)
	b.start(_position, _direction)

extends Area2D

signal game_over

func _ready():
	pass # Replace with function body.

func escape(body):
	body.free()

func _on_Exit_body_entered(body):
	if body.has_method('become_infected'):
		if body.infected:
			print("Hella Nawww") # GAME OVER!
			emit_signal("game_over")
		else:
			pass # Add points to player score!
		escape(body)

# Starting a new game
func start(pos):
	position = pos
	show()
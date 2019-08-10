extends Area2D

func _ready():
	pass # Replace with function body.


func escape(body):
	body.free()

func _on_Exit_body_entered(body):
	print(body)
	escape(body)

# Starting a new game
func start(pos):
	position = pos
	show()
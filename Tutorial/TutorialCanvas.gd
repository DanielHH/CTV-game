extends CanvasLayer

func _ready():
	pass

func show_timed_message(text):
    $MessageLabel.text = text
    $MessageLabel.show()
    $MessageTimer.start()
	
func show_triggered_message(text):
    $MessageLabel.text = text
    $MessageLabel.show()

func _on_MessageTimer_timeout():
	$MessageLabel.hide()

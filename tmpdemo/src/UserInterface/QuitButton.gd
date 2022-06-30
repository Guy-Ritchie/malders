extends Button

# The below function is triggered when the button is released.
func _on_button_up() -> void:
	get_tree().quit() # We're calling the quit method, of the top level node tree [remember the node tree from the Remote tab, on the left?? Yeah, that node tree. The one that consists of every node from the game.

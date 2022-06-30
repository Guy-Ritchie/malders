extends Button

func _on_button_up() -> void:
	PlayerData.score = 0
	get_tree().paused = false # You're setting the value of paused to false, because at the moment, when you release the key, you're actually unpausing the game, so we're passing the value of false to unpause the game.
	get_tree().reload_current_scene()

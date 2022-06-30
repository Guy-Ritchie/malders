extends Control

onready var label: Label = get_node("DataLabel") # We're getting the Label Node, which contains the text that shows the Score, and the Death count to the player on the EndScreen window to the user, in this node, to be able to cache it and use it later.

func _ready() -> void:
	label.text = label.text % [PlayerData.score, PlayerData.deaths] # You're changing the values of the Score, and Deaths, at the End screen, by changing the modifier tags you had set earlier, in the EndScreen.tscn scene.

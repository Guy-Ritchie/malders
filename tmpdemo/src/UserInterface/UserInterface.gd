extends Control

# Create a timer, that stores the elapsed_time value.
# Code here :
# When the time crosses 15 minutes, the game should exit on it's own.

onready var scene_tree: = get_tree() # We're getting the scene tree node, and storing it in the variable, inorder to cache it. 
onready var pause_overlay: ColorRect = get_node("PauseOverlay") # We're getting the node, inorder to toggle it's visibility after we've paused the game.
onready var score: Label = get_node("ScoreLabel") # Variable that is used to store the "score" value.
onready var death: Label = get_node("LivesLabel") # Variable that is used to store the "life" count value.
onready var pause_title: Label = get_node("PauseOverlay/Title")

const DEAD_MESSAGE: = "You died"

var paused: = false setget set_paused # The variable that we use to change the value of pause, throughout the running instance of the game.

func _ready() -> void: # Whatever's added to the ready function, is always loaded as soon as the game is started, at the top of the tree.
	PlayerData.connect("score_updated", self, "update_interface") # This makes it so that the score updated signal is started as soon as the game is started, at the start of the tree.
	PlayerData.connect("player_died", self, "_on_PlayerData_player_died")
	update_interface()
	death.text = "Deaths: %s" % PlayerData.deaths

func _on_PlayerData_player_died() -> void:
	death.text = "Deaths: %s" % PlayerData.deaths
	self.paused = true
	pause_title.text = DEAD_MESSAGE

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and pause_title.text != DEAD_MESSAGE: # This is done [the 'and' part of the if statement] inorder to make it so that, the user doesn't end up getting stuck in a place where he "Escapes" from the Player_Died scene, and is unable to move, unless he restarts the game from the pause_menu this time.
		self.paused = not paused # When we want to call the setter function, from within that same class, or from within that same script, we use the 'self' keyword.
		scene_tree.set_input_as_handled() # This makes sure, that all the different nodes, that react to the same input, are not reacting to the single key pressed.
		# Say you have 'Esc' mapped to handle two different events, like Pause, and also activate a shield or whatever in a game, then the above function, will make sure, that the second operation is not performed, and only one action takes place.
		# Or say, the player won't move in the scene when the game is paused, meaning the inputs like "Up" and "Right" won't work from the pause menu.

func update_interface() -> void:
	score.text = "Score: %s" % PlayerData.score

func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value

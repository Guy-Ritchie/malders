tool
extends Button

#get_tree()
#onready var anim_player: AnimationPlayer = get_node("/root/TimerInterface")

export(String, FILE) var next_scene_path: = ""
# Used to set the variable as a property, an interactable one at that, with the option to browse the filesystem using the gui, for the next_scene.

# The following function is triggered, when the button is released after being pressed.
func _on_button_up() -> void:
	#get_node("/root/TimerInterface").free()
	$"/root/TimerInterface/AnimationPlayer".play("hide") # Added a fade animation that plays when the TimerInterface screen is closed/moved on from.
	get_tree().change_scene(next_scene_path)
	#get_node("/root/TimerInterface").free() # Without doing this, the screen continues to be occupied by the TextureRect even after going to the next level.

# The following function, is used to warn the user, when they've forgotten to set the path to the next scene.
func _get_configuration_warning() -> String:
	return "next_scene_path must be set for the button to work" if next_scene_path == "" else ""

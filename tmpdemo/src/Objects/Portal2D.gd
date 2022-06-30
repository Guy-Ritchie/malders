tool
extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")
# # There is a short-hand for the get_node() function in godot. The '$' sign, can be used instead of the get_node() function, and you just start typing the name of the node, after the dollar sign, and godot will auto-complete for you
export var next_scene: PackedScene # We're exporting the next level as a scene object (.tscn files) in the next_scene variable which can be configured from the inspector tab.

func _on_body_entered(body: PhysicsBody2D) -> void:
	# The function that we use to call the teleport function.
	if PlayerData.key == 1:
		PlayerData.key = 0
		teleport()
#	pass
	#teleport()

func _get_configuration_warning() -> String:
	return "The next scene property can't be empty" if not next_scene else ""

func teleport() -> void:
	anim_player.play("fade_in")
	yield(anim_player, "animation_finished") # Yield is used to wait for any node in general in godot to emit a signal indicating that it has completed it's process.
	# We use yield here, to wait for the animation to end, so that we can change the scene to that of the next level.
	get_tree().change_scene_to(next_scene) # We get the scene tree here, inorder to change to the next scene, after playing the animation.
	

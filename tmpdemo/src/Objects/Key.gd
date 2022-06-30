extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")
# We're basically getting the Animation player node, and storing it's properties in the anim_player variable.
# The 'onready' keyword means, that The line, will be called before the ready() function built into godot, that we explicitly call..

func _on_body_entered(body: Node) -> void:
	PlayerData.key = 1 # I'm basically updating the value of the key, to be 1.
	# This is where the code, to update the label in the UserInterface containing the key should be made visible.
	anim_player.play("fade_out") # Playing the fade_out animation on the AnimatedSprite, as soon as a body enters it's collision shape.

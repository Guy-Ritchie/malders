extends KinematicBody2D
class_name Actor

const FLOOR_NORMAL := Vector2.UP

export var speed:= Vector2(300.0,1000.0) # Speed value used to check if the player is accelerating above the max limit, and change it back..
export var gravity:= 3000.0 # Just going to be an acceleration applied to players in the vertical axis.
var _velocity:= Vector2.ZERO # Set the _velocity to zero, so that the player doesn't move randomly, without any user input.

##func _physics_process(delta: float) -> void:
	# This is the function used to define all the physics properties for the actors
	# Physics properties like : Collision, Jumping, movement, etc.
	
	##var _velocity: = Vector2(300, 0) # A vector 2 has two values. A x and y co-ordinate.
	# It's used to represent a position, or a length.
	# Now the player is just moving to the right all the time, and so, we're going to add some gravity.
	
	##_velocity.y += gravity * delta # Delta = time elapsed since the previous frame.
	# _velocity = certain amount of pixels to move per second.
	
	##_velocity = move_and_slide(_velocity) # Now, we're just moving the character on the speed of '_velocity' variable's value [+ve = right, -ve = left]
	### Pressing Ctrl+Shift+Enter on a line, will create a new line before it.

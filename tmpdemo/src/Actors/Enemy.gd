extends "res://src/Actors/Actor.gd"

export var score: = 100

func _ready() -> void:
	# Allows us to set up our emeny, so that they start from the left corner, at the beginning of the scene.
	set_physics_process(false) # This is used to set the enemy inactive, or make the enemy not start moving before it comes into the frame.
	# The set_physics_process(false) is used to set the enemy inactive, to stop it moving to the left. By setting the visibility enabler, the enemy only stops moving towards the right, from left; not from right, towards the left. So this function, does just that.
	_velocity.x = -speed.x
	
func _on_StompDetector_body_entered(body: PhysicsBody2D) -> void:
	# This function is used to kill the enemy, when the player jumps on top of the enemy. This function essentially just deletes the enemy node, when the player jumps on top of the enemy.
	#if body.global_position.y < get_node("StompDetector").global_position.y:
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
	get_node("CollisionShape2D").disabled = true # This is done so that, you can no longer collide with the enemy.
	die()

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta # Helps keep the enemy stick to the floor, or to the top of the walls, rather than move mid-air.
	if is_on_wall(): # Used to check if the Enemy has hit the wall, in which case, we have to reverse it's direction.
		_velocity.x *= -1.0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y # Set it to only return the 'y' component, because, otherwise [here the 'move_and_slide' function upon being called will replace the 'x' value of the velocity variable, hence undoing the change we made in the is_on_wall() function] the enemy will get stuck upon colliding with a world object, and not return back, or change it's direction as it was intended to.
	

func die() -> void:
	PlayerData.score += score # Updating the value of score, which this node [Enemy] dies.
	queue_free()

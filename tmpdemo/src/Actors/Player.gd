extends Actor

#### As a convention, if a variable/method is preceded by an underscore, it means that the variable/method is actually private.

export var stomp_impulse: = 1000.0

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	# So, area entered means, the area will be an "Area2D" node, which is the stomp_detector, of our enemy..
	# This means, we have jumped on top of the enemy, and are killing it. Thus, this function, makes us jump a little bit upwards.
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

func _on_EnemyDetector_body_entered(body: Node) -> void:
	# The body entered means, the body will be the Enemy's "KinematicBody2D" which means that the player has touched/has been touched by the enemy body. This means that the player has to die.
	# Hence the freeing of the queue.
	# queue_free() # Used to be called here, to make the player die.
	die()


func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction:= get_direction() # Made this modular, inorder to make code easier to read [The moving of the Direction checker, to a seperate function]
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),	# To calculate the direction the player is moving in every frame.
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0	# The y co-ordinate value should be -1 if the player has to jump/move upwards, because like in most game engines, the y-axis is facing downwards in Godot.
	)

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2: # By explicitly passing the arguments to the function as parameters instead of defining them globally, we actually avoid quite a few errors, and a lot of bugs.
		# This saves us from problems like when the variable is globally scoped, then it becomes hard to keep track of when and where the value is modified.
	###var new_velocity:= linear_velocity # Was the name of the 'out' variable previously.
	var out:= linear_velocity
	### The variable name 'out' is quite long, so we can change it's name to something smaller, as the function name is descriptional enough already to give us an idea of what we're calculating in this function.
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
		# After Setting all this up, set the property 'gravity' 's value to 4000 in the Inspector Tab, after selecting the Player scene, and the player node.
	if is_jump_interrupted:
		out.y = 0.0 # This is used to make it so that, the pressure applied on the key, makes the player jump accordingly.
		# So the more longer a key is pressed, the higher the player jumps, a bit like Mario in that regard.
	return out


func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	# Used to make the player jump, upon stomping the enemy.
	var out: = linear_velocity
	out.y = -impulse
	return out

#func die() -> void:
#	if (PlayerData.deaths > 3 ):
#		queue_free()
		# Don't just free the queue. Go to the EndScreen.
#	else:
#		PlayerData.deaths += 1
#		PlayerData.key = 0
		#queue_free()
		# Restart the level now.
		# The level gets loaded very quickly, so, pause the game for like 2 secs inbetween.
		#get_tree().reload_current_scene()
		# Introducing Delay.
		#OS.delay_msec(300)
#	return

func die() -> void:
	PlayerData.deaths += 1
	queue_free()

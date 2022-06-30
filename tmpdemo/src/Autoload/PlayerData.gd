extends Node

signal key_updated
signal score_updated
signal player_died

var key: = 0 setget set_key
var score: = 0 setget set_score
var deaths: = 0 setget set_deaths

# Timer stuff :
var time_start: = 0
var time_now: = 0

func _ready() -> void:
	time_start = OS.get_ticks_msec() # The starting time. The time at which the game begins [In milliseconds].

func _physics_process(delta: float) -> void:
	time_now = OS.get_ticks_msec() # Current time. [In milliseconds]
	var time_elapsed: = time_now - time_start
	if time_elapsed > 900000: # 9,00,000 milli-seconds = 15 minutes
#	if time_elapsed > 60000 :
		# When the time crosses 15 minutes, the game must end. 9,00,000 ms = 15 mins.
		get_tree().quit()

func reset() -> void:
	score = 0
	deaths = 0

func set_key(value: int) -> void:
	key = value
	emit_signal("key_updated")

func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated")

func set_deaths(value: int) -> void:
	deaths = value
	emit_signal("player_died")

# After death of the player, we've to restart the level.
# Count number of deaths, and if they're greater than 3, queue_free().
# Else, restart level, after updating the death count.

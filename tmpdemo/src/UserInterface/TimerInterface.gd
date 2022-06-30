extends Control

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

func _ready() -> void:
	pass # Replace with function body.
	anim_player.play("RESET")


#extends Area2D
#onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")
#func _on_body_entered(body: Node) -> void:
#	PlayerData.key = 1
#	anim_player.play("fade_out")

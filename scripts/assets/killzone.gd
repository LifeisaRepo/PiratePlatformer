extends Area2D

@onready var timer: Timer = $Timer

# On collision entered trigger
func _on_body_entered(body: Node2D) -> void:
	print("You died!")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()	# start timer for level restart

# On timer end trigger
func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()	# function to reload scene

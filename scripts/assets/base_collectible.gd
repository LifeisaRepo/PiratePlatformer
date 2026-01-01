extends Area2D

# Green arrow beside the function denotes that this function
# gets triggered by a Signal. (Kinda like Event Dispatchers, maybe ?!)
func _on_body_entered(body: Node2D) -> void:
	print("+1 coin")
	queue_free()

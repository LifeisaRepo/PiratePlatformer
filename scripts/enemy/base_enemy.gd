extends Node2D

@export var movementSpeed = 60
@export var initFlipH = true
var movementDirection = 1

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var rayCastRight: RayCast2D = $RayCastRight
@onready var rayCastLeft: RayCast2D = $RayCastLeft

@export var health = 100
# Damage received from player attack per hit
@export var damagePerHit = 20


func enemy():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if rayCastRight.is_colliding():
		movementDirection = -1
		animatedSprite.flip_h = !initFlipH
	if rayCastLeft.is_colliding():
		movementDirection = 1
		animatedSprite.flip_h = initFlipH
	
	position.x += movementDirection * movementSpeed * delta

func take_damage():
	health -= damagePerHit
	if health <= 0:
		health = 0
		print ("Enemy dead")
		self.queue_free()
	else:
		print("health = ", health)

extends CharacterBody2D

const SPEED = 80.0
var direction = -1
var previousDirection = 0
var playerPawn = null

@export var health = 100
@export var damagePerHit = 20

@onready var charAnimSprite: AnimatedSprite2D = $CharAnimSprite2D
@onready var animTree: AnimationTree = $AnimationTree
@onready var rayCastRight: RayCast2D = $RayCastRight
@onready var rayCastLeft: RayCast2D = $RayCastLeft
@onready var detectionZone: Area2D = $detectionZone

# For has_method() check
func enemy():
	pass

func _ready():
	animTree.get("parameters/playback").travel("idle")

func _physics_process(delta: float) -> void:

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if rayCastRight.is_colliding() and playerPawn == null:
		set_direction(-1)
	if rayCastLeft.is_colliding() and playerPawn == null:
		set_direction(1)

	# Physical movement code
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if absf(velocity.x) > 1.0:
		animTree.get("parameters/playback").travel("run")
	else:
		animTree.get("parameters/playback").travel("idle")
		

	move_and_slide()

func set_direction(val: float):
	direction = signf(val)
	if direction < 0:
		charAnimSprite.flip_h = false
	elif direction > 0:
		charAnimSprite.flip_h = true


func _on_detection_zone_body_entered(body:Node2D) -> void:
	print(body.name)
	if body.has_method("is_player"):
		playerPawn = body
		set_direction(signf(playerPawn.position.x - self.position.x))

func _on_detection_zone_body_exited(body:Node2D) -> void:
	if body.has_method("is_player"):
		playerPawn = null


func _on_hitbox_body_entered(body:Node2D) -> void:
	if body.has_method("is_player"):
		previousDirection = direction
		set_direction(0)


func _on_hitbox_body_exited(body:Node2D) -> void:
	if body.has_method("is_player"):
		set_direction(previousDirection)



		

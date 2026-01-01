extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -360.0
var isFalling = false
var playingGround = false

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# -1, 0, 1
	var direction := Input.get_axis("moveLeft", "moveRight")
	
	# Flipping the sprite
	if direction > 0:
		animatedSprite.flip_h = false
	elif direction < 0:
		animatedSprite.flip_h = true
	
	# Setting the animation

	if Input.is_action_just_pressed("jump") and is_on_floor():
		animatedSprite.play("jump")
	elif not is_on_floor() and velocity.y > 0:
		animatedSprite.play("falling")
		isFalling = true
	elif is_on_floor() and isFalling:
		animatedSprite.play("ground")
		playingGround = true
		isFalling = false
	elif direction == 0 and is_on_floor() and not playingGround:
		# print("Test1")
		animatedSprite.play("idle")
	elif is_on_floor() and not playingGround:
		# print("Test2")
		animatedSprite.play("run")

	# Physical movement code
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_animated_sprite_2d_animation_finished() -> void:
	playingGround = false # Replace with function body.

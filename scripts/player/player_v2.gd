extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -360.0
var isFalling = false
var playingGround = false
var attackAnimIndex = 0

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animTree: AnimationTree = $AnimationTree

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
		
	
	if animTree.get("parameters/playback").get_current_node() == StringName("falling"):
		animTree.set("parameters/conditions/fallingComplete", is_on_floor() and isFalling)
	
	if animTree.get("parameters/playback").get_current_node() == StringName("ground"):
		isFalling = false
		animTree.set("parameters/conditions/fallingComplete", is_on_floor() and isFalling)
	
	# Setting the animation
	if Input.is_action_just_pressed("jump") and is_on_floor():
		animTree.get("parameters/playback").travel("jump")
		isFalling = true
	elif direction != 0 and is_on_floor():
		animTree.get("parameters/playback").travel("run")
		animTree.set("parameters/conditions/isIdle", false)
	elif is_on_floor():
		animTree.get("parameters/playback").travel("idle")
		animTree.set("parameters/conditions/isIdle", true)
		
	if Input.is_action_just_pressed("attack") and is_on_floor():
		if attackAnimIndex < 3:
			attackAnimIndex += 1
		else:
			attackAnimIndex = 1
		var attackName = "attack_" + str(attackAnimIndex)
		print(attackName)
		animTree.set("parameters/attacks/Transition/transition_request", attackName)
		animTree.get("parameters/playback").travel("attacks")
	elif Input.is_action_just_pressed("attack"):
		if attackAnimIndex < 2:
			attackAnimIndex +=1
		else:
			attackAnimIndex = 1
		var airAttackName = "air_attack_" + str(attackAnimIndex)
		animTree.set("parameters/attacks/Transition/transition_request", airAttackName)
		animTree.get("parameters/playback").travel("air_attacks")

	# Physical movement code
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_animated_sprite_2d_animation_finished() -> void:
	playingGround = false # Replace with function body.

extends Node2D

@export var sprite_count: int = 5
@export var MovementSpeed = 10.0
var currentPos: int = 448
var sprites: Array[Sprite2D] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	for i in range(sprite_count):
		var sprite := Sprite2D.new()
		sprite.texture = load("res://assets/Treasure Hunters/Palm Tree Island/Sprites/Background/Big Clouds.png")
		sprite.position = Vector2(i * currentPos, 0) 
		add_child(sprite)
		sprites.append(sprite)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in range(sprite_count):
		if(sprites[i].transform.get_origin().x < -448):
			sprites[i].translate(Vector2(currentPos * (sprites.size() - 1), 0))
		else:
			sprites[i].translate(Vector2(MovementSpeed * -delta, 0))

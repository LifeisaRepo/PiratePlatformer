extends Node2D

@export var SpawnPointPosition: Vector2 = Vector2(0, 0)
@onready var spawnpoint: Node2D = $spawnpoint

@export var sprite_count: int = 5
@export var MovementSpeedRange = Vector2(10.0, 10.0)
@export var ScaleRange = Vector2(0.7, 2.5)
@export var InitSpawnMinMaxX = Vector2(0,0)
@export var InitSpawnMinMaxY = Vector2(0,0)
var sprites: Array[Sprite2D] = []
var textures: Array[Texture2D] = [load("res://assets/Treasure Hunters/Palm Tree Island/Sprites/Background/Small Cloud 1.png"), load("res://assets/Treasure Hunters/Palm Tree Island/Sprites/Background/Small Cloud 2.png"), load("res://assets/Treasure Hunters/Palm Tree Island/Sprites/Background/Small Cloud 3.png")]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnpoint.translate(SpawnPointPosition)
	var previousCloudPos = Vector2(InitSpawnMinMaxX.x, InitSpawnMinMaxY.x)

	for i in range(sprite_count):
		var sprite := Sprite2D.new()
		sprite.texture = textures.pick_random()
		
		if(previousCloudPos.x > (InitSpawnMinMaxX.x+((InitSpawnMinMaxX.y-InitSpawnMinMaxX.x)/2))):
			previousCloudPos.x = randf_range(InitSpawnMinMaxX.x, previousCloudPos.x)
		else:
			previousCloudPos.x = randf_range(previousCloudPos.x, InitSpawnMinMaxX.y)
		
		if(previousCloudPos.y > (InitSpawnMinMaxY.x+((InitSpawnMinMaxY.y-InitSpawnMinMaxY.x)/2))):
			previousCloudPos.y = randf_range(InitSpawnMinMaxY.x, previousCloudPos.y)
		else:
			previousCloudPos.y = randf_range(previousCloudPos.y, InitSpawnMinMaxY.y)
		sprite.position =  previousCloudPos
		sprite.scale.x = randf_range(ScaleRange.x, ScaleRange.y)
		sprite.scale.y = sprite.scale.x
		add_child(sprite)
		sprites.append(sprite)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in range(sprite_count):
		if(sprites[i].transform.get_origin().x < InitSpawnMinMaxX.x):
			sprites[i].translate(Vector2(randf_range(InitSpawnMinMaxX.y+200, InitSpawnMinMaxX.y + 500), 0))
		else:
			sprites[i].translate(Vector2(randf_range(MovementSpeedRange.x, MovementSpeedRange.y) * -delta, 0))

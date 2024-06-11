extends Area2D
class_name Projectile

@export var SPRITE_TEXTURE: Texture
@export var animation_frames: int = 1
@export var speed: int = 300

@export var collisionWidthX = 10
@export var collisionWidthY = 10


@onready var projectile_sprite = $ProjectileSprite
@onready var collision_shape_2d = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if SPRITE_TEXTURE:	
		projectile_sprite.texture = SPRITE_TEXTURE
		projectile_sprite.vframes = animation_frames
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

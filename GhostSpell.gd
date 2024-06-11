extends Area2D

class_name GhostSpell
@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D

var SPEED = 500
var direction := Vector2() 

func _ready():
	if direction.angle() < 0:
		sprite_2d.flip_h = true

func _physics_process(delta):
	position += direction.normalized() * SPEED * delta
	
func play_animation()->void:
	animation_player.play("shoot")
	await animation_player.animation_finished
	animation_player.play("fly")

func _on_area_entered(area):
	queue_free()


func _on_body_entered(body):
	if body is Enemy: 
		body.destroy()
	queue_free()

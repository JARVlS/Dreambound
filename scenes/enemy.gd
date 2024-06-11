extends CharacterBody2D
class_name Enemy

const SPEED = 250.0
const JUMP_VELOCITY = -400.0

@export var startDirection: int
var direction: int


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	if startDirection: 
		direction = startDirection
	else:
		direction = 1

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	#auto walk
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if is_on_wall():
		direction = -1 if direction==1 else 1
	
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func destroy():
	queue_free()

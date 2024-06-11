extends CharacterBody2D


const SPEED = 300.0
const WALL_JUMP_SPEED = 500.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ally_jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		if is_on_wall_only():
			velocity.y = JUMP_VELOCITY
			velocity += get_wall_normal() * WALL_JUMP_SPEED 
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_ally_left", "move_ally_right")
	if direction and not is_on_floor():
		velocity.x += direction * SPEED * delta * 5
	if direction and is_on_floor():
		# = sets the speed like in Hollow Knight
		velocity.x = direction * SPEED 
	if not direction :
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	velocity.x = clamp(velocity.x, -SPEED, +SPEED)

	move_and_slide()

extends CharacterBody2D


enum STATES {READY, FIRING, RELOADING}
const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var last_direction := 1

@export var SPELL_SCENE: PackedScene
@onready var reload_timer = $ReloadTimer
@onready var sprite = $Sprite2D


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var state: STATES = STATES.READY

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or is_on_wall_only()):
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		if direction > 0: 
			last_direction = 1
		else: 
			last_direction = -1
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _input(event):
	if event.is_action_pressed("shoot_spell"):
		shoot()

func shoot():
	if state != STATES.READY: 
		return 
	state = STATES.FIRING	
	var spell: GhostSpell = SPELL_SCENE.instantiate()
	
	if last_direction > 0:
		spell.direction = Vector2.from_angle(0)
	else:
		spell.direction = Vector2.from_angle(PI)
		
	spell.global_position = global_position
	
	get_tree().root.add_child(spell)
	spell.play_animation()
	
	state = STATES.RELOADING
	
	reload_timer.start()
	

func _on_reload_timer_timeout():
	state = STATES.READY

extends CharacterBody2D

@onready var collision_shape= $CollisionShape2D

#@export var gravity : float = 0
@export var jumping_speed : float
@export var acceleration : float 
@export var speed : float
@export var push_force : float 

@export var animations : AnimatedSprite2D
@export var fsm : FSM
@export var idle_state : State
@export var run_state : State
@export var jump_state : State
@export var coyote_timer : Timer

var input = Vector2.ZERO
var was_on_floor : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	idle_state.enter_run.connect(fsm.change_state.bind(run_state))
	idle_state.enter_jump.connect(fsm.change_state.bind(jump_state))
	run_state.enter_idle.connect(fsm.change_state.bind(idle_state))
	run_state.enter_jump.connect(fsm.change_state.bind(jump_state))
	jump_state.enter_idle.connect(fsm.change_state.bind(idle_state))
	jump_state.enter_run.connect(fsm.change_state.bind(run_state))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input()
	velocity += get_gravity()*delta
	coyote_time()
	move()

func get_input():
	input.x = float(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))
	input.y = float(Input.is_action_just_pressed("Jump"))
	return input.normalized()

func move():
	velocity.x = lerp(velocity.x, input.x*speed, 0.1)
	if velocity.x < 0:
		animations.flip_h = true
		animations.position.x = -7
	else:
		animations.flip_h = false
		animations.position.x = 7
	if input.y != 0:
		if is_on_floor() or (!is_on_floor() and !coyote_timer.is_stopped()):
			velocity += jumping_speed*Vector2.UP
			
	move_and_slide()
	apply_push_force()
		

func coyote_time():
	if was_on_floor == true and is_on_floor()== false:
		coyote_timer.start()
	was_on_floor = is_on_floor()

func apply_push_force():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var object = collision.get_collider()
		if object is RigidBody2D:
			object.apply_central_force(- collision.get_normal()*push_force)
			#object.apply_central_force(Vector2.UP*get_gravity()*object.mass)
	

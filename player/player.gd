extends CharacterBody2D

@export var friction : float
@export var gravity : float
@export var jumping_velocity : float
@export var mass : float
@export var acceleration : float 
@export var speed : float

@export var animations : AnimatedSprite2D

var input = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	animations.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.y += gravity*delta
	get_input()
	move()
	

func get_input():
	input.x = float(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))
	#input.y = float(Input.is_action_just_pressed("Jump"))
	print(input)
	return input.normalized()

func move():
	velocity = lerp(velocity, input*speed, 0.1)
	move_and_slide()

func animate():
	pass

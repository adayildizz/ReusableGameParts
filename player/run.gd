extends State

signal enter_idle
signal enter_jump

@export var actor : CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)


func _enter_state():
	print("in run")
	set_physics_process(true)
	actor.animations.play("run")
	
	
func _physics_process(delta):
	
	#if it is not on air 
	if actor.velocity.y != 0:
		enter_jump.emit()
	else:
		if actor.input.x == 0:
			enter_idle.emit()
	
			
			

			

func _exit_state():
	set_physics_process(false)

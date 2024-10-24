extends State

signal enter_idle
signal enter_run


@export var actor : CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)


func _enter_state():
	print("in jump")
	set_physics_process(true)
	actor.animations.play("jump")
	
	
func _physics_process(delta):
	
	#if it is not on air 
	if actor.is_on_floor():
		if actor.velocity.x == 0:
			enter_idle.emit()
		else:
			enter_run.emit()
	else:
		if actor.velocity.y > 0:
			actor.animations.play("fall")
		else:
			actor.animations.play("jump")
	
			
	
			

func _exit_state():
	set_physics_process(false)

extends State
signal enter_run
signal enter_jump

@export var actor : CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)


func _enter_state():
	print("in idle")
	set_physics_process(true)
	actor.animations.play("idle")
	
	
func _physics_process(delta):
	
	if actor.is_on_floor():
		if actor.velocity.x != 0:
			enter_run.emit()
	else:
		enter_jump.emit()
			
	
			

func _exit_state():
	set_physics_process(false)

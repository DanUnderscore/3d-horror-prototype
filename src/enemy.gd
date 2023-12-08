extends KinematicBody

export var speed = 1500

onready var agent : NavigationAgent = $agent
onready var target

func _ready():
	
	yield(owner, "ready")
	target = owner.target
	

func _physics_process(delta):
	
	agent.set_target_location(target.transform.origin)
	
	var next = agent.get_next_location()
	
	var velocity = (next-transform.origin).normalized() * speed * delta
	
	move_and_slide(velocity, Vector3.UP, true)

func _on_player_checker_body_entered(body):
	if body.name == "player":
		print("death")

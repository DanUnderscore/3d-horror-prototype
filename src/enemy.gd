extends KinematicBody

export var speed = 1000

onready var agent : NavigationAgent = $agent
onready var target

var ableToMove = false

var debug = load("res://scenes/debug.tscn")

func _ready():
	
	yield(owner, "ready")
	target = owner.target
	

func _physics_process(delta):
	
	agent.set_target_location(target.transform.origin)
	
	var next = agent.get_next_location()
	
	var velocity = ((next-transform.origin).normalized() * speed * delta) * int(ableToMove)
	
	move_and_slide(velocity, Vector3.UP, true)

func _on_player_checker_body_entered(body):
	if body.name == "player":
		get_tree().change_scene_to(debug)

func _on_timer_timeout():
	ableToMove = not ableToMove

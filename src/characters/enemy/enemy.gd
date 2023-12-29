extends KinematicBody

export var speed = 1500

onready var agent : NavigationAgent = $agent
onready var target

# states
var isDecaying = false
var enabled = false

func _ready():
	pass

func _physics_process(delta):
	if enabled:
		agent.set_target_location(target.transform.origin) # it sets waypoint
		
		# i have no idea how these work for now
		var next = agent.get_next_location()
		
		var velocity = (next-transform.origin).normalized() * speed * delta
		
		move_and_slide(velocity, Vector3.UP, true) # moves the enemy

func _on_player_checker_body_entered(body):
	if body.name == "player": # if body is player
		print("death") # placeholder

func decay():
	isDecaying = true
	queue_free()

func target_given(trgt):
	target = trgt
	enabled = true

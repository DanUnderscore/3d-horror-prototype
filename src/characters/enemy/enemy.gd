extends KinematicBody

export var speed = 1500

onready var agent : NavigationAgent = $agent
onready var target

var enabled = true

func _ready():
	
	yield(owner, "ready")
	target = owner.target # it gets target(variable) from root of a scene an instance is in
	
	$audio.play()
	

func _physics_process(delta):
	if enabled:
		agent.set_target_location(target.transform.origin) # it sets waypoint
		
		# i have no idea how these work for now
		var next = agent.get_next_location()
		
		var velocity = (next-transform.origin).normalized() * speed * delta
		
# warning-ignore:return_value_discarded
		move_and_slide(velocity, Vector3.UP, true) # moves the enemy

func _on_player_checker_body_entered(body):
	if body.name == "player": # if body is player
		print("death") # placeholder

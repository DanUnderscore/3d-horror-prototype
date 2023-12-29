extends KinematicBody

var velocity = Vector3()

func _physics_process(_delta):
	velocity = move_and_slide(velocity, Vector3.UP, true) # makes it move 

func _on_lifetime_timeout():
	queue_free()

func _on_collided_checker_body_entered(body):
	
	queue_free()
	
	if body.is_in_group('enemies'): # if is in group enemies and the enemy variable isDecaying false then decay it
		if not body.isDecaying:
			body.decay()
	

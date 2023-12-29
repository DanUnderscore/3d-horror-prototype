extends KinematicBody

var rng = RandomNumberGenerator.new()
var velocity = Vector3()

# bullet stats
var bulletScatter = 2
var isDecaying = false

func _ready():
	rng.randomize()
	$collision.scale *= rng.randi_range(1,10)
	$mesh.scale = $collision.scale
	$collided_checker/collision.scale = $collision.scale

func _physics_process(_delta):
	velocity = move_and_slide(velocity, Vector3.UP, true)
	
	velocity = lerp(velocity, Vector3(0,0,0), 0.1)
	
	velocity.x += rng.randi_range(-bulletScatter, bulletScatter)
	velocity.y += rng.randi_range(-bulletScatter, bulletScatter)
	velocity.z += rng.randi_range(-bulletScatter, bulletScatter)
	
	if isDecaying:
		scale = lerp(scale, Vector3(0,0,0), 0.1)
	
		if scale == Vector3(0,0,0):
			queue_free()

func _on_collided_checker_body_entered(body):
	if not body.isDecaying and body.is_in_group('enemies'):
		body.decay()
		queue_free()
	
func _on_lifetime_timeout():
	isDecaying = true

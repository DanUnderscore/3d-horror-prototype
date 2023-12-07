extends KinematicBody

onready var twist_pivot = $TwistPivot
onready var pitch_pivot = $TwistPivot/PitchPivot

var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0


# velocity
var velocity = Vector3()

# constants
const BASE_WALKSPEED = 5
const BASE_JUMPPOWER = 45
const GRAVITY = -15

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# controller
func _physics_process(delta) -> void:
	var input_dir := Input.get_vector("movement_left","movement_right","movement_forward","movement_backward")
	var direction = (twist_pivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * BASE_WALKSPEED
		velocity.z = direction.z * BASE_WALKSPEED
		
	else:
		velocity.x = 0
		velocity.z = 0
	
	velocity = move_and_slide(velocity, Vector3.UP)
	
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x, -1, 1)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_pivot.rotate_y(-event.relative.x * mouse_sensitivity)
			pitch_pivot.rotate_x(-event.relative.y * mouse_sensitivity)

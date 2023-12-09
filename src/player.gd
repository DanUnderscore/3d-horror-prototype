extends KinematicBody

onready var twist_pivot = $twistpivot
onready var pitch_pivot = $twistpivot/pitchpivot
onready var material = $mesh.get_surface_material(0)
onready var mesh = $mesh

var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0


# velocity
var velocity = Vector3()

# constants
<<<<<<< Updated upstream
const BASE_WALKSPEED = 5
const BASE_JUMPPOWER = 45
const GRAVITY = -15
=======
const BASE_WALKSPEED = 10
const BASE_JUMPPOWER = 45
const GRAVITY = -30
var speed_multiplier = 3

# state
var isSprinting = false
>>>>>>> Stashed changes

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# controller
func _physics_process(delta) -> void:
	var input_dir := Input.get_vector("movement_left","movement_right","movement_forward","movement_backward")
	var direction = (twist_pivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
<<<<<<< Updated upstream
	if direction:
		velocity.x = direction.x * BASE_WALKSPEED
		velocity.z = direction.z * BASE_WALKSPEED
		
	else:
		velocity.x = 0
		velocity.z = 0
=======
	if is_on_floor():
		
		velocity.y = 0
		
		if direction:
			velocity.x = direction.x * BASE_WALKSPEED
			velocity.z = direction.z * BASE_WALKSPEED
			if isSprinting:
				velocity.x = direction.x * BASE_WALKSPEED * speed_multiplier
				velocity.z = direction.z * BASE_WALKSPEED * speed_multiplier
				
				
			
		else:
			velocity.x = 0
			velocity.z = 0
			
	else:
		velocity.y = GRAVITY
	
	
	if Input.is_action_pressed("movement_sprint"):
		isSprinting = true
		
	else:
		isSprinting = false
	
	if isSprinting:
		material.albedo_color = Color(1,0,1)
		
	else:
		material.albedo_color = Color(1,1,1)
	
>>>>>>> Stashed changes
	
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




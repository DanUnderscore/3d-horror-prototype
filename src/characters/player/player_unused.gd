extends KinematicBody

onready var twist_pivot = $twistpivot
onready var pitch_pivot = $twistpivot/pitchpivot
onready var cdtimer = $cdtimer
onready var staminameter = $UI/staminameter

var mouse_sensitivity := 0.002
var twist_input := 0.0
var pitch_input := 0.0


# velocity
var velocity = Vector3()

# constants
const BASE_WALKSPEED = 10
const BASE_JUMPPOWER = 45
const MAX_STAMINA = 500
const GRAVITY = -30
var speed_multiplier = 3
var stamina: float = 500

# states
var isSprinting = false
var isSprintEnabled = true

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# controller
func _physics_process(_delta) -> void:
	var input_dir := Input.get_vector("movement_left","movement_right","movement_forward","movement_backward")
	var direction = (twist_pivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if is_on_floor():
		if direction:
			velocity.x = direction.x * BASE_WALKSPEED * speed_multiplier
			velocity.z = direction.z * BASE_WALKSPEED * speed_multiplier
				
		else:
			velocity.x = 0
			velocity.z = 0
			
	else:
		velocity.y = GRAVITY
		
	
	velocity = move_and_slide(velocity, Vector3.UP, true)
	
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x, -1, 1)
	
	staminameter.text = str(int(stamina), "/", MAX_STAMINA)
	
	if Input.is_action_pressed("movement_sprint") and stamina > 0:
		isSprinting = true
		
	else:
		isSprinting = false
		
	
	if isSprinting:
		speed_multiplier = 3
		stamina -= 1
		if stamina < 0:
			isSprintEnabled = false
			stamina = 0
			cdtimer.start()
			print("cooldowning")
		
	else:
		speed_multiplier = 1
		if stamina < MAX_STAMINA and isSprintEnabled:
			stamina += .5
			
func _on_cdtimer_timeout():
	stamina = MAX_STAMINA
	isSprintEnabled = true
	cdtimer.stop()
	print("cooldowned")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_pivot.rotate_y(-event.relative.x * mouse_sensitivity)
			pitch_pivot.rotate_x(-event.relative.y * mouse_sensitivity)

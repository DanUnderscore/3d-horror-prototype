extends KinematicBody

# nodepaths
onready var cdtimer = $cdtimer
onready var twistpivot = $twistpivot
onready var inventory = $inventory

# fundamentals
var velocity = Vector3()

# player stats
const BASE_WALKSPEED = 10
const MAX_STAMINA = 500
const GRAVITY = -30

var speed_multiplier = 3
var stamina: float = 500

# states
var isSprinting = false
var isSprintEnabled = true

func _ready():
	# captures mouse for first person view mode
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# controller
func _physics_process(_delta) -> void:
	# code for the player's movement. the arguments in input_dir are the input map
	var input_dir := Input.get_vector("movement_left","movement_right","movement_forward","movement_backward")
	var direction = (twistpivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# player cant move while airborne. constraints player movement
	if is_on_floor():
		if direction:
			velocity.x = direction.x * BASE_WALKSPEED * speed_multiplier
			velocity.z = direction.z * BASE_WALKSPEED * speed_multiplier
				
		else:
			velocity.x = 0
			velocity.z = 0
			
	else:
		velocity.y = GRAVITY
		
	
	# if input movement_sprint:
	if Input.is_action_pressed("movement_sprint") and stamina > 0:
		isSprinting = true
		
	else:
		isSprinting = false
		
	
	# sprint movement code
	if isSprinting: # if sprinting
		
		speed_multiplier = 3
		stamina -= 1
		
		if stamina < 0: # and stamina is below 0
			
			isSprintEnabled = false
			stamina = 0 # the stamina UI label would show a negative number and thats bad so this is here
			
			cdtimer.start() # cooldowning
			print("cooldowning")
		
	else: # else not sprinting
		
		speed_multiplier = 1
		
		if stamina < MAX_STAMINA and isSprintEnabled: #  stamina is less than max and sprint is enabled
			stamina += .5
	
	velocity = move_and_slide(velocity, Vector3.UP, true)

# cdtimer is the sprinting cooldown
func _on_cdtimer_timeout():
	stamina = MAX_STAMINA
	
	isSprintEnabled = true
	
	cdtimer.stop()
	print("cooldowned")

#  mouse stuff
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

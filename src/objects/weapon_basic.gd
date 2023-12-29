extends KinematicBody

onready var bullet_scene = load(str("res://scenes/objects/bullet_types/bullet_", bullet_type, ".tscn"))

# bullet stats
export var bullet_type = "basic"
export var bulletsPerShot = 1
export var fireRate : float = 0.2 #bulletsPerShot per fireRate
export (int, 0 , 360) var inaccuracy = 0
export var bulletSpeed = 50

var rng = RandomNumberGenerator.new()


# states
var shootEnabled = true
var mouseheld : bool

func _ready():
	rng.randomize()
	
	$firerate.wait_time = fireRate

func _input(event):
	# this is for detecting mouseclick so that the weapon initiates firing mode. it doesnt fire when mouse mode isnt "captured"
	if event is InputEventMouseButton: 
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			mouseheld = event.is_pressed()

func _physics_process(_delta):
	
	if mouseheld == true and shootEnabled == true:
		for i in bulletsPerShot: # it runs this code for {bulletsPerShot} times
			var instance = bullet_scene.instance()
			
			get_tree().root.add_child(instance)
			
			# for inaccuracy
			var irotx = rng.randf_range(-inaccuracy, inaccuracy)
			var iroty = rng.randf_range(-inaccuracy, inaccuracy)
			var irotz = rng.randf_range(-inaccuracy, inaccuracy)
			$bulletspawnpoint.rotation_degrees = Vector3(irotx, iroty, irotz)
			
			# sets the transform and velocity of bullet the instance
			instance.global_transform = $bulletspawnpoint.global_transform
			instance.velocity = instance.global_transform.basis.z * -1 * bulletSpeed
			
		$firingSound.pitch_scale = rng.randf_range(1,3) # randomizes pitch for firing sound to avoid redundancy
		$firingSound.play() 
		
		# this starts a timer to cooldown between shots (this is not reloadtimer) 
		shootEnabled = false 
		$firerate.start()
		
		
		print('shots fired')

func _on_firerate_timeout():
	# self explanatory
	shootEnabled = true

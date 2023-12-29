extends Spatial

export var waveEnabled = true
export var enemiesPerBatch : int = 1
export var enemyRate : float = 1 # enemiesPerBatch per enemyRate

var map_size = Vector3(50, 0 ,50)
var enemy = load("res://scenes/characters/enemy.tscn")

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	
	if waveEnabled:
		var enemyspawn = get_parent().get_node("enemyspawn")
		enemyspawn.wait_time = enemyRate
		enemyspawn.start()

func _on_enemyspawn_timeout():
	# it instances enemy {enemiesperbatch} times also their location is random
	for i in enemiesPerBatch:
		var instance = enemy.instance() 
		
		var x = rng.randi_range(0,map_size.x)
		var z = rng.randi_range(0,map_size.z)
		
		instance.translation = Vector3(x,8,z)
		
		$characters.add_child(instance)
		instance.target_given(get_parent().target)

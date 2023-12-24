extends Control

func _ready():
	$playername.text = 'player: ' + get_parent().name

func _process(_delta):
	var stamina = get_parent().stamina
	var MAX_STAMINA = get_parent().MAX_STAMINA
	
	$staminameter.text = str(int(stamina), "/", MAX_STAMINA)

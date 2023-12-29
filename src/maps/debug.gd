extends Spatial

onready var target = $entities/characters/player

func _ready():
	get_tree().call_group("enemies", "target_given", target)

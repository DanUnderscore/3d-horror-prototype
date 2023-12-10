extends RigidBody

export var keyname = "default"
onready var itemname = str(keyname, "key")

func _ready():
	$label.text = itemname

func _on_player_checker_body_entered(body):
	if body.name == "player":
		playerInv.items.append(itemname)
		print(playerInv.items)
		queue_free()

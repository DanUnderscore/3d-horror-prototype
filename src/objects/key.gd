extends RigidBody

export var keyname = "default"
onready var itemname = str(keyname, "key") # sets its name in runtime

func _ready():
	$label.text = itemname # remove later

func _on_player_checker_body_entered(body):
	if body.name == "player": # if body is player
		body.inventory.items.append(itemname) # add key to inventory
		
		print(body.inventory.items)
		
		queue_free() # deletes it

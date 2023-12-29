extends RigidBody

export var key_name = "default"
onready var item_name = str(key_name, "key") # sets its name in runtime

func _ready():
	$label.text = item_name # remove later

func claim(body):
	body.inventory.items.append(item_name) # add key to inventory
	
	print(body.inventory.items)
	
	queue_free() # deletes it

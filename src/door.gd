extends StaticBody

export var doorname = "default"
onready var itemname = str(doorname, "door")

func _on_player_checker_body_entered(body):
	if body.name == "player":
		for i in playerInv.items:
			if i == str(doorname, "key"):
				playerInv.items.erase(str(doorname, "key"))
				queue_free()
				print(playerInv.items)

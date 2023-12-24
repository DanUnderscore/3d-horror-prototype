extends StaticBody

export var doorname = "default"
export var isADoor = true

onready var itemname = str(doorname, "door")
onready var newmaterial = $mesh.get_surface_material(0)

func _ready():
	#$label.text = itemname # remove soon this is kind of annoying
	
	# if not a door then its "open" by default
	if isADoor == false:
		newmaterial = $mesh.material_override
		
		newmaterial.flags_transparent = true # makes it be able to transparent
		newmaterial.albedo_color.a = 0.5 # transparency
		
		$collision.disabled = true

func _on_player_checker_body_entered(body):
	if body.name == "player": # if the body that comes into contact is player
		
		print("contacted with ", itemname)
		
		if str(doorname, 'key') in body.inventory.items:
			body.inventory.items.erase(str(doorname, "key")) # it removes that key from player inventory because you're done using it and to make space for the inventory for new keys
			
			if isADoor:  # if is a door and "unlocked" then it gets "opened" or in this case, deleted
				queue_free()
				
			else: # if not a door and "unlocked" then it gets "closed"
				newmaterial.flags_transparent = false
				newmaterial.albedo_color.a = 1
					
				$collision.disabled = false
					
			print(body.inventory.items) # blah bleh

extends StaticBody

export var doorname = "default"
export var isADoor = true

onready var itemname = str(doorname, "door")
onready var material = $mesh.get_surface_material(0)

onready var newmaterial = material.duplicate()

func _ready():
	$label.text = itemname
	if isADoor == false:
		$mesh.material_override = newmaterial
		newmaterial.flags_transparent = true
		newmaterial.albedo_color.a = 0.5
		
		$collision.disabled = true

func _on_player_checker_body_entered(body):
	if body.name == "player":
		for i in playerInv.items:
			if i == str(doorname, "key"):
				playerInv.items.erase(str(doorname, "key"))
				if isADoor:
					queue_free()
					
				else:
					newmaterial.flags_transparent = false
					newmaterial.albedo_color.a = 1
					
					$collision.disabled = false
					
				print(playerInv.items)

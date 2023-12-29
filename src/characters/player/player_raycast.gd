extends RayCast

onready var player = get_parent().get_parent().get_parent()

# for player's interaction with interactables

func _physics_process(_delta):
	var playerpos = player.translation
	var space_state = get_world().direct_space_state
	var result = space_state.intersect_ray(playerpos, Vector3(0,0,-5))
	

func _unhandled_input(event):
	if is_colliding():
		print('looking at interactable')
		
		if event is InputEventMouseButton and event.button_index == 1 and event.is_pressed():
			print('pressed at interactable')
			
			# if the interactable has this variable
			if 'button_name' in get_collider():
				get_collider().pressed()
			
			elif 'key_name' in get_collider():
				get_collider().claim(player)
			
			elif 'door_name' in get_collider():
				get_collider().unlock(player)

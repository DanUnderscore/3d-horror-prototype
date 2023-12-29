extends Spatial

func _process(_delta):
	$pitchpivot.rotation.x = clamp($pitchpivot.rotation.x, -1, 1)
	
func _unhandled_input(event) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			
			var mouse_sensitivity = Settings.mouse_sensitivity
			
			self.rotate_y(-event.relative.x * mouse_sensitivity)
			$pitchpivot.rotate_x(-event.relative.y * mouse_sensitivity)

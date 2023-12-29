extends StaticBody

export var button_name = 'butt'

var toggle = false

func pressed():
	toggle = not toggle
	
	get_parent().visible = toggle # placeholder

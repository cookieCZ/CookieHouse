extends StaticBody2D

var smer
var rychlost = 100;

# Called when the node enters the scene tree for the first time.
func _ready():
	nastavSmer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func nastavSmer():
	if(position.y<0):
		smer = 'dolů'
		$oNahoru.hide()
		$oDoprava.hide()
	elif(position.y>0):
		smer = 'nahoru'
		$oDolu.hide()
		$oDoprava.hide()
	else:
		smer = 'doprava'
		$oDolu.hide()
		$oNahoru.hide()

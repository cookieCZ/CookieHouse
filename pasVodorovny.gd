extends StaticBody2D

var smer
var rychlost = 100;

# Called when the node enters the scene tree for the first time.
func _ready():
	nastav_smer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func ziskej_smer():
	return smer

func nastav_smer():
	smer = 'doprava'


extends StaticBody2D

signal okenko

var rychlost = 100
var smer
var cena = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pohyb(delta)

func pohyb(delta):
	if(smer=='dolů'):
		position.y+=rychlost*delta
	elif(smer=='nahoru'):
		position.y-=rychlost*delta
	else:
		position.x+=rychlost*delta

func prodejSe():
	#přičti penize
	
	queue_free()

func nastav_cenu(novaCena):
	cena = novaCena

func _on_body_entered(body):
	#jestli pás, vem směr a rychlost
	#jestli okenko, prodej se
	pass # Replace with function body.
extends Area2D

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

func prodej_se():
	#přičti penize
	get_parent().penize += cena
	#odstraní se
	queue_free()

func nastav_cenu(novaCena):
	cena = novaCena
	
func nastav_smer(novySmer):
	smer = novySmer

func _on_body_entered(body):
	#jestli pás, vem směr a rychlost
	if(body.has_method("ziskej_smer")):
		smer = body.ziskej_smer()
	#jestli okenko, prodej se
	if(body.name == "okenko"):
		prodej_se()
	

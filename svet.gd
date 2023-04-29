extends Node2D

var penize = 5

var pecPreload = preload("res://pec.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(6):
		var pec = pecPreload.instantiate()
		pec.muj_init(i)
		var x = 880 - (i / 2) * 350
		var y
		if(i % 2 == 0):
			y = 200
		else:
			y = 2000
		pec.position = Vector2(x, y)
		pec.z_index = 11
		add_child(pec)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = Cisla.zobraz(penize)

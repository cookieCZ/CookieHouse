extends Node2D

var penize

var pecPreload = preload("res://pec.tscn")

var saveFile = "res://save.csv"

# Called when the node enters the scene tree for the first time.
func _ready():
	if FileAccess.file_exists(saveFile):
		#jestli je save
		#podobný, ale načítá z filosu saveFile
		penize = 5
		for i in range(6):
			var pec = pecPreload.instantiate()
			pec.vytvor_pec(i)	#používá nacti_pec()
			var x = 880 - (i / 2) * 350
			var y
			if(i % 2 == 0):
				y = 200
			else:
				y = 2000
			pec.position = Vector2(x, y)
			pec.z_index = 11
			add_child(pec)
	else:
		#jestli není save
		penize = 5
		for i in range(6):
			var pec = pecPreload.instantiate()
			pec.vytvor_pec(i)
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

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		#ulož pece do filosu saveFile
		get_tree().quit()

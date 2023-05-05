extends Node2D

var penize

var pecPreload = preload("res://pec.tscn")
var listPeci = []
var saveDir = "res://"
var saveFile = "save.json"
#file nemá přesně strukturu json, neumí se vymazat

# Called when the node enters the scene tree for the first time.
func _ready():
	if FileAccess.file_exists(saveFile):
		#jestli je save
		precti_data()
	else:
		#jestli není save
		penize = 5
		for i in range(6):
			var pec = pecPreload.instantiate()
			pec.vytvor_pec(i)
			pec.position = souradnice_pece(i)
			pec.z_index = 11
			add_child(pec)
			listPeci.append(pec)

func souradnice_pece(i):
	var x = 880 - (i / 2) * 350	#screen: 1080
	var y	#screen: 2340
	if(i % 2 == 0):
		y = 200
	else:
		y = 2000
	return Vector2(x, y)

func precti_data():
	var filos = FileAccess.open(saveDir + saveFile, FileAccess.READ)
	var json = JSON.new()
	
	var json_string = filos.get_line()
	json.parse(json_string)
	var data = json.get_data()
	penize = data
	
	#while filos.get_position() < filos.get_length():
	for i in range(6):
		json_string = filos.get_line()
		json.parse(json_string)
		data = json.get_data()

		var pec = pecPreload.instantiate()
		pec.position = souradnice_pece(i)
		pec.z_index = 11
		add_child(pec)
		pec.prijmi_data(data, i)
		listPeci.append(pec)

	filos.close()

func uloz_data():
	var dir = DirAccess.open(saveDir)
	dir.remove(saveDir + saveFile)

	var filos = FileAccess.open(saveDir + saveFile, FileAccess.WRITE)

	var data = penize
	var json_string = JSON.stringify(data)
	filos.store_line(json_string)

	for pec in listPeci:
		data = pec.vrat_data()
		json_string = JSON.stringify(data)
		filos.store_line(json_string)

	filos.close()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = Cisla.zobraz(penize)

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		uloz_data()
		get_tree().quit()

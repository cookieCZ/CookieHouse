extends Area2D

var cookie = preload("res://cookie.tscn")
var pasSvisly = preload("res://pasSvisly.tscn")

var spawnZaMinutu
var cenaSusenky
var upgradeRychlosti
var upgradeCeny
var smerSusenky
var koupena
var cenaPece

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func prijmi_data(data, cisloPece):	#data["pos_x"]
	if data["koupena"]:
		nacti_pec(data["cenaSusenky"], data["upgradeRychlosti"], data["upgradeCeny"], data["spawnZaMinutu"])
	else:
		vytvor_pec(cisloPece)

func vytvor_pec(cisloPece):
	true_init(
		pow(1000, cisloPece),
		ceil(pow(1000, cisloPece) / 2.0),
		pow(100, cisloPece) * 20,
		pow(100, cisloPece) * 20,
		12, false)
	$Button.modulate = Color("#FFFFFFFF")
	$Button.text = "+: " + Cisla.zobraz(cenaPece)

func nacti_pec(cena_susenky, upgrade_rychlosti, upgrade_ceny, spawn_za_minutu):
	$Sprite2D.visible = true
	true_init(0, cena_susenky, upgrade_rychlosti, upgrade_ceny, spawn_za_minutu, true)
	vytvor_pas()

func true_init(cena_pece, cena_susenky, upgrade_rychlosti, upgrade_ceny, spawn_za_minutu, je_koupena):
	cenaPece = cena_pece
	cenaSusenky = cena_susenky
	upgradeRychlosti = upgrade_rychlosti
	upgradeCeny = upgrade_ceny
	spawnZaMinutu = spawn_za_minutu
	koupena = je_koupena
	if(position.y<get_viewport_rect().size.y/2):
		smerSusenky = "dolů"
	else:
		smerSusenky = "nahoru"

func vrat_data():
	var data = {
		"cenaSusenky" : cenaSusenky,
		"upgradeRychlosti" : upgradeRychlosti,
		"upgradeCeny" : upgradeCeny,
		"spawnZaMinutu" : spawnZaMinutu,
		"koupena" : koupena
	}
	return data

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func vytvor_pas():
	var pas = pasSvisly.instantiate()
	var y = position.y
	if(smerSusenky == "dolů"):
		y += get_viewport_rect().size.y/4
		pas.scale *= -1
	else:
		y -= get_viewport_rect().size.y/4
	pas.position = Vector2(position.x, y)
	pas.z_index = -1
	get_parent().add_child(pas)

func spawn():
	if koupena:
		var susenka = cookie.instantiate()
		susenka.nastav_cenu(cenaSusenky)
		susenka.nastav_smer(smerSusenky)
		susenka.position = position
		susenka.z_index = 10
		get_parent().add_child(susenka)

func _on_timer_timeout():
	spawn()

func _on_button_pressed():
	if koupena:
		$MarginContainer/VBoxContainer/CenaLabel.text = Cisla.zobraz(cenaSusenky) + "/ks"
		$MarginContainer/VBoxContainer/RychlostLabel.text = Cisla.zobraz(spawnZaMinutu) + "/min"
		$MarginContainer/VBoxContainer/CenaButton.text = Cisla.zobraz(upgradeCeny)
		$MarginContainer/VBoxContainer/RychlostButton.text = Cisla.zobraz(upgradeRychlosti)
		$MarginContainer.visible = true
	else:
		if(get_parent().penize >= cenaPece):
			get_parent().penize -= cenaPece
			koupena = true
			vytvor_pas()
			$Button.modulate = Color("#00000000")
			$Sprite2D.visible = true

func _on_cena_button_pressed():
	if(get_parent().penize >= upgradeCeny):
		get_parent().penize -= upgradeCeny
		upgradeCeny *= 2
		cenaSusenky = ceil(cenaSusenky * 1.8)
	$MarginContainer.visible = false

func _on_rychlost_button_pressed():
	if(get_parent().penize >= upgradeRychlosti):
		get_parent().penize -= upgradeRychlosti
		upgradeRychlosti *= 10
		spawnZaMinutu += 1
		$Timer.wait_time = 1 / (spawnZaMinutu / 60.0)
	$MarginContainer.visible = false

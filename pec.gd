extends Area2D

var cookie = preload("res://cookie.tscn")
var pasSvisly = preload("res://pasSvisly.tscn")

var spawnZaMinutu = 12
var cenaSusenky
var upgradeRychlosti
var upgradeCeny
var smerSusenky
var koupena = false
var cenaPece

# Called when the node enters the scene tree for the first time.
func _ready():
	nastav_smer_spawnu()
	$Button.modulate = Color("#FFFFFFFF")
	$Button.text = "+: " + str(cenaPece)

func muj_init(cisloPece):
	cenaPece = pow(1000, cisloPece)
	cenaSusenky = pow(100, cisloPece) * 5
	upgradeRychlosti = pow(100, cisloPece) * 20
	upgradeCeny = pow(100, cisloPece) * 20

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func vytvor_pas():
	var pas = pasSvisly.instantiate()
	var y = position.y
	if(smerSusenky == "dolů"):
		y += get_viewport_rect().size.y/4
	else:
		y -= get_viewport_rect().size.y/4
	pas.position = Vector2(position.x, y)
	pas.z_index = -1
	get_parent().add_child(pas)

func spawn():
	if(koupena):
		var susenka = cookie.instantiate()
		susenka.nastav_cenu(cenaSusenky)
		susenka.nastav_smer(smerSusenky)
		susenka.position = position
		susenka.z_index = 10
		get_parent().add_child(susenka)

func _on_timer_timeout():
	spawn()

func nastav_smer_spawnu():
	if(position.y<get_viewport_rect().size.y/2):
		smerSusenky = "dolů"
	else:
		smerSusenky = "nahoru"


func _on_button_pressed():
	if(koupena):
		$MarginContainer/VBoxContainer/CenaLabel.text = str(cenaSusenky) + "/ks"
		$MarginContainer/VBoxContainer/RychlostLabel.text = str(spawnZaMinutu) + "/min"
		$MarginContainer/VBoxContainer/CenaButton.text = str(upgradeCeny)
		$MarginContainer/VBoxContainer/RychlostButton.text = str(upgradeRychlosti)
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
		cenaSusenky = ceil(cenaSusenky * 1.1)
	$MarginContainer.visible = false


func _on_rychlost_button_pressed():
	if(get_parent().penize >= upgradeRychlosti):
		get_parent().penize -= upgradeRychlosti
		upgradeRychlosti *= 10
		spawnZaMinutu += 1
		$Timer.wait_time = 1 / (spawnZaMinutu / 60.0)
	$MarginContainer.visible = false

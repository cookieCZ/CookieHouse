extends Area2D

var cookie = preload("res://cookie.tscn")

var spawnZaMinutu = 12
var cenaSusenky = 5
var upgradeRychlosti = 20
var upgradeCeny = 20
var smerSusenky

# Called when the node enters the scene tree for the first time.
func _ready():
	nastav_smer_spawnu()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn():
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
	$MarginContainer/VBoxContainer/CenaLabel.text = str(cenaSusenky) + "/ks"
	$MarginContainer/VBoxContainer/RychlostLabel.text = str(spawnZaMinutu) + "/min"
	$MarginContainer/VBoxContainer/CenaButton.text = str(upgradeCeny)
	$MarginContainer/VBoxContainer/RychlostButton.text = str(upgradeRychlosti)
	$MarginContainer.visible = true


func _on_cena_button_pressed():
	if(get_parent().penize >= upgradeCeny):
		get_parent().penize -= upgradeCeny
		upgradeCeny += 10
		cenaSusenky += 1
	$MarginContainer.visible = false


func _on_rychlost_button_pressed():
	if(get_parent().penize >= upgradeRychlosti):
		get_parent().penize -= upgradeRychlosti
		upgradeRychlosti += 10
		spawnZaMinutu += 1
		$Timer.wait_time = 1 / (spawnZaMinutu / 60.0)
	$MarginContainer.visible = false

extends Sprite2D

var cookie = preload("res://cookie.tscn")

var spawnZaMinutu = 12
var cenaSusenky = 5
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
	get_parent().add_child(susenka)

func _on_timer_timeout():
	spawn()

func nastav_smer_spawnu():
	if(position.y<get_viewport_rect().size.y/2):
		smerSusenky = "dolů"
	else:
		smerSusenky = "nahoru"

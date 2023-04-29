class_name Cisla
extends RefCounted

#const abeceda = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
const koncovky = {"0":"", "1":"k", "2":"m", "3":"b", "4":"t", "5":"aa", "6":"ab", "7":"ac", "8":"ad", "9":"ae", "10":"af", "11":"ag", "12":"ah", "13":"ai", "14":"aj", "15":"ak", "16":"al", "17":"am", "18":"an", "19":"ao", "20":"ap", "21":"aq", "22":"ar", "23":"as", "24":"at", "25":"au", "26":"av", "27":"aw", "28":"ax", "29":"ay", "30":"az", "31":"ba", "32":"bb", "33":"bc", "34":"bd", "35":"be", "36":"bf", "37":"bg", "38":"bh", "39":"bi", "40":"bj", "41":"bk", "42":"bl", "43":"bm", "44":"bn", "45":"bo", "46":"bp", "47":"bq", "48":"br", "49":"bs", "50":"bt", "51":"bu", "52":"bv", "53":"bw", "54":"bx", "55":"by", "56":"bz", "57":"ca"}

static func zobraz(cislo):
	var pocetTrojicNul = 0
	while(cislo >= 1000):
		cislo = floor(cislo / 1000)
		pocetTrojicNul += 1
	var koncovka = koncovky[str(pocetTrojicNul)]
	return str(cislo) + koncovka

@tool
extends Node2D

const POINT_COUNT = 64
const LAYERS = [
	{"radius": 120.0, "noise_scale": 0.5, "amplitude": 60.0, "color": Color("7ecfdf"), "speed": 0.3},
	{"radius": 95.0,  "noise_scale": 0.6, "amplitude": 50.0, "color": Color("5a9dbf"), "speed": 0.4},
	{"radius": 72.0,  "noise_scale": 0.7, "amplitude": 40.0, "color": Color("3d6e99"), "speed": 0.5},
	{"radius": 50.0,  "noise_scale": 0.8, "amplitude": 30.0, "color": Color("2a4a6e"), "speed": 0.6},
	{"radius": 30.0,  "noise_scale": 0.9, "amplitude": 18.0, "color": Color("1a2e4a"), "speed": 0.7},
]

var noise: FastNoiseLite
var time := 0.0
var polygons := []

func _ready():
	noise = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX_SMOOTH
	noise.seed = randi()
	for i in LAYERS.size():
		polygons.append(PackedVector2Array())

func _process(delta):
	time += delta
	for i in LAYERS.size():
		var layer = LAYERS[i]
		var points = PackedVector2Array()
		for j in POINT_COUNT:
			var angle = (float(j) / POINT_COUNT) * TAU
			var nx = cos(angle) * layer["noise_scale"]
			var ny = sin(angle) * layer["noise_scale"]
			var offset = noise.get_noise_3d(nx, ny, time * layer["speed"]) * layer["amplitude"]
			var r = layer["radius"] + offset
			points.append(Vector2(cos(angle) * r, sin(angle) * r))
		polygons[i] = points
	queue_redraw()

func _draw():
	for i in LAYERS.size():
		if polygons[i].size() > 0:
			draw_colored_polygon(polygons[i], LAYERS[i]["color"])
			

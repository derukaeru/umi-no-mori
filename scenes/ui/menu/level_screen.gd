extends Control

@onready var levels = $levels
@onready var lines = $level_lines

var level_stars := []
var level_lines := []

func _ready():
	for entry in levels.get_children():
		if entry is LevelStar:
			level_stars.append(entry)
	
	for i in len(level_stars) - 1:
		var line = Line2D.new()
		line.width = 4.0
		line.default_color = Color("7c8497")
		
		level_lines.append(line)
		lines.add_child(line)

func _process(_delta):
	for i in range(level_lines.size()):
		level_lines[i].points = [level_stars[i].position, level_stars[i + 1].position]
		

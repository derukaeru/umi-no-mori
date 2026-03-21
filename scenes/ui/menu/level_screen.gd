extends Control

@onready var levels = $levels
@onready var lines = $level_lines
@onready var pointer = $pointer

var level_stars := []
var level_lines := []

var current_level := 0
var max_level

func _ready():
	for entry in levels.get_children():
		if entry is LevelStar:
			level_stars.append(entry)
	
	for i in len(level_stars) - 1:
		var line = Line2D.new()
		line.width = 3.0
		line.default_color = Color("7c8497")
		
		level_lines.append(line)
		lines.add_child(line)
	
	max_level = len(level_stars)
	pointer.position = level_stars[current_level].position
	pointer.position.y -= 18
	pointer.position.x -= 5.5

func _process(_delta):
	for i in range(level_lines.size()):
		level_lines[i].points = [level_stars[i].position, level_stars[i + 1].position]
		
	if Input.is_action_just_pressed("move_left"):
		current_level = max(0, current_level - 1)
		
		pointer.position = level_stars[current_level].position
		pointer.position.y -= 18
		pointer.position.x -= 5.5
		
	if Input.is_action_just_pressed("move_right"):
		current_level = min(max_level - 1, current_level + 1)
		
		pointer.position = level_stars[current_level].position
		pointer.position.y -= 18
		pointer.position.x -= 5.5

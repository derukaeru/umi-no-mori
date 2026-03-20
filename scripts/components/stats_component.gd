class_name StatsComponent extends Node2D

@export var attack: int = 10
@export var defense: int = 0
@export var speed: float = 100.0
@export var knockback_resistance: float = 0.0

func calculate_damage(raw_damage: int) -> int:
	return max(1, raw_damage - defense)

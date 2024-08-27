extends CharacterBody2D

@export var use_raycast: bool
@onready var player_detector: Area2D = $"PlayerDetector"


func _ready():
	if use_raycast:
		player_detector.enabled = false

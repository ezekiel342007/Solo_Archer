extends Node2D
@onready var player: CharacterBody2D = %Player
@onready var game_screen: CanvasLayer = %GameScreen

var start_spawn: bool = false
var phase1: bool = false
var phase2: bool = false
var phase3: bool = false
var phase4: bool = false

extends Node

var current_level: Level
var completed: bool = false

class Level:
	static var path: String
	static var completed: bool

	func _init(init_path: String, init_completed: bool):
		self.path = init_path
		self.completed = init_completed

extends ProgressBar


func _ready() -> void:
	max_value = PlayerManagement.health


func _physics_process(_delta: float) -> void:
	value = PlayerManagement.health

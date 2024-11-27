extends CanvasLayer

@onready var margin_container: MarginContainer = %MarginContainer
@onready var enemy_counter_container: MarginContainer = $EnemyCounterContainer
 	

func _ready():
	unique_name_in_owner = true
 

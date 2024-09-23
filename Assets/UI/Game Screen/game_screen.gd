extends CanvasLayer

@onready var narration_label: Label = %NarrationLabel
@onready var key_directions_label: Label = %KeyDirectionsLabel
@onready var narration_banner = $"MarginContainer/NarrationBanner"
@onready var margin_container: MarginContainer = %MarginContainer
 	
var narration_text: String
var key_direction: String
var narrating: bool = false


func _ready():
	key_directions_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	narration_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER


func _physics_process(_delta) -> void:
	narration_label.text = narration_text
	if key_direction != "":
		key_directions_label.text = "Press " + key_direction
	else:
		key_directions_label.text = ""

	if !narrating:
		narration_banner.visible = false
	else:
		narration_banner.visible = true

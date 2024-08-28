extends CanvasLayer

var narration_text: String
var key_direction: String

@onready var narration_banner = $"MarginContainer/NarrationBanner"
@onready var narration_label: Label = %NarrationLabel
@onready var key_directions_label: Label = %KeyDirectionsLabel

var narrating: bool = false


func _ready():
	key_directions_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	narration_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER


func _physics_process(_delta) -> void:
	narration_label.text = narration_text
	key_directions_label.text = "Press " + key_direction

	if !narrating:
		narration_banner.visible = false

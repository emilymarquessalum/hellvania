extends Node2D

@export var dialogue_json: JSON

# Called when the node enters the scene tree for the first time.
func _ready():
	($Control/CanvasLayer/dialogue_box).start_dialogue(
		dialogue_json,

	)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

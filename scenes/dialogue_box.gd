extends Panel


#var dialogue = []
#var dialogue_index = 0
var state = {
	"character": 'you'
}

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func clear_dialogue_box():
	$VBoxContainer/Label2.text = ""
	
	#dialogue_index = 0
	
func add_text(text: String):
	$VBoxContainer/Label3.text = state["character"]
	$VBoxContainer/Label2.text = text

#https://www.youtube.com/watch?v=WVflfiKjXgk
func add_choice(choice_text: String):
	pass	

 
func _on_ez_dialogue_dialogue_generated(response: DialogueResponse):
	clear_dialogue_box()
	
	visible = true
	#dialogue = response.text.split("===")
	#add_text(dialogue[0])
	add_text(response.text)

var end_of_dialogue = false
func _on_gui_input(ev):
	if ev is InputEventMouseButton and ev.button_index == MOUSE_BUTTON_LEFT and ev.pressed == false:
		#dialogue_index += 1
		#add_text(dialogue[dialogue_index])
		if end_of_dialogue:
			visible = false
		else :
			($EzDialogue as EzDialogue).next()

func start_dialogue(dialogue_json):
	end_of_dialogue = false
	($EzDialogue as EzDialogue).start_dialogue(
		dialogue_json,
		state
	)


func _on_ez_dialogue_custom_signal_received(value):
	var params = value.split(",")
	print("custom signal received")
	print(value)
	if(params[0] == "set"):
		state[params[1]] = params[2]


func _on_ez_dialogue_end_of_dialogue_reached():
	end_of_dialogue = true

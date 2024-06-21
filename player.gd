extends CharacterBody2D
 

# Variables for movement
@export var move_speed : int = 200 
var acceleration = 50
var friction = 70
@export var jump_height : int = 200 
@export var jump_time_to_peak : float = 1
@export var jump_time_to_descent : float = 1

@onready var jump_velocity : float = (-2.0 * jump_height)/jump_time_to_peak
@onready var jump_gravity : float = (2.0 * jump_height)/(jump_time_to_peak *jump_time_to_peak)
@onready var fall_gravity : float = (2.0 * jump_height)/(jump_time_to_descent *jump_time_to_descent)
 

func get_gravity() -> float:
	
	return (jump_gravity if velocity.y < 0 else fall_gravity)

# Function to handle movement
func _physics_process(delta):
	# Reset velocity each frame
	#velocity = Vector2()
	
	# Check for input and set velocity accordingly
	move_horizontally()

	velocity.y += get_gravity() * delta
	if Input.is_action_just_pressed("ui_select") and is_on_floor():
		velocity.y = jump_velocity
		
	# Move the character
	move_and_slide()
	#print(velocity.y)


func accelerate(direction):
	direction.y = velocity.y / move_speed
	velocity = velocity.move_toward( move_speed * direction, acceleration)

func apply_friction():
	velocity = velocity.move_toward(Vector2(0, velocity.y), friction)
	
 
func move_horizontally():
	if Input.is_action_pressed("ui_right"):
		accelerate(Vector2(1,0) )
	elif Input.is_action_pressed("ui_left"):
		accelerate(Vector2(-1,0))
	else:
		apply_friction()

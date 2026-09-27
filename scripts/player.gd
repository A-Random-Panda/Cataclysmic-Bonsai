extends CharacterBody2D
@export var sun_scene:PackedScene
@export var water_scene:PackedScene
@export var music_scene:PackedScene
@onready var tile_map_layer: TileMapLayer = get_tree().current_scene.get_node("TileMapLayer")
var speed = 150.0
var grabbing:bool
var held_thing
var in_game = false
func _physics_process(delta: float) -> void:
	var tile = get_tile()
	if tile == "road":
		speed = 150
		
	elif tile == "water":
		if not in_game and grabbing and held_thing.tasks.curr_task == "Water":
			var water_minigame = water_scene.instantiate()
			water_minigame.position = Vector2(-1152/2,-648/2)
			add_child(water_minigame)
			in_game = true
	elif tile == "dance":
		if not in_game and grabbing and held_thing.tasks.curr_task == "Music":
			var music_minigame = music_scene.instantiate()
			music_minigame.position = Vector2(-1152/2,-648/2)
			add_child(music_minigame)
			in_game = true
	elif tile  == "grass":
		speed = 75
	elif tile == "rock":
		if not in_game and grabbing and held_thing.tasks.curr_task == "Sun":
			var sun_minigame = sun_scene.instantiate()
			add_child(sun_minigame)
			in_game = true
	else:
		pass
		
		
		
		
	if Input.is_action_just_pressed("drop"):
		if grabbing:
			grabbing = false
			held_thing.position.y -= 10
			held_thing.grabbed = false
	if abs(position.x) > 2500:
		if position.x > 0:
			position.x = -2400
		else:
			position.x = 2400
	if abs(position.y) > 2500:
		if position.y > 0:
			position.y = -2400
		else:
			position.y = 2400
		
	movement()
	move_and_slide()
	
func movement() -> void:
		# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("left","right","up","down")
	velocity = direction * speed
func play_animation(dir: Vector2) -> void:
	if dir.x > 0:
		pass
	elif dir.x < 0:
		pass

func get_tile():
	var player_pos = tile_map_layer.local_to_map(
		tile_map_layer.to_local(global_position)
	)
	var data = tile_map_layer.get_cell_tile_data(player_pos)
	if data:
		return data.get_custom_data("type")
	else:
		return "grass"


func _on_grab_area_body_entered(body: Node2D) -> void:
	
	if not grabbing:
		for child in get_tree().current_scene.find_children("BonsaiPot*"):
			if body == child.get_child(0):
				if not child.dead:
					child.emit_signal("is_grabbed",position)
					held_thing = child
					grabbing = true

extends Node2D

@onready var tile_map = $TileMap
@onready var player = $Player
@onready var camera_2d = $Camera2D

const FLOOR_LAYER = 0
const WALL_LAYER = 1
const TARGET_LAYER = 2
const BOX_LAYER = 3

const SOURCE_ID = 0

const LAYER_KEY_FLOOR = "Floor"
const LAYER_KEY_WALLS = "Walls"
const LAYER_KEY_TARGETS = "Targets"
const LAYER_KEY_TARGET_BOXES = "TargetBoxes"
const LAYER_KEY_BOXES = "Boxes"

const LAYER_MAP = {
	LAYER_KEY_FLOOR: FLOOR_LAYER,
	LAYER_KEY_WALLS: WALL_LAYER,
	LAYER_KEY_TARGETS: TARGET_LAYER,
	LAYER_KEY_TARGET_BOXES: BOX_LAYER,
	LAYER_KEY_BOXES: BOX_LAYER
}

func _ready():
	setup_level()


func set_player_position(tile_coord: Vector2i):
	var new_pos: Vector2 = Vector2(
		tile_coord.x * GameData.TILE_SIZE,
		tile_coord.y * GameData.TILE_SIZE
	) + tile_map.global_position
	player.global_position = new_pos


func get_atlas_coord_for_layer_name(layer_name: String) -> Vector2i:
	match layer_name:
		LAYER_KEY_FLOOR:
			return Vector2i(randi_range(3, 8), 0)
		LAYER_KEY_WALLS:
			return Vector2i(2, 0)
		LAYER_KEY_TARGETS:
			return Vector2i(9, 0)
		LAYER_KEY_TARGET_BOXES:
			return Vector2i(0, 0)
		LAYER_KEY_BOXES:
			return Vector2i(1, 0)
	return Vector2i.ZERO


func add_tile(tile_coord: Dictionary, layer_name: String) -> void:
	var layer_number = LAYER_MAP[layer_name]
	var coord_vec: Vector2i = Vector2i(tile_coord.x, tile_coord.y)
	var atlas_vec = get_atlas_coord_for_layer_name(layer_name)
	
	tile_map.set_cell(layer_number, coord_vec, SOURCE_ID, atlas_vec)


func add_layer_tiles(layer_tiles, layer_name: String) -> void:
	for tile_coord in layer_tiles:
		add_tile(tile_coord.coord, layer_name)


func setup_level() -> void:
	tile_map.clear()
	var level_data = GameData.get_data_for_level("9")
	var level_tiles = level_data.tiles
	var player_start = level_data.player_start
	
	for layer_name in LAYER_MAP.keys():
		add_layer_tiles(level_tiles[layer_name], layer_name)
		
	set_player_position(Vector2i(player_start.x, player_start.y))
	move_camera()


func move_camera() -> void:
	var tile_map_rect = tile_map.get_used_rect()
	
	var tile_map_start_x = tile_map_rect.position.x * GameData.TILE_SIZE
	var tile_map_end_x = tile_map_rect.size.x * GameData.TILE_SIZE + tile_map_start_x
	
	var tile_map_start_y = tile_map_rect.position.y * GameData.TILE_SIZE
	var tile_map_end_y = tile_map_rect.size.y * GameData.TILE_SIZE + tile_map_start_y
	
	var mid_x = tile_map_start_x + (tile_map_end_x - tile_map_start_x) / 2
	var mid_y = tile_map_start_y + (tile_map_end_y - tile_map_start_y) / 2
	
	camera_2d.position = Vector2(mid_x, mid_y)










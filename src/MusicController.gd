class_name MusicController extends Node

@onready var music_player = $AudioStreamPlayer as AudioStreamPlayer

@export var music: Array[AudioStream] = []
@export var game_over: AudioStream

var current_music: AudioStream

func play_music():
	if not current_music:
		next_music()
	_play_stream(current_music)

func play_game_over():
	_play_stream(game_over)

func _play_stream(stream: AudioStream):
	music_player.stop()
	if stream :
		music_player.stream = stream
		music_player.stream_paused = false
		music_player.play()

func next_music():
	current_music = music.pick_random()
	
func pause_music():
	music_player.stream_paused = true

func unpause_music():
	music_player.stream_paused = false


extends Control


func _ready() -> void:
	$CenterContainer/VBoxContainer/RetryButton.grab_focus()


func _on_retry_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level1.tscn")


func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

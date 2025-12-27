class_name InputBuffer
extends Node

# Emitted whenever the text in the buffer changes (typing, backspace, submit)
signal input_changed(new_text: String)

# Emitted when the buffer is cleared explicitly (A cast attempt, press was spaced)
signal word_submitted(word: String)

var current_text: String = ""
var max_length: int = 50 # Prevent infinite strings

func _input(event: InputEvent) -> void:
	# TODO: Should this be here or in the parent? I.e. should this be pure logic or IO as well
	if event is InputEventKey:
		if event.pressed and _handle_character(event.keycode, event.unicode):
			# TODO: Do I want this?
			get_viewport().set_input_as_handled() # Mark input as handled to prevent further processing

func _handle_character(keycode: int, unicode: int):
	# Handle specific key presses
	if keycode == KEY_BACKSPACE:
		if current_text.length() > 0:
			current_text = current_text.left(current_text.length() - 1)
			input_changed.emit(current_text)
	elif keycode == KEY_SPACE:
		word_submitted.emit(current_text)
		current_text = ""
		input_changed.emit(current_text)
	elif unicode >= 33: # Standard printable characters start at 33 (!), Space is 32
		if current_text.length() < max_length:
			current_text += char(unicode)
			input_changed.emit(current_text)
	else:
		return false
	
	return true
		

func get_text() -> String:
	return current_text

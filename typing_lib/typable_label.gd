class_name TypableLabel
extends RichTextLabel

@export var target_text: String = "":
	set(value):
		target_text = value
		update_text_display(last_input)

@export var active_color: Color = Color.RED
@export var default_color: Color = Color.WHITE

var last_input: String = ""

func _ready() -> void:
	# Ensure RichTextLabel is set to process BBCode
	set_use_bbcode(true)
	update_text_display("") # Initial display
	InputBufferG.input_changed.connect(self.on_input_changed)

func on_input_changed(current_input: String) -> void:
	last_input = current_input
	update_text_display(current_input)

# static
func _get_colored_text(label_text: String, typed_text: String):
	var active_color_code = active_color.to_html(false).to_upper()
	var default_color_code = default_color.to_html(false).to_upper()
	if typed_text.is_empty() or not label_text.begins_with(typed_text):
		return "[color=#%s]%s[/color]" % [default_color.to_html(false).to_upper(), target_text]
	var matched_part = label_text.substr(0, typed_text.length())
	var remaining_part = label_text.substr(typed_text.length())
	return "[color=#%s]%s[/color][color=#%s]%s[/color]" % [
		active_color_code, matched_part,
		default_color_code, remaining_part
	]

func update_text_display(current_input: String) -> void:
	if target_text.is_empty():
		self.text = ""
		return

	self.text = _get_colored_text(target_text, current_input)

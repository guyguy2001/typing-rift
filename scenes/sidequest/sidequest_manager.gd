extends Node

var _sidequest: Sidequest = null

signal focus_changed(sidequest: Sidequest)

func focus(sidequest: Sidequest) -> void:
	if self._sidequest:
		InputBufferG.word_submitted.disconnect(self._sidequest.on_word_entered)
	self._sidequest = sidequest
	InputBufferG.word_submitted.connect(self._sidequest.on_word_entered)

	focus_changed.emit(self._sidequest)

func unfocus() -> void:
	if self._sidequest:
		InputBufferG.word_submitted.disconnect(self._sidequest.on_word_entered)
	self._sidequest = null

	focus_changed.emit(null)
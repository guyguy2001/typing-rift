extends "res://addons/gut/test.gd"

var WordsManager = preload("res://scenes/singletons/words_manager.gd")
var manager

func before_each():
	manager = WordsManager.new()
	manager._ready()
	seed(1) # deterministic random sequence for reproducible expectations

func test_ready_populates_free_words():
	assert_eq(manager._free_words.size(), manager.word_pool.size(), "free words should match pool size")
	assert_eq(manager._used_words.size(), 0, "used words should start empty")

func test_get_word_moves_word_to_used():
	var word = manager.get_word()
	assert_true(manager._used_words.has(word), "word should move to used")
	assert_false(manager._free_words.has(word), "word should be removed from free")
	assert_eq(manager._used_words.size(), 1)
	assert_eq(manager._free_words.size(), manager.word_pool.size() - 1)

func test_get_word_returns_all_unique_words():
	var seen := {}
	for i in range(manager.word_pool.size()):
		var w = manager.get_word()
		assert_false(seen.has(w), str("word already seen: ", w))
		seen[w] = true

	assert_eq(manager._free_words.size(), 0, "all free words should be consumed")
	assert_eq(manager._used_words.size(), manager.word_pool.size(), "all words should be marked used")

	var sorted_seen: Array = seen.keys()
	sorted_seen.sort()
	var sorted_pool: Array = manager.word_pool.duplicate()
	sorted_pool.sort()
	assert_eq(sorted_seen, sorted_pool, "all pool words should be returned")

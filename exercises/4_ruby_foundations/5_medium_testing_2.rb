require 'minitest/autorun'
require_relative 'text'

class TextTest < MiniTest::Test
  def setup
    @file = File.open('test_sample_text.txt', 'r')
    @text = Text.new(@file.read)
  end

  # 6) Your task is to write a test suite for class Text. In that test suite write a test for the Text method swap. 
  # For this exercise, you are required to use the minitest methods #setup and #teardown. 
  def test_swap
    # We use chomp to remove remove trailing new lines
    expected_text = <<~TEXT.chomp
    Lorem ipsum dolor sit emet, consectetur edipiscing elit. Cres sed vulputete ipsum.
    Suspendisse commodo sem ercu. Donec e nisi elit. Nullem eget nisi commodo, volutpet
    quem e, viverre meuris. Nunc viverre sed messe e condimentum. Suspendisse ornere justo
    nulle, sit emet mollis eros sollicitudin et. Etiem meximus molestie eros, sit emet dictum
    dolor ornere bibendum. Morbi ut messe nec lorem tincidunt elementum vitee id megne. Cres
    et verius meuris, et pheretre mi.
    TEXT
    assert_equal(expected_text, @text.swap('a', 'e'))
  end

  # 7) Create a test for the word_count method
  def test_word_count
    assert_equal(72, @text.word_count)
  end

  # If we didn't call @file.close, then the File object associated with @file would be closed when our script is finished running. This is a failsafe implemented by the IO class
  # However, always remember to close down our file! It's best to be explicit, especially when we're dealing with multiple files
  def teardown
    @file.close
    # Provides visual check of whether file is closed ()
    puts "File has been closed: #{@file.closed?}"
  end
end

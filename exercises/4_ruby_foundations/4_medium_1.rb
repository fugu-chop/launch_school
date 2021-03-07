# 1) Finish the code so that it meets the requirements. Anything that is said is retrieved by this listening device via a block. If nothing is said, then no block will be passed in. The listening device can also output the most recent recording using a Device#play method.
=begin
listener = Device.new
listener.listen { "Hello World!" }
listener.listen
listener.play # Outputs "Hello World!"
=end
class Device
  def initialize
    @recordings = []
  end

  def record(recording)
    @recordings << recording
  end

  def play
    puts @recordings.last
  end

  def listen
    # We need this because the test case indicates we're able to call the method without a LocalJumpError being raised if no block is provided
    return if !block_given?
    # Capture the return value of the block (remember that blocks return values)
    recording = yield
    record(recording)
  end
end

# 2) Fill out the rest of the Ruby code below so it prints output like that shown in "Sample Output." You should read the text from a simple text file that you provide.
=begin
# Based on the sample text
3 paragraphs
15 lines
126 words
=end
class TextAnalyzer
  # This method is generic, we would use 
  def process
    return if !block_given?
    file = File.open('sample_text.txt')
    # This leaves blank lines as an empty string element in our array, which is useful for counting total lines
    yield(file.readlines.map(&:chomp))
    file.close
  end
end

analyzer = TextAnalyzer.new
analyzer.process { |file| puts "#{file.count("") + 1} paragraphs" }
analyzer.process { |file| puts "#{file.size} lines" }
analyzer.process { |file| puts "#{file.reduce(0) { |accum, line| accum += line.split.size } } words" }

# Suggested solution
class TextAnalyzer
  def process
    file = File.open('sample_text.txt', 'r')
    # We don't strip out new lines for this implementation
    yield(file.read)
    file.close
  end
end

analyzer.process { |text| puts "#{text.split("\n\n").count} paragraphs" }
analyzer.process { |text| puts "#{text.split("\n").count} lines" }
analyzer.process { |text| puts "#{text.split(' ').count} words" }

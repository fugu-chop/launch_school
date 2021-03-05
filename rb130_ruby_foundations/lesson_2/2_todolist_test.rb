require 'minitest/autorun'
require_relative '../lesson_1/3_todolist'

class TodoListTest < MiniTest::Test
  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    # Check the return value of the function
    assert_equal(@todo1, @list.shift)
    # Also check the array is now different
    assert_equal(2, @list.size)
  end

  def test_pop
    assert_equal(@todo3, @list.pop)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    assert_equal(false, @list.done?)
  end

  def test_raise_nontodo_add
    assert_raises(TypeError) do
      @list << 'hello'
    end
    assert_raises(TypeError) do
      @list.add(9)
    end
    assert_raises(TypeError) do
      @list << Hash.new
    end
    assert_raises(TypeError) do
      @list << Array.new
    end
  end
end

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
# Remember to run this from the lesson_1 folder!
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
    assert_raises(TypeError) { @list << 'hello' }
    assert_raises(TypeError) { @list.add(9) }
    assert_raises(TypeError) { @list << Hash.new }
    assert_raises(TypeError) { @list.add(Array.new) }
  end

  def test_add
    todo4 = Todo.new('Eat some eggs')
    @todos << todo4
    assert_equal(@todos, @list.add(todo4))
  end

  def test_double_shovel
    todo4 = Todo.new('Drink some water')
    assert_equal([@todo1, @todo2, @todo3, todo4], @list << todo4)
  end

  def test_item_at
    assert_raises(IndexError) { @list.item_at(99) }
    assert_equal(@todo1, @list.item_at(0))
    assert_equal(@todo2, @list.item_at(1))
  end

  def test_mark_done_at
    assert_raises(IndexError) { @list.mark_done_at(99) }
    @list.mark_done_at(1)
    # Cumulative tests need to take account changes in state
    assert_equal(false, @todo1.done?)
    assert_equal(true, @todo2.done?)
  end

  def test_mark_undone_at
    assert_raises(IndexError) { @list.mark_undone_at(99) }
    assert_equal(@todo1.done?, @list.mark_undone_at(0))
    
    @todo1.done!
    assert_equal(false, @list.mark_undone_at(1))
  end

  def test_done!
    @list.done!
    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo3.done?)
  end

  def test_remove_at
    assert_raises(IndexError) { @list.remove_at(99) }
    assert_equal(@todo1, @list.remove_at(0))
    assert_equal(2, @list.size)
  end

  def test_to_s
    # As of Ruby 2.3, we can normally use <<~OUTPUT to remove preceeding spaces
    # Here, this doesn't work (some trailing space after the last item)
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s_done
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [X] Go to gym
    OUTPUT

    @list.mark_done_at(2)
    assert_equal(output, @list.to_s)
  end

  def test_to_s_all_done
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT

    @list.mark_all_done
    assert_equal(output, @list.to_s)
  end

  def test_each
    test_arr = []
    @list.each { |todo| test_arr << todo }

    assert_equal(test_arr, @todos)
  end

  def test_each_orig_object
    # We don't actually want to perform any action when we iterate, so we have a nil as a placeholder.
    assert_equal(@list, @list.each { |todo| nil })
  end

  def test_select
    @list.mark_done_at(0)
    # Remember that select is supposed to return an array
    assert_equal([@todo1], @list.select { |todo| todo.done? }.to_a)
  end

  def test_find_by_title
    assert_nil(@list.find_by_title("hello"))
    assert_equal(@todo1, @list.find_by_title("Buy milk"))
  end

  def test_all_done
    @todo1.done!
    @todo2.done!
    assert_equal([@todo1, @todo2], @list.all_done.to_a)
  end

  def test_all_not_done
    @todo3.done!
    assert_equal([@todo1, @todo2], @list.all_not_done.to_a)
  end

  def test_mark_done
    @todo1.done!
    assert_equal(@todo1.done?, @list.mark_done("Buy milk"))
    assert_nil(@list.mark_done("Zoo course"))
  end

  def test_mark_all_undone
    assert_equal(@todos, @list.mark_all_undone.to_a)
  end
end

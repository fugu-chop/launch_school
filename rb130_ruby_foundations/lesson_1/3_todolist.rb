class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(todo)
    raise TypeError, "Can only add Todo objects" unless todo.instance_of?(Todo)
    todos.push(todo)
    todos
  end

  alias_method :<<, :add

  def size
    todos.size
  end

  def first
    todos.first.to_s
  end

  def last
    todos.last.to_s
  end

  def to_a
    # Using collect to return an array instead of the calling object like each does
    todos.collect { |todo| todo.to_s }
  end

  def done?
    todos.all? { |todo| todo.done? }
  end

  def item_at(position)
    # Using fetch to ensure indices are not out of bounds
    todos.fetch(position).to_s
  end

  def mark_done_at(position)
    # Not using item_at because we applied to_s, which changes the return value
    todos.fetch(position).done!
  end

  def mark_undone_at(position)
    todos.fetch(position).undone!
  end

  def done!
    todos.each { |todo| todo.done! }
  end

  def shift
    todos.shift
  end

  def pop
    todos.pop
  end

  def remove_at(position)
    todos.delete_at(position)
  end

  def to_s
    puts "---- #{title} ----"
    todos.each { |todo| puts todo }
  end

  # In most cases, we prefer to work with the TodoList object directly and invoke method calls on `list`. We would rather not access an internal state of the TodoList, which in this case is @todos. 
  # This is the idea behind encapsulation: we want to hide implementation details from users of the TodoList class, and not encourage users of this class to reach into its internal state. 
  # Instead, we want to encourage users of the class to use the interfaces (ie, public methods) we created for them.
  def each
    # Call on the collaborator object
    for i in todos
      yield(i)
    end
    # Remember that Array#each returns the object on which it was called
    self
  end

  def select
    arr = []
    # We use our custom implementation of each here, which we have equipped to take a block
    each do |todo|
      arr << todo if yield(todo)
    end
    arr
  end

  private 

  attr_reader :todos
end

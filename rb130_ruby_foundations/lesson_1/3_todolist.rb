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

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def done?
    @todos.all? { |todo| todo.done? }
  end

  def <<(todo)
    raise TypeError, 'can only add Todo objects' unless todo.instance_of?(Todo)

    @todos << todo
  end
  # This allows us to give the same method a different name
  alias_method :add, :<<

  def item_at(idx)
    @todos.fetch(idx)
  end

  def mark_done_at(idx)
    item_at(idx).done!
  end

  def mark_undone_at(idx)
    item_at(idx).undone!
  end

  def done!
    @todos.each_index do |idx|
      mark_done_at(idx)
    end
  end

  def remove_at(idx)
    # We use this implementation to return an index error if out of bounds (delete_at does not do this)
    @todos.delete(item_at(idx))
  end

  def to_s
    text = "---- #{title} ----\n"
    text << @todos.map(&:to_s).join("\n")
    text
  end

  def to_a
    @todos.clone
  end

  # In most cases, we prefer to work with the TodoList object directly and invoke method calls on `list`. We would rather not access an internal state of the TodoList, which in this case is @todos. 
  # This is the idea behind encapsulation: we want to hide implementation details from users of the TodoList class, and not encourage users of this class to reach into its internal state. 
  # Instead, we want to encourage users of the class to use the interfaces (ie, public methods) we created for them.
  def each
    @todos.each do |todo|
      yield(todo)
    end
    # Remember that Array#each returns the object on which it was called
    self
  end

  # def select
  #   arr = []
  #   # We use our custom implementation of each here, which we have equipped to take a block
  #   each do |item|
  #     # We use the Array#<< method here
  #     arr << item if yield(item)
  #   end
  #   arr
  # end

  # We use this implementation to follow Ruby's existing pattern of returning the same type of object that called the method
  def select
    list = TodoList.new(title)
    each do |todo|
      list.add(todo) if yield(todo)
    end
    list
  end

  # returns first Todo by title, or nil if no match
  def find_by_title(title)
    select { |todo| todo.title == title }.first
  end

  def all_done
    select { |todo| todo.done? }
  end

  def all_not_done
    select { |todo| !todo.done? }
  end

  def mark_done(title)
    find_by_title(title) && find_by_title(title).done!
  end

  def mark_all_done
    each { |todo| todo.done! }
  end

  def mark_all_undone
    each { |todo| todo.undone! }
  end
end

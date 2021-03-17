# 5) Write a simple linked list implementation. The simplest kind of linked list is a singly linked list. Each element in the list contains data and a "next" field pointing to the next element in the list of elements. This variant of linked lists is often used to represent sequences or push-down stacks (also called a LIFO stack; Last In, First Out). Let's create a singly linked list whose elements may contain a range of data such as the numbers 1-10. Provide functions to reverse the linked list and convert a linked list to and from an array.
=begin
We'll be making a singly linked list. This means that each element in the list does not need to have information about any other element in the list except for the next element.
Each element in the list contains data (a value) and a next field that points to the next element in the list of elements.
The elements of our linked list may contain any data values.
We'll need a method that reverses a linked list, as well as methods that convert a linked list to and from an array. 
=end
class SimpleLinkedList
  def initialize
    @element = []
  end

  def size
    @element.size
  end

  # I think it just returns the first item in the list (remember this is LIFO)
  def peek
    @element.empty? ? nil : @element.first.datum
  end

  # We have to insert an element here, at the front of the array
  def push(item)
    prev_item = @element.first
    @element.insert(0, Element.new(item))
    # We also have to update the next_field of the previous item in this method
    @element.first.next_field = prev_item if !prev_item.nil?
  end

  def empty?
    @element.empty?
  end

  def head
    @element.first
  end

  # LIFO, so first item should be dropped. Return the datum, not the object itself
  def pop
    @element.shift.datum
  end

  # Need to return the underlying object
  # We need to reverse the underlying array, as the elements get inserted in reverse order
  def self.from_a(data_type)
    new_list = new
    data_type.reverse.each { |item| new_list.push(item) } if !data_type.nil?
    new_list
  end

  def to_a
    # Our instance variable returns an array, so we have to dive into the array to apply methods to each item
    @element.map { |item| item.datum }
  end

  def reverse
    # We should return a new object (no mutation)
    reverse_list = SimpleLinkedList.new
    @element.each { |item| reverse_list.push(item.datum) }
    reverse_list
  end
end

# We'll need an Element class per test_access_head_element
class Element
  attr_reader :datum
  attr_writer :next_field

  def initialize(element, next_field = nil)
    @datum = element
    @next_field = next_field
  end

  def next
    @next_field
  end

  def tail?
    @next_field.nil?
  end

  def self
    datum
  end
end

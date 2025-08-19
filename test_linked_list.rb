require 'minitest/autorun'
require_relative './LinkedList'

class TestLinkedList < Minitest::Test
  def test_pop_returns_last_pushed_value
    list = LinkedList.new([1])
    list.push(2)
    list.push(3)
    popped = list.pop
    # The pop method is expected to return the data of the last pushed element
    assert_equal 3, popped._data
  end

  def test_size_decreases_after_pop
    list = LinkedList.new([10])
    list.push(20)
    initial_size = list.size
    list.pop
    assert_equal initial_size - 1, list.size
  end

  def test_pop_on_empty_list_raises_error
    list = LinkedList.new
    assert_raises(StandardError) do
      list.pop
    end
  end
end

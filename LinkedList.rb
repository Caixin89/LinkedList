#!/usr/bin/env ruby

class LinkedList
    class Node
        def initialize(*_data)
            if _data.empty?
                @_data=0
            else
                @_data=_data[0]
            end

            @_next=nil
            @_prev=nil
        end

        def _prev
            return @_prev
        end

        def _next
            return @_next
        end

        def _data
            return @_data
        end

        def _next=(newnode)
            @_next=newnode
        end

        def _prev=(newnode)
            @_prev=newnode
        end

        def _data=(new_data)
            @_data=new_data
        end
    end
    
    def arr_initialize(arr)
        return if arr.empty?

        currnode=@first=Node.new(arr[0])
        @size=1
        
        1.upto(arr.size-1) { |i|
            currnode._next=Node.new(arr[i])
            currnode._next._prev=currnode
            currnode=currnode._next
            @size+=1
        }

        @first._prev=currnode
        currnode._next=@first
    end

    def initialize(*list)
        if list.empty?
            @size=0
            @first=nil
        elsif list[0].is_a?(Array)
            arr_initialize(list[0])
        elsif list[0].is_a?(LinkedList)
            ll_initialize(list[0])
        else
            raise "Unrecognized data type"
        end
    end

    def ll_initialize(ll)
        return if ll.size==0
        @first=Node.new(ll.first._data)
        @size=1
        thisnode=@first
        othernode=ll.first._next

        2.upto(ll.size) {
            thisnode._next=Node.new(othernode._data)
            thisnode._next._prev=thisnode
            thisnode=thisnode._next
            othernode=othernode._next
            @size+=1
        }

        @first._prev=thisnode
        thisnode._next=@first
    end

    def first
        return @first
    end

    def last
        return @first._prev
    end

    def size
        return @size
    end

    def traverse(i)
        raise "Index is not integer" if !i.is_a?(Integer)
        raise "Index is negative" if i<0
        raise "Linked list does not contain this index" if i>=@size
        currnode=@first

        if i<(@size-i)
            1.upto(i) {
                currnode=currnode._next   
            }
        else
            1.upto(@size-i) {
                currnode=currnode._prev
            }
        end

        return currnode
    end
    
    def at(i)
        return traverse(i)._data
    end

    # i can be either index or node where you want to delete.
    def delete_at(i)
        raise "Index is neither integer nor node" if !i.is_a?(Integer) && !i.is_a?(Node)

        if i.is_a?(Integer)
            raise "Index is negative" if i<0
            raise "Linked list does not contain this index" if i>=@size
            currnode=traverse(i)
            @first=currnode._next if i==0
        else
            currnode=i
            @first=currnode._next if i==@first
        end

        currnode._prev._next=currnode._next
        currnode._next._prev=currnode._prev
        @size-=1
    end

    # i can be either index or node where you want to insert _data.
    def insert_at(i, _data)
        raise "Index is neither integer nor node" if !i.is_a?(Integer) && !i.is_a?(Node)
        newnode=Node.new(_data)

        if i.is_a?(Integer)
            raise "Index is negative" if i<0
            raise "Index is greater than size" if i>@size

            if i==0
                currnode=last
                @first=newnode if i==0
            else
                currnode=traverse(i-1)
            end
        else
            currnode=i._prev
            @first=newnode if i==@first
        end

        newnode._next=currnode._next
        newnode._prev=currnode
        currnode._next._prev=newnode
        currnode._next=newnode
        @size+=1
    end

    def push(_data)
        insert_at(@size, _data)
    end

    def pop
        currnode=last
        delete_at(last)
        return last
    end

    private :arr_initialize, :ll_initialize
end

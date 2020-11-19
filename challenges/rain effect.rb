#!/usr/bin/env ruby
require 'colorize'

def append_arrays(array_to_use)
    50.times {
        array_to_use.push(Array.new)
    }
    return array_to_use
end

def get_array()
    new_array = append_arrays(Array.new)
    for i in 0...50
        new_array[i] = append_arrays(new_array[i])
    end
    return new_array
end

def fill_array(array_to_use)
    for i in 0...50
        for j in 0...50
            array_to_use[i][j] = rand(10)
        end
    end
    return array_to_use
end

def print_array(array_to_use, start, finish)
    for i in start...finish
        case array_to_use[i]
        when 0 #? snow 1
            print("* ")#.colorize(:color => :white, :background => :black)
        when 1 #? snow 2
            print("• ")#.colorize(:color => :light_white, :background => :black)
        when 2 #? rain 1
            print("/ ")#.colorize(:color => :blue, :background => :black)
        when 3 #? rain 2
            print("| ")#.colorize(:color => :light_blue, :background => :black)
        else
            print" "
        end
    end
end

def loop_in_array(array_to_use, pointer)
    pointer.downto(0) { |j|
        print_array(array_to_use[j], pointer, 50)
        print_array(array_to_use[j], 0, pointer) unless pointer == 0
        puts ""
    }
    
    49.downto(pointer) { |i|
        print_array(array_to_use[i], pointer, 50)
        print_array(array_to_use[i], 0, pointer) unless pointer == 0
        puts ""
    }
end

def main()
    rain_array = get_array()
    rain_array = fill_array(rain_array)
    pointer = 0
    while true
        loop_in_array(rain_array, pointer)
        if pointer < 48 then pointer += 1 else pointer = 0; end
        sleep(0.1)
        puts("\e[H\e[2J")
    end
end

main()

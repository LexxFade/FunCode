#!/usr/bin/env ruby
require 'colorize'

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
            print "* ".colorize(:color => :white)
        when 1 #? snow 2
            print "• ".colorize(:color => :light_white)
        when 2 #? rain 1
            print "/ ".colorize(:color => :blue)
        when 3 #? rain 2
            print "| ".colorize(:color => :light_blue)
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
    rain_array = Array.new(50) do 
        Array.new(50) { rand(10) } 
    end
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

#!/usr/bin/env ruby
require 'gosu'
require_relative './player.rb'
require_relative './power.rb'

class Zulosphere < Gosu::Window
    def initialize()
        super 650, 490, false
        self.caption = "Zulo\'s Bizarre Adventure v1.0"
        @background_front = Gosu::Image.new("media/martian-background.png", :tileable => true)
        @background_back =  Gosu::Image.new("media/background2.png", :tileable => true)
        
        power_thread= Thread.new{
            loop do
            @candy =  Power.new("candy")
            #@posion = Power.new("poison")
            sleep(rand(5..10))
            end
        }

        @player = Player.new
        @player.summon(150, 400)
        
        @bg1 = @bg2 = 0
        
        @health = 100
    end
    def controls()
        @player.move("jump") if Gosu.button_down? Gosu::KB_UP
        @player.move("back") if Gosu.button_down? Gosu::KB_LEFT
        @player.move("forward") if Gosu.button_down? Gosu::KB_RIGHT
        @player.move("crouch") if Gosu.button_down? Gosu::KB_DOWN
    end
    def happenings()
        item_y = @candy.return_y()
        item_width = @candy.return_width()
        item_height = @candy.return_height()
        did_pass = @player.pass_through(@bg1, item_y, item_width, item_height)
        @health += @candy.pass_status(did_pass)
    end
    def update
        controls()
        happenings()
        #happenings(@poison)
        @player.bounce_height() #update player's y coordinate
        @bg1 -= 2
        @bg2 -= 1
    end
    def draw
        @local_bg1 = @bg1 % - @background_back.width
        @background_back.draw(@local_bg1, 0, 0)
        @background_back.draw(@local_bg1 + @background_back.width, 0, 0) if @local_bg1 < (@background_back.width - self.width)
        
        @local_bg2 = @bg2 % - @background_front.width
        @background_front.draw(@local_bg2, 0, 1)
        @background_front.draw(@local_bg2 + @background_front.width, 0, 1) if @local_bg2 < (@background_front.width - self.width)
        
        @candy.draw(@bg1)
        @player.draw()
    end
    def button_down(id)
        case id
        when Gosu::KB_ESCAPE
            close
        when Gosu::KB_Z
            @player.attack("z")
        when Gosu::KB_X
            @player.attack("x")
        when Gosu::KB_C
            @player.attack("c")
        else
            super
        end
    end
end

Zulosphere.new.show()

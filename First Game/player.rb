#!/usr/bin/env ruby
class Player
    def initialize()
        @zulo = Gosu::Image.new("media/zulo.png")
        @bounce_velocity = 20
        @move_speed = 1.5
		@floor_height = 400
		@facing = 'right'
    end
    def summon(x,y)
        @x_cord = x
        @y_cord = y
    end
    def bounce_height()
        #gravity constant and initial bounce velocities
        gravity = 1.2
        normal_bounce_velocity = 20
        jump_bounce_velocity = 35
        crouch_bounce_velocity = 10
        
        @y_cord -= @bounce_velocity #adjust y coordinate

        @bounce_velocity = -1 if @bounce_velocity.round == 0 #crest of bounce
        @bounce_velocity *= gravity if @bounce_velocity < 0 #falling
        @bounce_velocity /= gravity if @bounce_velocity > 0 #rising

        if @y_cord >= @floor_height #floor
            @y_cord = @floor_height
            @bounce_velocity = normal_bounce_velocity if !@crouch
            @bounce_velocity = jump_bounce_velocity if @jump #higher next jump
            @bounce_velocity = crouch_bounce_velocity if @jump && @crouch #crouch jump
            @jump = false
            @crouch = false
        end
    end
    def move(side)
        case side
        when 'forward'
            if @x_cord < 650
                @x_cord += @move_speed
            end
			@facing = 'right'
        when 'back'
            if @x_cord > 0
                @x_cord -= @move_speed
            end
			@facing = 'left'
        when 'jump'
            @jump = true if @bounce_velocity < 0 #look for next jump when falling
        when 'crouch'
            @crouch = true
        else
            #
        end
    end
    def move_action()
        #
    end
    def pass_through(x, y, width, height)
        #puts(x, y, width, height, @x_cord, @y_cord)
        if (@x_cord > (700+x) && @x_cord < (700+x) + width) && (@y_cord > y && @y_cord < y + height)
            return true
        else
            return false
        end
    end
    def attack(option)
        case option
        when "z"
            #
        when "x"
            #
        when "c"
            #
        end
    end
    def draw()
        #subimage(left, top, width, height)
        @zulo.subimage(0,0,50,50).draw_rot(@x_cord, @y_cord, 3, 0) if @facing == 'right'
		@zulo.subimage(50,0,50,50).draw_rot(@x_cord, @y_cord, 3, 0) if @facing == 'left'
    end
end

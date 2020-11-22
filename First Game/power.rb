class Power
    def initialize(item)
        @item = item
        @icon = Gosu::Image.new("media/"+@item+".png")
        @random_int = rand(0..100)
        @y = rand(300..400)
    end
    def return_y()
        return @y
    end
    def return_width()
        return @icon.width
    end
    def return_height()
        return @icon.height
    end

    def pass_status(status)
        if status
            #@iconUpdated = Gosu::Image.new(@item+"_taken.png")
            return 10 if @item == "candy"
            return -20 if @item == "poison"
        else
            return 0
        end
    end
    def draw(x)
        @icon.draw((640+@random_int+x), @y, 2)
    end
end

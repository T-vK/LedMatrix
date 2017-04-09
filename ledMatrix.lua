-- Matrix Class
function newMatrix(width, height, isZigzag, isStartLedTop, isStartLedLeft, isRowLayout)
    -- only supports top-right and top-left matrix layouts for now
    return {
        width = width
        height = height
        isZigzag = isZigzag
        isStartLedTop = isStartLedTop
        isStartLedLeft = isStartLedLeft
        isRowLayout = isRowLayout
        -- TODO: Make this more efficient by doing these checks on construction
        translate = function(this,x,y)
            local ledNum
            
            if not this.isRowLayout then -- if column layout, simply swap x and y
                local tmpX = x
                x = y
                y = tmpX
                this.width = this.height
            end
            
            if not this.isZigzag then -- progressive layout
                if this.isStartLedTop and this.isStartLedLeft then -- top-left start led
                    ledNum = this.width*y-(this.width-x)
                elseif this.isStartLedTop and not this.isStartLedLeft then -- top-right start led
                    ledNum = this.width*y-x+1
                end
            else -- zigzag layout
                if this.isStartLedTop and this.isStartLedLeft then -- top-left start led
                    if y%2 == 1 then -- every odd row
                        ledNum = this.width*y-(this.width-x)
                    else
                        ledNum = this.width*y-x+1
                    end
                elseif this.isStartLedTop and not this.isStartLedLeft then -- top-right start led
                    if y%2 == 0 then -- every even row
                        ledNum = this.width*y-(this.width-x)
                    else
                        ledNum = this.width*y-x+1
                    end
                end
            end
            return ledNum
        end
    }
end

-- Led Matrix Class
function newLedMatrix(width, height, isZigzag, isStartLedTop, isStartLedLeft, isRowLayout, isRgb)
    -- make sure to call `ws2812.init()` before using the class
    return {
        ledCount = width*height
        bytesPerLed = 3
        if not isRgb then bytesPerLed = 4 end
        ledBuffer = ws2812.newBuffer(ledCount, bytesPerLed)
        matrix = newMatrix(width, height, isZigzag, isStartLedTop, isStartLedLeft, isRowLayout)
        setPixel = function(this,x,y,red,gree,blue)
            local ledNum = this.matrix:translate(x,y)
            this.ledBuffer:set(ledNum, red, green, blue)
        end
        show = function(this)
            ws2812.write(this.ledBuffer)
        end
    }
end
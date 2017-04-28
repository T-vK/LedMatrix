-- Led Matrix Class
function newLedMatrix(width, height, isZigzag, isStartLedTop, isStartLedLeft, isRowLayout, isRgb)
    -- make sure to call `ws2812.init()` before using the class
    local bytesPerLed = 3
    if not isRgb then bytesPerLed = 4 end
    local ledCount = width*height
    return {
        width = width;
        height = height;
        ledCount = ledCount;
        bytesPerLed = bytesPerLed;
        ledBuffer = ws2812.newBuffer(ledCount, bytesPerLed);
        matrix = newMatrix(width, height, isZigzag, isStartLedTop, isStartLedLeft, isRowLayout);
        set = function(this,x,y,red,green,blue)
            --print("x: " .. x .. " y: " .. y .. " red: " .. red .. " green: " .. green .. " blue: " .. blue)
            if x > 0 and x <= this.width and y > 0 and y <= this.height then 
                local ledNum = this.matrix:translate(x,y)
                --print("x: " .. x .. " y: " .. y .. " red: " .. red .. " green: " .. green .. " blue: " .. blue)
                if ledNum > 0 and ledNum <= this.ledCount then
                    this.ledBuffer:set(ledNum, red, green, blue)
                end
            end
        end;
        get = function(this,x,y)
            if x > 0 and x <= this.width and y > 0 and y <= this.height then
                local ledNum = this.matrix:translate(x,y)
                if ledNum > 0 and ledNum <= this.ledCount then
                    local red, green, blue = this.ledBuffer:get(ledNum)
                    return red, green, blue
                end
            else
                return nil,nil,nil
            end
        end;
        show = function(this)
            ws2812.write(this.ledBuffer)
        end;
    }
end
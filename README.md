# LED Matrix Lua library for NodeMCU

## Description
This library allows you to easily set pixels in an RGB or RGBW LED matrix.  
It is written in Lua and relies on the ws2812 module of NodeMCU.  

## LED type support
 - WS2812
 - WS2812b
 - APA104
 - SK6812
 - possibly more

Both RGB and RGBW!
 
## Set up
 - Connect the data pin of your LED strip to GPIO pin 2.  
 - Make sure your power supply can supply enough current to drive your LED strip properly and reliably.  
 - Make sure your version of the NodeMCU firmware has the ws2812 module!!   
 - Make sure `ws2812.init()` has been called before calling `newMatrix()`

## Example 

Turns the LED at x|y position 1|1 and 10|10 white:

``` Lua
ws2812.init()
local ledMatrixInstance = newLedMatrix(10, 10, true, true, false, true, true)
ledMatrixInstance:set(1,1,255,255,255) -- x,y,red,green,blue
ledMatrixInstance:set(10,10,255,255,255)
ledMatrixInstance:show()
```

## Documentation

### newLedMatrix(width, height, isZigzag, isStartLedTop, isStartLedLeft, isRowLayout, isRgb)

Creates a new LedMatrix instance.

#### Parameters

 - `width`: the width of your matrix (number of pixels)
 - `height`: the height of your matrix (number of pixels) 
 - `isZigzag`: `true` if you have a zigzag layout, `false` if you have a progressive layout
 
    A Zigzag layout looks like this:  
     ```
     X -> X -> X
               |
     X <- X <- X
     |
     X -> X -> X
     ```  
     
    A progressive layout looks like this:  
     ```
     X -> X -> X
      _________|
     |
     X -> X -> X
      _________|
     |
     X -> X -> X
     ```
 
 - `isStartLedTop`: `true` if the first LED of your LED chain is in the very top row. `false` if it is in the very bottom row.
 - `isStartLedLeft`: `true` if the first LED of your LED chain is in the very left column. `false` if it is in the very right column.
 - `isRowLayout`: `true` if your LEDs are arranged in a row layout. `false` if your LEDs are arranged in a  column layout.
 - `isRgb`: `true` if your LEDs are RGB. `false` if your LEDs are RGBW.
 
#### Returns

 - returns a new LedMatrix instance

### Methods and properties of LedMatrix instances

#### ledMatrixInstance:set(x,y,red,green,blue)

Parameters 

 - `x and y` The coordinates of the pixel you want to change  
 - `red, green and blue` The components of the color you want to set the LED to. Must be between 0 and 255. 0 being off and 255 being the brightest.

Returns

- No return value

#### ledMatrixInstance:show()

Send the new colors to the LEDs

Parameters 

 - No parameters

Returns

#### matrix

Instance of the matrix class (not documented yet)

#### ledCount

Number of LEDs in this matrix

#### bytesPerLed

Number of bytes that each LED takes (will be 3 for RGB and 4 for RGBW)

#### ledBuffer

    Instance of a ws2812 buffer. Documented [here](https://nodemcu.readthedocs.io/en/master/en/modules/ws2812/#ws2812newbuffer)
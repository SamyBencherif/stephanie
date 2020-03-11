
width = 256 -- make sure this matches conf.lua
height = 256
margin = 10
marginSmall = 1
marginBig = 50

values = 
{
    red   = 1;
    green = 1;
    blue  = 1;
}

function slider(id, fromBottom)

    local barWidth = 5/8 * width
    local barHeight = 10

    love.graphics.setColor(0,0,0)
    love.graphics.print(id, margin, height-fromBottom*(margin+barHeight) - 4)
    love.graphics.print(math.floor(100*values[id])/100, width-30, 
    height-fromBottom*(margin+barHeight) - 4)

    love.graphics.rectangle('fill', marginBig, height-fromBottom*(margin+barHeight), 
    barWidth, barHeight)

    local mx = love.mouse.getX()
    local my = love.mouse.getY()

    local lmx = (mx-(marginBig+marginSmall)) / (barWidth-marginSmall*2)
    local lmy = (my-(height-fromBottom*(margin+barHeight)+marginSmall)) / (barHeight-marginSmall*2)

    if 0 <= lmx and lmx <= 1 and 0 <= lmy and lmy <= 1 then
    -- mouse over
        love.graphics.setColor(.5,.5,1)
        if love.mouse.isDown(1) then
        -- mouse down
        love.graphics.setColor(1,.5,.5)
        values[id] = lmx
        end
    else
    -- default
        love.graphics.setColor(1,1,1)
    end

    love.graphics.rectangle('fill', marginBig+marginSmall, 
        height-fromBottom*(margin+barHeight)+marginSmall, 
        values[id] * (barWidth-marginSmall*2), barHeight-marginSmall*2) 
end

function love.draw()

    love.graphics.clear(values.red, values.green, values.blue)

    slider('red', 3)
    slider('green', 2)
    slider('blue', 1)

end

function love.resize(w, h)
    width = w
    height = h
end

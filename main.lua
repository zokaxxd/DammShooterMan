function love.load()
    Target = {}
    Target.x = 300
    Target.y = 300
    Target.radius = 50

    Score = 0
    Time = 0
    GameState = 1

    love.graphics.setFont(love.graphics.newFont(30))

    Sprites = {}
    Sprites.background = love.graphics.newImage('sprites/backg.jpg')
    Sprites.cross = love.graphics.newImage('sprites/1.png')
    Sprites.alvo = love.graphics.newImage('sprites/2.png')

    love.mouse.setVisible(false)

    dificulAtual = 1
    proxDificulti = 0

    dificulties = {
        1.2,
        1.5,
        1.8,
        2,
        2.5,
        2.8,
        3,
        3.5, 
        4,
        4.5,
        5, 
        5.5
    }

end

function love.update(dt)
    if proxDificulti >= 10 then
        proxDificulti = 0

        if dificulAtual < #dificulties then
            dificulAtual = dificulAtual + 1
        end
    end
    

    
    if Time > 0 then
        Time = Time - dt * dificulties[dificulAtual]
    end


    if Time < 0 then
        Time = 0
        GameState = 1
    end

end

function love.draw()
    love.graphics.draw(Sprites.background, 0, 0)

    love.graphics.print("Score: " .. Score, 10, 10)
    love.graphics.print("Time: " .. math.ceil(Time), 10, 50)
    love.graphics.print("Dificuldade: "..dificulAtual, 10, 90)

    if GameState == 2 then
        love.graphics.draw(Sprites.alvo, Target.x-84, Target.y-69)
    end

    love.graphics.draw(Sprites.cross, love.mouse.getX()-83, love.mouse.getY()-100)
    
    if GameState == 1 then
        love.graphics.printf("click anywhere to begin", 0, 250, love.graphics.getWidth(), "center")
    end
    
end

function love.mousepressed(x, y, button)
    if button == 1 and GameState == 2 then
        local mouseTo = DistanceBewteen(x, y, Target.x, Target.y)
        if mouseTo < Target.radius then
            Score = Score + 1
            proxDificulti = proxDificulti + 1
            Target.x = math.random(Target.radius, love.graphics.getWidth() - Target.radius)
            Target.y = math.random(Target.radius, love.graphics.getHeight() - Target.radius)
            Time = 10
        elseif mouseTo > Target.radius then
            Score = Score - 1
            if Score < 0 then
                Score = 0
            end
        end
    elseif button == 1 and GameState == 1 then
        GameState = 2
        Time = 10
        Score = 0
        dificulAtual = 1
        proxDificulti = 0
    end

    if button == 2 and GameState == 2 then
        local mouseTo = DistanceBewteen(x, y, Target.x, Target.y)
        if mouseTo < Target.radius then
            Target.x = math.random(Target.radius, love.graphics.getWidth() - Target.radius)
            Target.y = math.random(Target.radius, love.graphics.getHeight() - Target.radius)
            Score = Score + 2
            proxDificulti = proxDificulti + 1
            Time = Time - 1
        end
    end

end

function DistanceBewteen(x1, y1, x2, y2)
    return math.sqrt ((x2-x1)^2 + (y2-y1)^2)
end


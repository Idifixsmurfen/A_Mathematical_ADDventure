local background = nil
love.window.setTitle("ADDventure, the math jurney")
print("TESTING")
love.window.setMode( 680, 445 )

function entireGame()
    

    local utf8 = require("utf8")
    rightCount = 0
    
    function love.load()
        time = 0
        pauseBegin = 0
        pauseDuration = 3
        isPaused = false

            -- RNG ______________________________________

    math.randomseed(love.timer.getTime( ))
    randomNumber_1 = math.random(1,9)

    math.randomseed(love.timer.getTime( ))
    randomNumber_2 = math.random(1,9)

    math.randomseed(love.timer.getTime( ))
    randomNumber_3 = math.random(1,9)

    math.randomseed(love.timer.getTime( ))
    randomNumber_TTPO = math.random(0,3)


    print(randomNumber_1)
    print(randomNumber_2)
    print(randomNumber_3)
    print(randomNumber_TTPO)
    print("ttpo test"..randomNumber_1 ^ randomNumber_TTPO)

    -- End of RNG _______________________________


  

    welcomeMessage = ""
    playerAnswer = ""

    correct = randomNumber_1 + randomNumber_2 * randomNumber_3

    computerAnswer = tostring(correct)--konverterar correct till en sträng "computerAnswer"


        playerAnswer = "" --fältet där spelaren skriver text
    
        love.keyboard.setKeyRepeat(true) --möjliggör key repeat

        background = love.graphics.newImage('mathlady.png')
    end
    
    function love.textinput(t)
        playerAnswer = playerAnswer .. t
    end

    function love.keypressed(key)
        if key == "backspace" then
        
            local byteoffset = utf8.offset(playerAnswer, -1)
        
            if byteoffset then

                playerAnswer = string.sub(playerAnswer, 1, byteoffset - 1)
            end
        end

        if key == "return" then
            if playerAnswer == computerAnswer then
                welcomeMessage ="Bravo!"
                print("Barvo")
                print(playerAnswer)
                rightCount = rightCount + 1
                print("rightCount is currently "..rightCount)
                isPaused = true
                pauseBegin = time


            elseif playerAnswer == "69" then
                welcomeMessage = "Nice."
            
            else print ("oops")
                print(playerAnswer)
                welcomeMessage = "Tänk om"
            end
        end

        if key == "escape" then
            love.event.quit()
        end

        if key == "tab" then
           --entireGame()
            if rightCount > 0 then
                rightCount = rightCount - 1
            end
            print("rightCount is currently "..rightCount)
            love.load()
        end
        if key == "f1" then
            rightCount = rightCount + 1
            print("rightCount is currently "..rightCount)
        end
    end

    function love.update(deltaTime)
        if isPaused == true then
            time = time + deltaTime
                if time > pauseBegin + pauseDuration then 
                    isPaused = false
                    love.load()
                    print(deltaTime)
                end
        end
        if rightCount > 4 then -- Function that checks if rightCount is 5
            rightCount = 0
            print("rightCount is currently "..rightCount.." (reset)")
            --INSERT BACK TO MENUE FUNCTION
        end

    end



    function love.draw()

        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(background) --bakgrunden

        love.graphics.setColor(0, 1, 0) --ändrar textens färg med RGB värde
        love.graphics.printf(playerAnswer, 340, 300, love.graphics.getWidth()) --texten spelaren skriver

        love.graphics.setColor(0, 1, 0) --ändrar textens färg med RGB värde
        love.graphics.print(welcomeMessage, 150, 150,0 ,1) --texten som säger om du svarade rätt

        love.graphics.setColor(1, 1, 0)
        love.graphics.print("Vad är "..randomNumber_1.."+"..randomNumber_2.."*"..randomNumber_3.."?", 250, 200,0 ,1)

        love.graphics.print("Tryck Tab för att generera ett nytt scenario",10,10,0,1)

    end
    
    

end

entireGame()


local background = nil
love.window.setTitle("ADDventure, the math jurney")
print("TESTING")
love.window.setMode( 680, 445 )

function entireGame()
    

    local utf8 = require("utf8")
    rightCount = 0
    difficulty = 0
    question = ""
    tabThing = [[Svårighetsgrader
    F1 = + och -
    F2 = *
    F3 = * och + eller -
    F4 = ^, * och + eller -
    ]]
    tabMSG = "Tryck Tab för att generera ett nytt scenario eller F5 för att återvända till menyn"
    print("diff"..difficulty)

    
    function love.load()
        time = 0
        time2 = 0
        pauseBegin = 0
        pauseDuration = 3
        isPaused = false
        isPausedLevelComplete = false

            -- RNG ______________________________________

    math.randomseed(love.timer.getTime( ))
    randomNumber_1 = math.random(1,9)

    math.randomseed(love.timer.getTime( ))
    randomNumber_2 = math.random(1,9)

    math.randomseed(love.timer.getTime( ))
    randomNumber_3 = math.random(1,9)

    math.randomseed(love.timer.getTime( ))
    randomNumber_TTPO = math.random(0,3)
    
    math.randomseed(love.timer.getTime( ))
    randomOperator_add_sub = math.random(0,1)


    print(randomNumber_1)
    print(randomNumber_2)
    print(randomNumber_3)
    print(randomNumber_TTPO)
    print(randomOperator_add_sub)
    print("ttpo test"..randomNumber_1 ^ randomNumber_TTPO)

    -- End of RNG _______________________________


  

    welcomeMessage = ""
    playerAnswer = ""

-- Difficulty things ___________________________________
    if difficulty == 1 then
        if randomOperator_add_sub == 0 then 
            correct = randomNumber_1 + randomNumber_2
            question = "vad är ".. randomNumber_1.. " + ".. randomNumber_2.."?"
        
        else
            correct = randomNumber_1 - randomNumber_2
            question = "vad är ".. randomNumber_1.. " - ".. randomNumber_2.."?"
        end
    end

    if difficulty == 2 then
        correct = randomNumber_1 * randomNumber_2
        question = "vad är ".. randomNumber_1.. " * ".. randomNumber_2.."?"
    end

    if difficulty == 3 then
        if randomOperator_add_sub == 0 then
            correct = randomNumber_1 + randomNumber_2 * randomNumber_3
            question = "Vad är "..randomNumber_1.. " + "..randomNumber_2.." * "..randomNumber_3.."?"
        else
            correct = randomNumber_1 * randomNumber_2 - randomNumber_3
            question = "Vad är "..randomNumber_1.. " * "..randomNumber_2.." - "..randomNumber_3.."?"

        end
    end

    if difficulty == 4 then
        if randomOperator_add_sub == 0 then
            correct = randomNumber_1 ^ randomNumber_TTPO + randomNumber_2 * randomNumber_3
            question = "Vad är "..randomNumber_1.. " ^ "..randomNumber_TTPO.." + "..randomNumber_2.." * "..randomNumber_3.."?"
        else
            correct = randomNumber_1 ^ randomNumber_TTPO - randomNumber_2 * randomNumber_3
            question = "Vad är "..randomNumber_1.. " ^ "..randomNumber_TTPO.." - "..randomNumber_2.." * "..randomNumber_3.."?"

        end
    end
    print("diff"..difficulty)
    -- End of Difficulty things ___________________________________
    --correct = randomNumber_1 + randomNumber_2 * randomNumber_3

    computerAnswer = tostring(correct)--konverterar correct till en sträng "computerAnswer"


        playerAnswer = "" --fältet där spelaren skriver text
    
        love.keyboard.setKeyRepeat(true) --möjliggör key repeat

        background = love.graphics.newImage('mathlady.png')
    end

    function f5Function()
        difficulty = 0
        question = ""
        tabThing = [[Svårighetsgrader
        F1 = + och -
        F2 = *
        F3 = * och + eller -
        F4 = ^ och + eller -
        ]]
        love.load()
        rightCount = 0
        welcomeMessage = ""
        playerAnswer = ""
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
                print("Barvo")
                print(playerAnswer)
                rightCount = rightCount + 1
                print("rightCount is currently "..rightCount)

                pauseBegin = time
                if rightCount < 5 then
                    welcomeMessage ="Bravo!"
                    isPaused = true
                else
                    welcomeMessage ="bra jobbat! Återväner till menyn."
                    isPausedLevelComplete = true

                end

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
            difficulty = 1
            love.load()
            rightCount = 0
            tabThing = tabMSG
        end

        if key == "f2" then
            difficulty = 2
            love.load()
            rightCount = 0
            tabThing =tabMSG
        end

        if key == "f3" then
            difficulty = 3
            love.load()
            rightCount = 0
            tabThing = tabMSG
        end

        if key == "f4" then
            difficulty = 4
            love.load()
            rightCount = 0
            tabThing = tabMSG
        end
       
        if key == "f5" then

            f5Function()

        end

        if key == "f12" then
            rightCount = rightCount + 1--REMOVE ME LATER !!!!!!!!!
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
        if isPausedLevelComplete == true then
            time2 = time2 + deltaTime
                if time2 > pauseBegin + pauseDuration then 
                    isPausedLevelComplete = false
                    f5Function()
                    print(deltaTime)
                end
        end
        if rightCount > 4 then -- Function that checks if rightCount is 5
            rightCount = 0
            print("rightCount is currently "..rightCount.." (reset)")
            
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
        love.graphics.print(question, 250, 200,0 ,1)

        love.graphics.print(tabThing,10,10,0,1)

    end
    
    

end

entireGame()


local background = nil


function entireGame()
print("TESTING")

-- RNG ______________________________________

math.randomseed(love.timer.getTime( ))
randomNumber_1 = math.random(1,9)

math.randomseed(love.timer.getTime( ))
randomNumber_2 = math.random(1,9)

math.randomseed(love.timer.getTime( ))
randomNumber_3 = math.random(1,9)


print(randomNumber_1)
print(randomNumber_2)
print(randomNumber_3)

-- End of RNG _______________________________


love.window.setMode( 680, 445 )

welcomeMessage = ""
playerAnswer = ""

correct = randomNumber_1 + randomNumber_2 * randomNumber_3


computerAnswer = "" .. correct .. "" --konverterar correct till en sträng "computerAnswer"







local utf8 = require("utf8")
 
function love.load()

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
            print("Barvo")
            print(playerAnswer)
            welcomeMessage ="Bravo!"

        else print ("oops")
            print(playerAnswer)
            welcomeMessage = "Tänk om"
        end
    end
    if key == "escape" then
        love.event.quit()
    end

    if key == "tab" then
       entireGame()
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

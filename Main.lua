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


welcomeMessage = ""

correct = randomNumber_1 + randomNumber_2 * randomNumber_3


computerAnswer = "" .. correct .. "" --konverterar correct till en sträng "computerAnswer"







local utf8 = require("utf8")
 
function love.load()
    playerAnswer = "" --fältet där spelaren skriver text
 
    -- enable key repeat so backspace can be held down to trigger love.keypressed multiple times.
    love.keyboard.setKeyRepeat(true)
end
 
function love.textinput(t)
    playerAnswer = playerAnswer .. t
end
 
function love.keypressed(key)
    if key == "backspace" then
        -- get the byte offset to the last UTF-8 character in the string.
        local byteoffset = utf8.offset(playerAnswer, -1)
       
 
        if byteoffset then
            -- remove the last UTF-8 character.
            -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
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
       love.event.quit("restart")
    end
end
 
function love.draw()
    love.graphics.setColor(0.7, 0.5, 0) --ändrar textens färg med RGB värde
    love.graphics.printf(playerAnswer, 70, 450, love.graphics.getWidth()) --texten spelaren skriver
    
    love.graphics.setColor(0.5, 0.8, 0) --ändrar textens färg med RGB värde
    love.graphics.print(welcomeMessage, 256, 34,0 ,1) --texten högst upp på skärmen

    love.graphics.setColor(1, 1, 0)
    love.graphics.print("Vad  "..randomNumber_1.."+"..randomNumber_2.."*"..randomNumber_3.."?", 256, 50,0 ,1)

    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Tryck Tab för att generera ett nytt scenario",10,10,0,1)
end


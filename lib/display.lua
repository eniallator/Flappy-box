local display = {}

function display.game()
  love.graphics.setColor(0, 0, 255)
  love.graphics.rectangle("fill", player.x, player.y, player.w, player.h)

  for _,p in pairs(pipes) do
    love.graphics.setColor(0, 255, 0)
    love.graphics.rectangle("fill", p.x, 1, pipeWidth, p.mid -pipeGap)
    love.graphics.rectangle("fill", p.x, p.mid + pipeGap, pipeWidth, screenDim[2] -p.mid- pipeGap/2)
  end

  love.graphics.setColor(255,255,255)
  love.graphics.print("Score: " .. currScore)
end

function display.box(box)  
  love.graphics.setColor(box.r, box.g, box.b)
  love.graphics.rectangle("fill", box.x, box.y, box.w, box.h)
  love.graphics.setColor(255, 255, 255)
  love.graphics.printf(box.name, box.x + box.w/2 - Font:getWidth(box.name)/2, box.y + box.h/2 - Font:getHeight(box.name)/2,box.w)
end

function display.hs()
  if currScreen == "main" then
    if highScore and highScore[2] then
      highScoreMsg = "HighScore: " .. highScore[1] .. "\n" .. highScore[2]

    else
      highScoreMsg = "No HighScore Set Yet"
    end

    love.graphics.print(highScoreMsg, screenDim[1] /2 -Font:getWidth(highScoreMsg)/2, screenDim[2]/7.5)
  end
end

return display

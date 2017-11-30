local update = {}

function update.pipe()

  if not pipeCooldown then
    pipeCooldown = 4*60
  end

  if pipeCooldown == 4*60 then
    local midPoint = math.random(screenDim[2] - pipeGap)
    table.insert(pipes,{x = screenDim[1], mid = midPoint})
    pipeCooldown = 1

  else
    pipeCooldown = pipeCooldown + 1
  end
end

function update.velocity()
  if love.keyboard.isDown("space") or love.mouse.isDown(1) then
    player.v = screenDim[2]/(600/7)
  end

  player.v = player.v - screenDim[2]/(600/0.25)
  player.y = player.y - player.v

  for k,p in pairs(pipes) do
    if p.x + pipeWidth > 0 then
      p.x = p.x - screenDim[1]/400

    else
      table.remove(pipes,k)
    end
  end
end

function update.checkClick(loadedTable)
  clicked = false

  if love.mouse.isDown(1) then
    if not stillDown then
      clicked = true
    end

    stillDown = true
  else
    stillDown = false
  end

  if clicked then
    mouseCoords = {love.mouse.getPosition()}

    for name,box in pairs(loadedTable) do
      if mouseCoords[1] >= box.x and mouseCoords[1] <= box.x + box.w and mouseCoords[2] >= box.y and mouseCoords[2] <= box.y + box.h then

        return name
      end
    end

    return false
  end
end

function update.score()
  for _,p in pairs(pipes) do
    if math.floor(p.x + pipeWidth+0.5) == player.x then
      currScore = currScore + 1
    end
  end
end

function update.scoreFile()
  if loggingActivated then
    if love.filesystem.exists("highScore.log") then
      hs = {}

      for line in love.filesystem.lines("highScore.log") do
        table.insert(hs,line)
      end

      if currScore and (not tonumber(hs[1]) or tonumber(hs[1]) < currScore) then
        love.filesystem.write("highScore.log", currScore .. "\r\n" .. os.date("[%x %X]"))
      end

      highScore = {}

      for line in love.filesystem.lines("highScore.log") do
        table.insert(highScore,line)
      end

    else
      love.filesystem.write("highScore.log", "")
    end
  end
end

return update

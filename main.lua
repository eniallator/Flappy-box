function initGame()
  pipes = {}
  pipeWidth = screenDim[1]/(13+1/3)
  pipeGap = screenDim[2]/7.5
  player = {x = screenDim[1]/8, y = screenDim[2]/2, v = 5, w = screenDim[2]/20, h = screenDim[2]/20}
  pipeCooldown = 4*60
  gameOver = false
  currScore = 0
end

function love.load()
  checkCollision = require "lib/checkCollision"
  update = require "lib/update"
  display = require "lib/display"
  optScreens = require "lib/optScreens"

  love.window.setTitle("Flappy Box")
  screenDim = {love.graphics.getDimensions()}
  love.graphics.setFont(love.graphics.newFont(screenDim[1]/40))
  Font = love.graphics.getFont()
  loggingActivated = true
  godModeActivated = false
  gameOver = true
  currScreen = "main"
  update.scoreFile()
end

function love.update()
  if not gameOver then
    update.pipe()
    update.velocity()
    update.score()

    if not godModeActivated and not checkCollision.pipe() or not checkCollision.boundary() then
      gameOver = true
      update.scoreFile()
    end

  else
    clickedBox = update.checkClick(optScreens[currScreen].display())

    if clickedBox then
      optScreens[currScreen].funcs[clickedBox]()
    end
  end
end

function love.draw()
  love.graphics.print(love.filesystem.getSaveDirectory())
  if not gameOver then
    display.game()

  else
    display.hs()
    for _,box in pairs(optScreens[currScreen].display()) do

      display.box(box)
    end
  end
end

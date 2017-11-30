local optScreens = {}

local function getDefaults()
  return {r = 150, g = 150, b = 150, x = screenDim[1] /2 -screenDim[1]/8, w = screenDim[1]/4}
end

local function getSpaceBetweenBox() return screenDim[2]/60 end

optScreens.main = {
  display = function()

    default = getDefaults()
    spaceBetweenBox = getSpaceBetweenBox()
    return {
      play = {name = "Play", r = 0, g = default.g, b = 0, x = default.x, y = screenDim[2] /2 -screenDim[2]/8 - spaceBetweenBox, w = default.w, h = screenDim[2]/8},
      settings = {name = "Settings", r = default.r, g = default.g, b = default.b, x = default.x, y = screenDim[2] /2 +spaceBetweenBox/2, w = default.w, h = screenDim[2]/8}
    }
  end,

  funcs = {
    play = function() initGame() end,
    settings = function() currScreen = "settings" end
  }
}

optScreens.settings = {
  display = function()

    default = getDefaults()
    spaceBetweenBox = getSpaceBetweenBox()
    return {
      log = {name = "logScore = " .. tostring(loggingActivated), r = default.r, g = default.g, b = default.b, x = default.x, y = screenDim[2] /2 -1.5 *(screenDim[2]/10) -spaceBetweenBox, w = default.w, h = screenDim[2]/10},
      godMode = {name = "godMode = " .. tostring(godModeActivated), r = default.r, g = default.g, b = default.b, x = default.x, y = screenDim[2] /2 -0.5 *(screenDim[2]/10), w = default.w, h = screenDim[2]/10},
      back = {name = "Back", r = default.r, g = default.g, b = default.b, x = default.x, y = screenDim[2] /2 +0.5*(screenDim[2]/10) +spaceBetweenBox, w = default.w, h = screenDim[2]/10}
    }
  end,

  funcs = {
    log = function() loggingActivated = not loggingActivated end,
    godMode = function() godModeActivated = not godModeActivated end,
    back = function() currScreen = "main" end
  }
}

return optScreens

local checkCollision = {}

function checkCollision.pipe()
  for _,p in pairs(pipes) do
    if p.x <= player.x + player.w and player.x <= p.x + pipeWidth then
      if player.y <= p.mid - pipeGap or player.y + player.h >= p.mid + pipeGap then
        return false
      end
    end
  end

  return true
end

function checkCollision.boundary()
  if player.y < 0 or player.y + player.h > screenDim[2] then
    return false
  end

  return true
end

return checkCollision

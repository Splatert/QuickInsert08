game.Players:CreateLocalPlayer(0)

local pl = game.Players.localPlayer
local cam = workspace.CurrentCamera


local bPart = Instance.new("HopperBin", pl)
local bPlate = Instance.new("HopperBin", pl)
local bBall = Instance.new("HopperBin", pl)
local bWheel = Instance.new("HopperBin", pl)
local bFigure = Instance.new("HopperBin", pl)

bPart.Name = "Part"
bPlate.Name = "Plate"
bBall.Name = "Ball"
bWheel.Name = "Cylinder"
bFigure.Name = "Figure"


bPart.Selected:connect(function()
	insertPart(false, "block")
end)

bPlate.Selected:connect(function()
	insertPart(true, "block")
end)

bBall.Selected:connect(function()
	insertPart(false, "ball")
end)

bWheel.Selected:connect(function()
	insertPart(false, "wheel")
end)

bFigure.Selected:connect(function()
	insertFigure()
end)

local settings = {
	["anchoredMode"] = false,
	["surfaceless"] = false,
}


function insertPart(isPlate, shape)

  local part = Instance.new("Part", workspace)
  
  if cam then
	  part.CFrame = workspace.CurrentCamera.CoordinateFrame * CFrame.new(0,0,-5)
	  part.CFrame = CFrame.new(part.Position)
	--part.Position = workspace.CurrentCamera.CoordinateFrame.p + Vector3.new(0,0,-5)
  end
  
  if isPlate then
    part.formFactor = "Plate"
  end

  if shape then
    if shape == "block" then
      part.Shape = "Block"
    elseif shape == "ball" then
      part.Shape = "Ball"
    elseif shape == "wheel" then
      part.Shape = "Cylinder"
    end

    if shape == "ball" or shape == "wheel" then
      part.TopSurface = "Smooth"
      part.BottomSurface = "Smooth"
    end
  end

end



function insertFigure()
  workspace:InsertContent("rbxasset://Fonts/Character.rbxm")
  local figure = workspace:FindFirstChild("erik.cassel")
  
  if figure then
  
	if cam then
		figure:MoveTo(workspace.CurrentCamera.CoordinateFrame.p + Vector3.new(0,0,-5))
	end
  
    figure.Name = "Figure"
	
    local limbs = figure:GetChildren()
    for i=1,#limbs do
      if limbs[i].className == "Part" then
		limbs[i].Locked = false
      end
    end
	
  end
end
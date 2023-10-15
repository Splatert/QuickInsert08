game.Players:CreateLocalPlayer(0)

local pl = game.Players.localPlayer
local cam = workspace.CurrentCamera


local anchoredMode = false


local tooltip = Instance.new("Message", pl)


local bPart = Instance.new("HopperBin")
local bPlate = Instance.new("HopperBin")
local bBall = Instance.new("HopperBin")
local bWheel = Instance.new("HopperBin")
local bFigure = Instance.new("HopperBin")
local bAnchoredMode = Instance.new("HopperBin")
local bHeadMesh = Instance.new("HopperBin")
local bWedge = Instance.new("HopperBin")
local bSign = Instance.new("HopperBin")
local bNeutralSpawn = Instance.new("HopperBin")
local bTeamSpawn = Instance.new("HopperBin")

local bPage = Instance.new("HopperBin")
local test = Instance.new("HopperBin")

local anchoredON = "27112ade92a12bfc4407aa22150e9fb6"
local anchoredOFF = "64b13c78dec8c551b55e74c22b292114"


bPart.Name = "Part"
bPlate.Name = "Plate"
bBall.Name = "Ball"
bWheel.Name = "Cylinder"
bFigure.Name = "Figure"
bPage.Name = "Page 1 [Basics]"
bHeadMesh.Name = "Head"
bWedge.Name = "Wedge"
bSign.Name = "TextSign"
bNeutralSpawn.Name = "NeutralSpawn"
bTeamSpawn.Name = "TeamSpawn"

bAnchoredMode.Name = "Anchored: nil"
bAnchoredMode.TextureId = anchoredOFF


bPart.TextureId = "0e23c2b3696abc625b89fe35ee2a75b7"
bPlate.TextureId = "d310da05c7756448a2389d3060669d28"
bBall.TextureId = "f1271bec69e09cf5eaabb0d14ee2977e"
bWheel.TextureId = "5e44c6bb929634e1e5d7d5ed1604f0dc"
bFigure.TextureId = "1cfbf5dd7075879f6178af4d458c1b68"
bHeadMesh.TextureId = "0ec31bfa9ca8b87ea07a4f0801cedec3"
bWedge.TextureId = "764b351dff29b7793aa803937404879f"
bSign.TextureId = "bde9e61f928f26b2a36bf393712fb655"
bNeutralSpawn.TextureId = "rbxasset://textures/SpawnLocation.png"

local page = 1
local pageMin = 1
local pageMax = 5

local page1 = {bPart, bPlate, bBall, bWheel}
local page2 = {bHeadMesh, bWedge}
local page3 = {bFigure}
local page4 = {bNeutralSpawn, bTeamSpawn}
local page5 = {bSign}

function viewPage(p)
	
	local from = nil
	local category = ""
	
	if p == 1 then
		from = page1
		category = "Basic"
	elseif p == 2 then
		from = page2
		category = "Meshes"
	elseif p == 3 then
		from = page3
		category = "Characters"
	elseif p == 4 then
		from = page4
		category = "Gameplay"
	elseif p == 5 then
		from = page5
		category = "Signs"
	end
	
	local ex = pl:GetChildren()
	for i=1,#ex do
		if ex[i].className == "HopperBin" then
			ex[i].Parent = nil
		end
	end
	
	for i=1,#from do
		from[i].Parent = pl
	end
	
	if bPage and bAnchoredMode then
		bAnchoredMode.Parent = pl
		bPage.Parent = pl
		bPage.Name = "Page " ..page.. "[" ..category.. "]"
	end
	
end


function displayToolTip(text)
	if tooltip then
		tooltip.Text = text
		wait(1)
		tooltip.Text = ""
	end
end


function hideGivenTools()
	local tools = pl:GetChildren()
	for i=1,#tools do
		if tools[i].className == "HopperBin" then
			tools[i].Parent = nil
		end
	end
end

function destroyGivenTools()
	local tools = pl:GetChildren()
	for i=1,#tools do
		if tools[i].className == "HopperBin" then
			tools[i]:remove()
		end
	end
end



function say(msg)
	local m = Instance.new("Message", workspace)
	m.Text = msg
	wait(1)
	m:remove()
end



local teamColors = {"Bright red", "Bright orange", "Bright yellow", "Bright green", "Bright blue", "Bright violet"}
function askForTeamColor()

	local msg = Instance.new("Message", pl)
	msg.Text = "Choose a team color."

	hideGivenTools()
	local chosenColor = ""
	local hasChosen = false
	
	for i=1,#teamColors do
		local binColor = Instance.new("HopperBin", pl)
		binColor.Name = teamColors[i]
		
		binColor.Selected:connect(function()
			chosenColor = binColor.Name
			hasChosen = true
			--say("Set: " ..chosenColor)
		end)
	end
	
	repeat
		wait(.25)
	until hasChosen
	
	msg:remove()
	destroyGivenTools()
	createSpawnLocation(false, chosenColor)
	viewPage(4)
end

bTeamSpawn.Selected:connect(function()
	askForTeamColor()
end)

bNeutralSpawn.Selected:connect(function()
	createSpawnLocation(true)
end)



function createSpawnLocation(isNeutral, nameTeamColor)
	
	local spawner = Instance.new("SpawnLocation", workspace)
	spawner.Size = Vector3.new(4,1,4)
	
	if cam then
	  spawner.CFrame = workspace.CurrentCamera.CoordinateFrame * CFrame.new(0,0,-5)
	  spawner.CFrame = CFrame.new(spawner.Position)
	end
	
	spawner.TopSurface = "Smooth"
	spawner.FrontSurface = "Weld"
	spawner.BackSurface = "Weld"
	spawner.LeftSurface = "Weld"
	spawner.RightSurface = "Weld"
	
	if anchoredMode then
		spawner.Anchored = true
	end
	
	local decal = Instance.new("Decal", spawner)
	decal.Texture = "rbxasset://textures/SpawnLocation.png"
	decal.Face = "Top"
	
	if not isNeutral and nameTeamColor then
		spawner.BrickColor = BrickColor.new(nameTeamColor)
		
		local teams = game:GetService("Teams")
		
		local team = Instance.new("Team", teams)
		team.TeamColor = spawner.BrickColor
	end
	
	
end


bSign.Selected:connect(function()

	local part = insertPart(true, "block")
	part.Size = Vector3.new(1,.25,1)
	
	part.LeftSurface = "Weld"
	part.RightSurface = "Weld"
	
	part.Name = "Head"
	
	local model = Instance.new("Model", workspace)
	model.Name = "Text Sign"
	part.Parent = model
	
	local hu = Instance.new("Humanoid", model)
	hu.Health = 0
	hu.MaxHealth = 0
	
end)



bPage.Selected:connect(function()
	if page >= pageMin and page < pageMax then
		page = page + 1
	elseif page >= pageMax then
		page = 1
	end
	
	viewPage(page)
	
end)


bHeadMesh.Selected:connect(function()
	local part = insertPart(true, "block")
	part.Size = Vector3.new(2,1,1)
	local mesh = Instance.new("SpecialMesh", part)
end)

bWedge.Selected:connect(function()
	local part = insertPart(false, "block")
	part.Size = Vector3.new(1,1,1)
	local mesh = Instance.new("SpecialMesh", part)
	mesh.MeshType = "Wedge"
end)


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


bAnchoredMode.Selected:connect(function(mouse)
	if anchoredMode then
		anchoredMode = false
		bAnchoredMode.Name = "Anchored [OFF]"
		bAnchoredMode.TextureId = anchoredOFF
		displayToolTip("Anchored: OFF")
	else
		anchoredMode = true
		bAnchoredMode.Name = "Anchored [ON]"
		bAnchoredMode.TextureId = anchoredON
		displayToolTip("Anchored: ON")
	end
	
end)


function insertPart(isPlate, shape)

  local part = Instance.new("Part", workspace)
  select(part)
  
  if cam then
	  part.CFrame = workspace.CurrentCamera.CoordinateFrame * CFrame.new(0,0,-5)
	  part.CFrame = CFrame.new(part.Position)
  end
  
  if isPlate then
    part.formFactor = "Plate"
  end
  
  if anchoredMode then
	part.Anchored = true
  else
	part.Anchored = false
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

  return part

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
		
		if anchoredMode then
			limbs[i].Anchored = true
		end
		
      end
    end
	
  end
end



function select(obj)
	--game:GetService("Selection"):Set(obj) -- does nothing
end

viewPage(1)
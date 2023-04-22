include("autorun/sh_mcteleport.lua") 
util.AddNetworkString("callunit")
util.AddNetworkString("playerplanereport")
util.AddNetworkString("playerplanereportend")

local IsPlayerInPlane = false
local ISFROZENPLAYER = false
local PlayerUser = none
local radius = 100 
local speed = 50 
local angle = 0 
local moveDelay = 0.01 

hook.Add("PlayerSay","MW_PlayerSay",function(sender,text,teamChat)
    PlayerUser = sender 
    
    if text == "MW2" then
        IsPlayerInPlane = true
        local LocalPlayeruser = sender 
        --spineffect()
        net.Start("playerplanereport")
            net.WriteBool(IsPlayerInPlane)
        net.Broadcast()
        net.Start("callunit")
            net.WriteEntity(LocalPlayeruser)
        net.Broadcast()
        POSRES = sender:GetPos()
        centerPos = PlayerUser:GetPos()
        ISFROZENPLAYER = false
        frozenplayer()
        print(POSRES)
        LocalPlayeruser:SetFOV(40)
        LocalPlayeruser:SetViewOffset(Vector(0,0,7000))
        LocalPlayeruser:SetViewOffsetDucked(Vector(0,0,7000))
        LocalPlayeruser:StripWeapons()
    elseif text == "MW3" then 
        net.Start("playerplanereportend")
            net.WriteBool(IsPlayerInPlane)
        net.Broadcast()
        IsPlayerInPlane = false
        ISFROZENPLAYER = true 
        frozenplayer()
        LocalPlayeruser:SetFOV(0)
        LocalPlayeruser:SetViewOffset(Vector(0,0,64))
        LocalPlayeruser:SetViewOffsetDucked(Vector(0,0,32))
        LocalPlayeruser:KillSilent()
        LocalPlayeruser:Spawn()
        LocalPlayeruser:SetPos(Vector(POSRES))
    end
end)

function frozenplayer()
    if ISFROZENPLAYER == false then 
        PlayerUser:SetRunSpeed(0)
        PlayerUser:SetWalkSpeed(0)
        PlayerUser:SetDuckSpeed(1)
    elseif ISFROZENPLAYER == true then 
        PlayerUser:SetWalkSpeed(200)
		PlayerUser:SetRunSpeed(400)
        PlayerUser:SetDuckSpeed(100)
	end				
end

function spineffect()
    timer.Create("MovePlayer", moveDelay, 0, function()
        local newX = centerPos.x + math.cos(angle) * radius 
        local newY = centerPos.y + math.sin(angle) * radius 
        local newPos = Vector(newX, newY, centerPos.z)
        ply:SetPos(newPos) 
    
        angle = angle + speed * moveDelay 
        if angle > 360 then 
            angle = angle - 360 
        end 
    end)
    
    timer.Simple(30, function()
        timer.Remove("MovePlayer") 
    end)
end
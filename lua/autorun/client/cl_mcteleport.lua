include("autorun/sh_mcteleport.lua")
local material = Material("ac-130/AC130HUD2.png")

net.Receive("callunit",function()
    Local_Player = net.ReadEntity()
    

    if Local_Player == LocalPlayer() then 
        surface.PlaySound("comms/deploypro.wav")
        Local_Player:ScreenFade(SCREENFADE.IN,Color(0,0,0),4,4)
        timer.Simple(3,function()
            Local_Player:EmitSound("ac_130/ac130flight.wav",100,100,1,CHAN_AUTO,SND_DO_NOT_OVERWRITE_EXISTING_ON_CHANNEL,1)
        end)
    else
        surface.PlaySound("ac_130/flyby_6.wav")
        timer.Simple(2,function()
            surface.PlaySound("comms/enemyairsupport2.wav")
        end)
    end

end)

net.Receive("playerplanereport",function()
    local IsPlayerInPlane = net.ReadBool()

    [[--hook.Add("HUDPaint", "MyOverlay", function()
        if IsPlayerInPlane == true then 
            surface.SetMaterial(material)
            surface.SetDrawColor(255, 255, 255, 255) -- white color
            surface.DrawTexturedRect(1,5,5,5)
        end
    end)--]]


end)


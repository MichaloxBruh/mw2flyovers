
AddCSLuaFile()


ENT.Base             = "base_nextbot"
ENT.Spawnable = true
--ENT.PhysgunDisabled = true -- ENABLE THIS ON RELEASE !!!!!!!!!!
ENT.PrintName = "DEVAC130"
ENT.Purpose = ""


if CLIENT then
    language.Add("npc_helicamera", ENT.PrintName)  -- best thing ever
end

function ENT:Initialize()
    self:SetModel("models/props_c17/oildrum001.mdl ")
    self:SetPos(self:GetPos() + 0,0,304)

    if ( SERVER ) then 
        self:SetMaxHealth(50)
        self:SetHealth(50)
        self:DrawShadow(true) 
        self:SetUseType(SIMPLE_USE)
    end
end



function ENT:RunBehaviour()
    while (true) do 
 
        self.loco:SetDesiredSpeed( 30 )
        self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 200 )     -- this took me a bit
    
    
        
       
        local pos = self:FindSpot( "random", { type = 'hiding', radius = 5000 } )
        
        if (pos) then 
            self.loco:SetDesiredSpeed( 30 ) -- run speed
            self:MoveToPos( pos )
        end
    
        coroutine.yield()
    
    end

end




function ENT:OnKilled( dmginfo )

    hook.Call( "OnNPCKilled", GAMEMODE , self , dmginfo:GetAttacker() , dmginfo:GetInflictor() )
    self:Remove() 
    
    
    local explosion = ents.Create( "env_explosion" ) -- Explosion time!
					explosion:SetPos( self:GetPos() ) 
					explosion:Spawn() 
					explosion:SetKeyValue( "iMagnitude", "50" ) 
					explosion:Fire( "Explode", 0, 0 ) 
    
end

function ENT:Use( activator )
    if CHIPSCOOLDOWN == 0 then 
        activator:ChatPrint("You pet kerfuś, kerfuś offers you some chips!")
        local healthkit = ents.Create( "ent_chips" )
        healthkit:SetModel( "models/crisps/paprika.mdl" )
        healthkit:SetPos( (self:GetPos() + activator:GetPos())	/ 2) 
        healthkit:Spawn()
        CHIPSCOOLDOWN = 1 
    
        timer.Simple(0, function()   -- this is the worst way to do this
            timercount = "6"
        end)

        timer.Simple(1, function()
            timercount = "5"
        end)

        timer.Simple(2, function()
            timercount = "4"
        end)

        timer.Simple(3, function()
            timercount = "3"
        end)

        timer.Simple(4, function()
            timercount = "2"
        end)

        timer.Simple(5, function()
            timercount = "1"
        end)

        timer.Simple(6, function()
            CHIPSCOOLDOWN = 0
        end)


    elseif CHIPSCOOLDOWN == 1 then 
        activator:ChatPrint("You must wait " .. timercount ..  " seconds before petting kerfuś again.")
    end
end 



list.Set( "NPC", "npc_kerfus", {     -- you have no idea how much this took me to work for some reason
	Name = "Kerfuś",
	Class = "npc_kerfus",
	Category = "Kerfuś"
} )
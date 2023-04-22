local ISSAFETYNADEPUT = 0
local LOOPSN = 0

SWEP.PrintName = "Air Support Radio"
SWEP.Author = "Michalox"
SWEP.Instructions = "Left mouse to call Air Support"

SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.UseHands = true

SWEP.Primary.ClipSize		= 3
SWEP.Primary.DefaultClip	= 4
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "weapon_frag"

SWEP.Secondary.ClipSize		= 1
SWEP.Secondary.DefaultClip	= 1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Weight			= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot			= 5
SWEP.SlotPos			= 3
SWEP.DrawAmmo			= true
SWEP.DrawCrosshair		= true

SWEP.ViewModel			= "models/weapons/c_slam.mdl"
SWEP.WorldModel			= "models/weapons/w_slam.mdl"

SWEP.ShootSound = Sound( "friends/friend_online.wav" )






function SWEP:PrimaryAttack()
    if ISSAFETYNADEPUT == 0 then    
        local owner = self:GetOwner()
        local ownerpos = owner:GetPos()
        local slam = ents.Create( "gmod_button" )
        
        slam:SetModel( "models/dav0r/buttons/button.mdl" )
        slam:SetPos( Vector( 0, 0, 0 ) )
        slam:Spawn()
        sound.Play("passtime/ball_catch.wav", ownerpos, 75,100,1)
        ISSAFETYNADEPUT = 1 
        timer.Simple(2,function()
            ISSAFETYNADEPUT = 0
        end)
    end 
end


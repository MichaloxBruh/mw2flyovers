AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")


function ENT:Initialize()

	self:SetPos(self:GetPos() + 0,0,30)
	self:SetModel("models/sage267/radio.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	--local phys = self:GetPhysicsObject()

	--if phys:IsValid() then
	
		--phys:Wake()

	--end

end	

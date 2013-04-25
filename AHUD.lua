--AHUD
--Godofdrakes

require "math"
require "string"
require "table"
require "lib/lib_Slash"
require "lib/lib_InterfaceOptions"
require "lib/lib_Colors"
require "./lib/lib_LKObjects"

--Variables
	local MESSAGE		= {}
	local HUD_OBJECTS	= {}
	local HUD			= {}
	HUD_OBJECTS.HEALTH	= {
		{	Name 		= "Health_Attach",
			Id			= "Anchor",
			Scale		= 0.125,
			Translation = {x=0.10,y=-0.10,z=0.10},
			Rotation 	= {axis={x=0,y=0,z=1},angle=180},
			BindTo		= "player",
			Hardpoint	= "FX_Back",
		},

		{	Name 		= "Anchor_Health",
			Id			= "Anchor",
			Scale		= 1,
			Translation	= {x=0,y=0,z=0},
			Rotation 	= {axis={x=1,y=0,z=0},angle=-90},
			Anchor		= "Health_Attach",
		},

		{
			Name		= "Text",
			Id			= "TrackingFrame",
			CullAlpha	= 0,
			SortOrder	= 11,
			Rotation 	= {axis={x=1,y=1,z=0},angle=180},
			Tint 		= Component.LookupColor("team"),
			Widget		= [[<Group dimensions="center-x:50%; center-y:50%; height:240; width:240" style="alpha:0.9">
								<Text name="text" dimensions="dock:fill" style="font:Wide_15B; halign:center; valign:center; color:FFFFFF; scaleX:1; scaleY:1" key="{PLAYER NAME}"/>
							</Group>]],
			Anchor		= "Anchor_Health",
		},}
	HUD_OBJECTS.AMMO	= {
		{	Name 		= "Ammo_Attach",
			Id			= "Anchor",
			Scale		= 0.15,
			Translation = {x=0.215,y=0,z=0.15},
			Rotation 	= {axis={x=1,y=0,z=0},angle=90},
			BindTo		= "player",
			Hardpoint	= "FX_RWrist",
		},

		{	Name 		= "Anchor_Ammo",
			Id			= "Anchor",
			Scale		= 1,
			Translation	= {x=0,y=0,z=0},
			Rotation 	= {axis={x=1,y=0,z=0},angle=-90},
			Anchor		= "Ammo_Attach",
		},

		{
			Name		= "Text",
			Id			= "TrackingFrame",
			CullAlpha	= 0,
			SortOrder	= 11,
			Rotation 	= {axis={x=1,y=0,z=0},angle=0},
			Tint 		= Component.LookupColor("team"),
			Widget		= [[<Group dimensions="center-x:50%; center-y:50%; height:240; width:240" style="alpha:0.9">
								<Text name="text" dimensions="dock:fill" style="font:Wide_15B; halign:center; valign:center; color:FFFFFF; scaleX:1; scaleY:1" key="{AMMO%}"/>
							</Group>]],
			Anchor		= "Anchor_Ammo",
		},}
	HUD_OBJECTS.ENERGY	= {
		{	Name 		= "Energy_Attach",
			Id			= "Anchor",
			Scale		= 0.25,
			Translation = {x=0.20,y=-0.10,z=0.10},
			Rotation 	= {axis={x=0,y=0,z=1},angle=90},
			BindTo		= "player",
			Hardpoint	= "FX_Back",
		},

		{	Name 		= "Anchor_Energy",
			Id			= "Anchor",
			Scale		= 1,
			Translation	= {x=0,y=0,z=0},
			Rotation 	= {axis={x=1,y=0,z=0},angle=-90},
			Anchor		= "Energy_Attach",
		},

		{
			Name		= "Text",
			Id			= "TrackingFrame",
			CullAlpha	= 0,
			SortOrder	= 11,
			Rotation 	= {axis={x=1,y=0,z=0},angle=90},
			Tint 		= Component.LookupColor("team"),
			Widget		= [[<Group dimensions="center-x:50%; center-y:50%; height:240; width:240" style="alpha:0.9">
								<Text name="text" dimensions="dock:fill" style="font:Wide_15B; halign:center; valign:center; color:FFFFFF; scaleX:1; scaleY:1" key="{Energy%}"/>
							</Group>]],
			Anchor		= "Anchor_Energy",
		},}
	HUD_OBJECTS.ASTAT	= {
		{	Name 		= "ASTAT_Attach",
			Id			= "Anchor",
			Scale		= 0.125,
			Translation = {x=0.20,y=-0.10,z=0.10},
			Rotation 	= {axis={x=0,y=0,z=1},angle=90},
			BindTo		= "player",
			Hardpoint	= "FX_Back",
		},

		{	Name 		= "Anchor_Kills",
			Id			= "Anchor",
			Scale		= 1,
			Translation	= {x=0,y=0,z=0},
			Rotation 	= {axis={x=1,y=0,z=0},angle=0},
			Anchor		= "ASTAT_Attach",
		},

		{	Name 		= "Anchor_Damage",
			Id			= "Anchor",
			Scale		= 1,
			Translation	= {x=0,y=0,z=0},
			Rotation 	= {axis={x=1,y=0,z=0},angle=0},
			Anchor		= "ASTAT_Attach",
		},

		{	Name 		= "Anchor_Downed",
			Id			= "Anchor",
			Scale		= 1,
			Translation	= {x=0,y=0,z=0},
			Rotation 	= {axis={x=1,y=0,z=0},angle=0},
			Anchor		= "ASTAT_Attach",
		},

		{	Name 		= "Anchor_Deaths",
			Id			= "Anchor",
			Scale		= 1,
			Translation	= {x=0,y=0,z=0},
			Rotation 	= {axis={x=1,y=0,z=0},angle=0},
			Anchor		= "ASTAT_Attach",
		},

		{	Name 		= "Anchor_Heal",
			Id			= "Anchor",
			Scale		= 1,
			Translation	= {x=0,y=0,z=0},
			Rotation 	= {axis={x=1,y=0,z=0},angle=0},
			Anchor		= "ASTAT_Attach",
		},

		{	Name		= "Kills",
			Id			= "TrackingFrame",
			CullAlpha	= 0,
			SortOrder	= 11,
			Rotation 	= {axis={x=1,y=1,z=0},angle=0},
			Tint 		= Component.LookupColor("team"),
			Widget		= [[<Group dimensions="center-x:50%; center-y:50%; height:240; width:240" style="alpha:0.9">
								<Text name="text" dimensions="dock:fill" style="font:Wide_15B; halign:right; valign:center; color:FFFFFF; scaleX:1; scaleY:1" key="{ASTAT_KILLS%}"/>
							</Group>]],
			Anchor		= "Anchor_Kills",
		},

		{	Name		= "Damage",
			Id			= "TrackingFrame",
			CullAlpha	= 0,
			SortOrder	= 11,
			Rotation 	= {axis={x=1,y=1,z=0},angle=0},
			Tint 		= Component.LookupColor("team"),
			Widget		= [[<Group dimensions="center-x:50%; center-y:50%; height:240; width:240" style="alpha:0.9">
								<Text name="text" dimensions="dock:fill" style="font:Wide_15B; halign:right; valign:center; color:FFFFFF; scaleX:1; scaleY:1" key="{ASTAT_DAMAGE%}"/>
							</Group>]],
			Anchor		= "Anchor_Damage",
		},

		{	Name		= "Downed",
			Id			= "TrackingFrame",
			CullAlpha	= 0,
			SortOrder	= 11,
			Rotation 	= {axis={x=1,y=1,z=0},angle=0},
			Tint 		= Component.LookupColor("team"),
			Widget		= [[<Group dimensions="center-x:50%; center-y:50%; height:240; width:240" style="alpha:0.9">
								<Text name="text" dimensions="dock:fill" style="font:Wide_15B; halign:right; valign:center; color:FFFFFF; scaleX:1; scaleY:1" key="{ASTAT_DOWNED%}"/>
							</Group>]],
			Anchor		= "Anchor_Downed",
		},

		{	Name		= "Deaths",
			Id			= "TrackingFrame",
			CullAlpha	= 0,
			SortOrder	= 11,
			Rotation 	= {axis={x=1,y=1,z=0},angle=0},
			Tint 		= Component.LookupColor("team"),
			Widget		= [[<Group dimensions="center-x:50%; center-y:50%; height:240; width:240" style="alpha:0.9">
								<Text name="text" dimensions="dock:fill" style="font:Wide_15B; halign:right; valign:center; color:FFFFFF; scaleX:1; scaleY:1" key="{ASTAT_DEATHS%}"/>
							</Group>]],
			Anchor		= "Anchor_Deaths",
		},

		{	Name		= "Heal",
			Id			= "TrackingFrame",
			CullAlpha	= 0,
			SortOrder	= 11,
			Rotation 	= {axis={x=1,y=1,z=0},angle=0},
			Tint 		= Component.LookupColor("team"),
			Widget		= [[<Group dimensions="center-x:50%; center-y:50%; height:240; width:240" style="alpha:0.9">
								<Text name="text" dimensions="dock:fill" style="font:Wide_15B; halign:right; valign:center; color:FFFFFF; scaleX:1; scaleY:1" key="{ASTAT_HEAL%}"/>
							</Group>]],
			Anchor		= "Anchor_Heal",
		},}

	local AMMO		= 0
	local CLIP		= 0
	local AMMO_PCT	= 0

	local HEALTH_PCT		= 1.00
	local HEALTH_CURRENT	= 0
	local HEALTH_MAX		= 0

	local ENERGY_PCT		= 1.00
	local ENERGY_CURRENT	= 0
	local ENERGY_MAX		= 0

	local RED	= Colors.Create("FF0000")
	local GREEN	= Colors.Create("00FF00")
	local BLUE	= Colors.Create("0000FF")
	BLUE.a 		= 0.5

	local COLORS	= {
		AMMO = nil,
		HEALTH = nil,
		ENERGY = nil,}

	local ASTAT		= false
	local KILLS		= 0
	local DAMAGE	= 0
	local DOWNED	= 0
	local DEATHS	= 0
	local HEAL		= 0
	local REPAIR	= 0

	local ARCHTYPE = ""

	local SQUAD = {
		ROSTER = nil, --Squad.GetRoster()
		LEADER = nil, --Squad.GetLeader()
		VITALS = nil, --Squad.GetVitals()
	}

--Interface Options
	InterfaceOptions.NotifyOnLoaded(true)

	function OnComponentLoad()
		log("Loading")
		InterfaceOptions.SetCallbackFunc(function(id, val)
			OnMessage({type=id, data=val})
		end, "AHUD")
		log("Loding completed")
	end

	function OnPlayerReady(args)
	end

	function OnMessage(args)
		local option = args.type
		local message = args.data
		if (option == "__LOADED") then
			log("\n\n"..tostring(Game.GetTargetHardpoints(Player.GetTargetId())).."\n\n")
			LoadHUD()
			FrameChange()
			return nil
		end
		if not (MESSAGE[option]) then
			warn("Unknown message: " .. option)
			return nil
		end
		MESSAGE[option](message)
		SetInterfaceOptions()
	end

	function SetInterfaceOptions()
	end

--Event Functions
	function LoadHUD()
		if (not HUD.HEALTH) then HUD.HEALTH = LKObjects.Create(HUD_OBJECTS.HEALTH) end
		HealthUpdate()

		if (not HUD.AMMO) then HUD.AMMO = LKObjects.Create(HUD_OBJECTS.AMMO) end
		WeaponUpdate()

		if (not HUD.ENERGY) then HUD.ENERGY = LKObjects.Create(HUD_OBJECTS.ENERGY) end
		EnergyUpdate()
	end

	function AstatSaved(args)
		ASTAT = true
		if (not HUD.ASTAT) then HUD.ASTAT = LKObjects.Create(HUD_OBJECTS.ASTAT) end
		KILLS = args.KILLS
		DAMAGE = args.DAMAGE
		DOWNED = args.DOWNED
		DEATHS = args.DEATHS
		HEAL = -args.HEAL
		REPAIR = -args.REPAIR
		KillsUpdate()
		DamageUpdate()
		DownedUpdate()
		DeathsUpdate()
		HealUpdate()
		FrameChange()
	end

	function FrameChange(args)
		ARCHTYPE = Player.GetCurrentLoadout().archtype

		if (ARCHTYPE == "bunker") then
			--HUD.HEALTH.Health_Attach:SetParam("Scale", 0.125)
			HUD.HEALTH.Health_Attach:SetParam("Translation", {x=0.10,y=-0.10,z=0.10})
			HUD.HEALTH.Health_Attach:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=180})
			--HUD.HEALTH.Anchor_Health:SetParam("Scale", 1)
			HUD.HEALTH.Anchor_Health:SetParam("Translation", {x=0,y=0,z=0})
			HUD.HEALTH.Anchor_Health:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=-90})
			HUD.HEALTH.Text:SetParam("Rotation", {axis={x=1,y=1,z=0},angle=180})

			--HUD.AMMO.Ammo_Attach:SetParam("Scale", 0.15)
			HUD.AMMO.Ammo_Attach:SetParam("Translation", {x=0.315,y=0,z=0.15})
			HUD.AMMO.Ammo_Attach:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=90})
			--HUD.AMMO.Anchor_Ammo:SetParam("Scale", 1)
			HUD.AMMO.Anchor_Ammo:SetParam("Translation", {x=0,y=0,z=0})
			HUD.AMMO.Anchor_Ammo:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=-90})
			HUD.AMMO.Text:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})

			--HUD.ENERGY.Energy_Attach:SetParam("Scale", 0.25)
			HUD.ENERGY.Energy_Attach:SetParam("Translation", {x=0.20,y=-0.10,z=0.10})
			HUD.ENERGY.Energy_Attach:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=90})
			--HUD.ENERGY.Anchor_Energy:SetParam("Scale", 1)
			HUD.ENERGY.Anchor_Energy:SetParam("Translation", {x=0,y=0,z=0})
			HUD.ENERGY.Anchor_Energy:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=-45})
			HUD.ENERGY.Text:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=90})

			if (HUD.ASTAT) then
				--HUD.ASTAT.ASTAT_Attach:SetParam("Scale", 0.25)
				HUD.ASTAT.ASTAT_Attach:SetParam("Translation", {x=-0.15,y=-0.10,z=0.10})
				HUD.ASTAT.ASTAT_Attach:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=90})
				--HUD.ASTAT.Anchor_Kills:SetParam("Scale", 1)
				HUD.ASTAT.Anchor_Kills:SetParam("Translation", {x=-0.2,y=0,z=1})
				HUD.ASTAT.Anchor_Kills:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
				--HUD.ASTAT.Anchor_Damage:SetParam("Scale", 1)
				HUD.ASTAT.Anchor_Damage:SetParam("Translation", {x=-0.2,y=0,z=0.7})
				HUD.ASTAT.Anchor_Damage:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
				--HUD.ASTAT.Anchor_Downed:SetParam("Scale", 1)
				HUD.ASTAT.Anchor_Downed:SetParam("Translation", {x=-0.2,y=0,z=0.4})
				HUD.ASTAT.Anchor_Downed:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
				--HUD.ASTAT.Anchor_Deaths:SetParam("Scale", 1)
				HUD.ASTAT.Anchor_Deaths:SetParam("Translation", {x=-0.2,y=0,z=0.1})
				HUD.ASTAT.Anchor_Deaths:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
				--HUD.ASTAT.Anchor_Heal:SetParam("Scale", 1)
				HUD.ASTAT.Anchor_Heal:SetParam("Translation", {x=-0.2,y=0,z=-0.2})
				HUD.ASTAT.Anchor_Heal:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
				HUD.ASTAT.Kills:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
				HUD.ASTAT.Damage:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
				HUD.ASTAT.Downed:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
				HUD.ASTAT.Deaths:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
				HUD.ASTAT.Heal:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
			end
		elseif (ARCHTYPE == "medic") then
			--HUD.HEALTH.Health_Attach:SetParam("Scale", 0.125)
			HUD.HEALTH.Health_Attach:SetParam("Translation", {x=0.40,y=-0.10,z=-0.10})
			HUD.HEALTH.Health_Attach:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=90})
			--HUD.HEALTH.Anchor_Health:SetParam("Scale", 1)
			HUD.HEALTH.Anchor_Health:SetParam("Translation", {x=0,y=0,z=0})
			HUD.HEALTH.Anchor_Health:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=135})
			HUD.HEALTH.Text:SetParam("Rotation", {axis={x=0,y=1,z=0},angle=0})

			--HUD.AMMO.Ammo_Attach:SetParam("Scale", 0.15)
			HUD.AMMO.Ammo_Attach:SetParam("Translation", {x=-0.2,y=0.6,z=0.3})
			HUD.AMMO.Ammo_Attach:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=0})
			--HUD.AMMO.Anchor_Ammo:SetParam("Scale", 1)
			HUD.AMMO.Anchor_Ammo:SetParam("Translation", {x=0,y=0,z=0})
			HUD.AMMO.Anchor_Ammo:SetParam("Rotation", {axis={x=0,y=1,z=0},angle=90})
			HUD.AMMO.Text:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})

			--HUD.ENERGY.Energy_Attach:SetParam("Scale", 0.25)
			HUD.ENERGY.Energy_Attach:SetParam("Translation", {x=0.40,y=-0.10,z=0})
			HUD.ENERGY.Energy_Attach:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=90})
			--HUD.ENERGY.Anchor_Energy:SetParam("Scale", 1)
			HUD.ENERGY.Anchor_Energy:SetParam("Translation", {x=0,y=0,z=0})
			HUD.ENERGY.Anchor_Energy:SetParam("Rotation", {axis={x=0,y=1,z=0},angle=0})
			HUD.ENERGY.Text:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=90})

			if (HUD.ASTAT) then
				--HUD.ASTAT.ASTAT_Attach:SetParam("Scale", 0.25)
				HUD.ASTAT.ASTAT_Attach:SetParam("Translation", {x=0.3,y=0.10,z=0.20})
				HUD.ASTAT.ASTAT_Attach:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=90})
				--HUD.ASTAT.Anchor_Kills:SetParam("Scale", 1)
				HUD.ASTAT.Anchor_Kills:SetParam("Translation", {x=-0.2,y=0,z=1})
				HUD.ASTAT.Anchor_Kills:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=-45})
				--HUD.ASTAT.Anchor_Damage:SetParam("Scale", 1)
				HUD.ASTAT.Anchor_Damage:SetParam("Translation", {x=-0.2,y=0,z=0.7})
				HUD.ASTAT.Anchor_Damage:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=-45})
				--HUD.ASTAT.Anchor_Downed:SetParam("Scale", 1)
				HUD.ASTAT.Anchor_Downed:SetParam("Translation", {x=-0.2,y=0,z=0.4})
				HUD.ASTAT.Anchor_Downed:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=-45})
				--HUD.ASTAT.Anchor_Deaths:SetParam("Scale", 1)
				HUD.ASTAT.Anchor_Deaths:SetParam("Translation", {x=-0.2,y=0,z=0.1})
				HUD.ASTAT.Anchor_Deaths:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=-45})
				--HUD.ASTAT.Anchor_Heal:SetParam("Scale", 1)
				HUD.ASTAT.Anchor_Heal:SetParam("Translation", {x=-0.2,y=0,z=-0.2})
				HUD.ASTAT.Anchor_Heal:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=-45})
				HUD.ASTAT.Kills:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
				HUD.ASTAT.Damage:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
				HUD.ASTAT.Downed:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
				HUD.ASTAT.Deaths:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
				HUD.ASTAT.Heal:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
			end
		elseif (ARCHTYPE == "recon") then
			--HUD.HEALTH.Health_Attach:SetParam("Scale", 0.125)
			HUD.HEALTH.Health_Attach:SetParam("Translation", {x=0.40,y=-0.10,z=-0.10})
			HUD.HEALTH.Health_Attach:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=90})
			--HUD.HEALTH.Anchor_Health:SetParam("Scale", 1)
			HUD.HEALTH.Anchor_Health:SetParam("Translation", {x=0,y=0,z=0})
			HUD.HEALTH.Anchor_Health:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=135})
			HUD.HEALTH.Text:SetParam("Rotation", {axis={x=0,y=1,z=0},angle=0})

			--HUD.AMMO.Ammo_Attach:SetParam("Scale", 0.15)
			HUD.AMMO.Ammo_Attach:SetParam("Translation", {x=-0.2,y=0.6,z=0.3})
			HUD.AMMO.Ammo_Attach:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=0})
			--HUD.AMMO.Anchor_Ammo:SetParam("Scale", 1)
			HUD.AMMO.Anchor_Ammo:SetParam("Translation", {x=0,y=0,z=0})
			HUD.AMMO.Anchor_Ammo:SetParam("Rotation", {axis={x=0,y=1,z=0},angle=90})
			HUD.AMMO.Text:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})

			--HUD.ENERGY.Energy_Attach:SetParam("Scale", 0.25)
			HUD.ENERGY.Energy_Attach:SetParam("Translation", {x=0.40,y=-0.10,z=0})
			HUD.ENERGY.Energy_Attach:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=90})
			--HUD.ENERGY.Anchor_Energy:SetParam("Scale", 1)
			HUD.ENERGY.Anchor_Energy:SetParam("Translation", {x=0,y=0,z=0})
			HUD.ENERGY.Anchor_Energy:SetParam("Rotation", {axis={x=0,y=1,z=0},angle=0})
			HUD.ENERGY.Text:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=90})

			if (HUD.ASTAT) then
				--HUD.ASTAT.ASTAT_Attach:SetParam("Scale", 0.25)
				HUD.ASTAT.ASTAT_Attach:SetParam("Translation", {x=0.3,y=0.00,z=0.20})
				HUD.ASTAT.ASTAT_Attach:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=90})
				--HUD.ASTAT.Anchor_Kills:SetParam("Scale", 1)
				HUD.ASTAT.Anchor_Kills:SetParam("Translation", {x=-0.2,y=0,z=1})
				HUD.ASTAT.Anchor_Kills:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=-45})
				--HUD.ASTAT.Anchor_Damage:SetParam("Scale", 1)
				HUD.ASTAT.Anchor_Damage:SetParam("Translation", {x=-0.2,y=0,z=0.7})
				HUD.ASTAT.Anchor_Damage:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=-45})
				--HUD.ASTAT.Anchor_Downed:SetParam("Scale", 1)
				HUD.ASTAT.Anchor_Downed:SetParam("Translation", {x=-0.2,y=0,z=0.4})
				HUD.ASTAT.Anchor_Downed:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=-45})
				--HUD.ASTAT.Anchor_Deaths:SetParam("Scale", 1)
				HUD.ASTAT.Anchor_Deaths:SetParam("Translation", {x=-0.2,y=0,z=0.1})
				HUD.ASTAT.Anchor_Deaths:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=-45})
				--HUD.ASTAT.Anchor_Heal:SetParam("Scale", 1)
				HUD.ASTAT.Anchor_Heal:SetParam("Translation", {x=-0.2,y=0,z=-0.2})
				HUD.ASTAT.Anchor_Heal:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=-45})
				HUD.ASTAT.Kills:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
				HUD.ASTAT.Damage:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
				HUD.ASTAT.Downed:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
				HUD.ASTAT.Deaths:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
				HUD.ASTAT.Heal:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
			end
		elseif (ARCHTYPE == "guardian") then
			--HUD.HEALTH.Health_Attach:SetParam("Scale", 0.125)
			HUD.HEALTH.Health_Attach:SetParam("Translation", {x=0.40,y=-0.10,z=-0.10})
			HUD.HEALTH.Health_Attach:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=90})
			--HUD.HEALTH.Anchor_Health:SetParam("Scale", 1)
			HUD.HEALTH.Anchor_Health:SetParam("Translation", {x=0,y=0,z=0})
			HUD.HEALTH.Anchor_Health:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=135})
			HUD.HEALTH.Text:SetParam("Rotation", {axis={x=0,y=1,z=0},angle=0})

			--HUD.AMMO.Ammo_Attach:SetParam("Scale", 0.15)
			HUD.AMMO.Ammo_Attach:SetParam("Translation", {x=-0.2,y=0.6,z=0.3})
			HUD.AMMO.Ammo_Attach:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=0})
			--HUD.AMMO.Anchor_Ammo:SetParam("Scale", 1)
			HUD.AMMO.Anchor_Ammo:SetParam("Translation", {x=0,y=0,z=0})
			HUD.AMMO.Anchor_Ammo:SetParam("Rotation", {axis={x=0,y=1,z=0},angle=90})
			HUD.AMMO.Text:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})

			--HUD.ENERGY.Energy_Attach:SetParam("Scale", 0.25)
			HUD.ENERGY.Energy_Attach:SetParam("Translation", {x=0.40,y=-0.10,z=0})
			HUD.ENERGY.Energy_Attach:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=90})
			--HUD.ENERGY.Anchor_Energy:SetParam("Scale", 1)
			HUD.ENERGY.Anchor_Energy:SetParam("Translation", {x=0,y=0,z=0})
			HUD.ENERGY.Anchor_Energy:SetParam("Rotation", {axis={x=0,y=1,z=0},angle=0})
			HUD.ENERGY.Text:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=90})

			if (HUD.ASTAT) then
				--HUD.ASTAT.ASTAT_Attach:SetParam("Scale", 0.25)
				HUD.ASTAT.ASTAT_Attach:SetParam("Translation", {x=0.4,y=0.00,z=0.20})
				HUD.ASTAT.ASTAT_Attach:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=90})
				--HUD.ASTAT.Anchor_Kills:SetParam("Scale", 1)
				HUD.ASTAT.Anchor_Kills:SetParam("Translation", {x=-0.2,y=0,z=1})
				HUD.ASTAT.Anchor_Kills:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=-45})
				--HUD.ASTAT.Anchor_Damage:SetParam("Scale", 1)
				HUD.ASTAT.Anchor_Damage:SetParam("Translation", {x=-0.2,y=0,z=0.7})
				HUD.ASTAT.Anchor_Damage:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=-45})
				--HUD.ASTAT.Anchor_Downed:SetParam("Scale", 1)
				HUD.ASTAT.Anchor_Downed:SetParam("Translation", {x=-0.2,y=0,z=0.4})
				HUD.ASTAT.Anchor_Downed:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=-45})
				--HUD.ASTAT.Anchor_Deaths:SetParam("Scale", 1)
				HUD.ASTAT.Anchor_Deaths:SetParam("Translation", {x=-0.2,y=0,z=0.1})
				HUD.ASTAT.Anchor_Deaths:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=-45})
				--HUD.ASTAT.Anchor_Heal:SetParam("Scale", 1)
				HUD.ASTAT.Anchor_Heal:SetParam("Translation", {x=-0.2,y=0,z=-0.2})
				HUD.ASTAT.Anchor_Heal:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=-45})
				HUD.ASTAT.Kills:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
				HUD.ASTAT.Damage:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
				HUD.ASTAT.Downed:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
				HUD.ASTAT.Deaths:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
				HUD.ASTAT.Heal:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
			end
		elseif (ARCHTYPE == "berzerker") then
			--HUD.HEALTH.Health_Attach:SetParam("Scale", 0.125)
			HUD.HEALTH.Health_Attach:SetParam("Translation", {x=0.40,y=-0.10,z=-0.10})
			HUD.HEALTH.Health_Attach:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=90})
			--HUD.HEALTH.Anchor_Health:SetParam("Scale", 1)
			HUD.HEALTH.Anchor_Health:SetParam("Translation", {x=0,y=0,z=0})
			HUD.HEALTH.Anchor_Health:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=135})
			HUD.HEALTH.Text:SetParam("Rotation", {axis={x=0,y=1,z=0},angle=0})

			--HUD.AMMO.Ammo_Attach:SetParam("Scale", 0.15)
			HUD.AMMO.Ammo_Attach:SetParam("Translation", {x=-0.2,y=0.6,z=0.3})
			HUD.AMMO.Ammo_Attach:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=0})
			--HUD.AMMO.Anchor_Ammo:SetParam("Scale", 1)
			HUD.AMMO.Anchor_Ammo:SetParam("Translation", {x=0,y=0,z=0})
			HUD.AMMO.Anchor_Ammo:SetParam("Rotation", {axis={x=0,y=1,z=0},angle=90})
			HUD.AMMO.Text:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})

			--HUD.ENERGY.Energy_Attach:SetParam("Scale", 0.25)
			HUD.ENERGY.Energy_Attach:SetParam("Translation", {x=0.40,y=-0.10,z=0})
			HUD.ENERGY.Energy_Attach:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=90})
			--HUD.ENERGY.Anchor_Energy:SetParam("Scale", 1)
			HUD.ENERGY.Anchor_Energy:SetParam("Translation", {x=0,y=0,z=0})
			HUD.ENERGY.Anchor_Energy:SetParam("Rotation", {axis={x=0,y=1,z=0},angle=0})
			HUD.ENERGY.Text:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=90})

			if (HUD.ASTAT) then
				--HUD.ASTAT.ASTAT_Attach:SetParam("Scale", 0.25)
				HUD.ASTAT.ASTAT_Attach:SetParam("Translation", {x=0.5,y=0.00,z=0.20})
				HUD.ASTAT.ASTAT_Attach:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=90})
				--HUD.ASTAT.Anchor_Kills:SetParam("Scale", 1)
				HUD.ASTAT.Anchor_Kills:SetParam("Translation", {x=-0.2,y=0,z=1})
				HUD.ASTAT.Anchor_Kills:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=-45})
				--HUD.ASTAT.Anchor_Damage:SetParam("Scale", 1)
				HUD.ASTAT.Anchor_Damage:SetParam("Translation", {x=-0.2,y=0,z=0.7})
				HUD.ASTAT.Anchor_Damage:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=-45})
				--HUD.ASTAT.Anchor_Downed:SetParam("Scale", 1)
				HUD.ASTAT.Anchor_Downed:SetParam("Translation", {x=-0.2,y=0,z=0.4})
				HUD.ASTAT.Anchor_Downed:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=-45})
				--HUD.ASTAT.Anchor_Deaths:SetParam("Scale", 1)
				HUD.ASTAT.Anchor_Deaths:SetParam("Translation", {x=-0.2,y=0,z=0.1})
				HUD.ASTAT.Anchor_Deaths:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=-45})
				--HUD.ASTAT.Anchor_Heal:SetParam("Scale", 1)
				HUD.ASTAT.Anchor_Heal:SetParam("Translation", {x=-0.2,y=0,z=-0.2})
				HUD.ASTAT.Anchor_Heal:SetParam("Rotation", {axis={x=0,y=0,z=1},angle=-45})
				HUD.ASTAT.Kills:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
				HUD.ASTAT.Damage:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
				HUD.ASTAT.Downed:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
				HUD.ASTAT.Deaths:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
				HUD.ASTAT.Heal:SetParam("Rotation", {axis={x=1,y=0,z=0},angle=0})
			end
		end
	end

	function SprintChange(args)
		if (args.sprinting) then
			HUD.HEALTH.Text:GetChild("text"):Show()
			HUD.AMMO.Text:GetChild("text"):Show()
			HUD.ENERGY.Text:GetChild("text"):Show()
			HUD.ASTAT.Heal:GetChild("text"):Show()
			HUD.ASTAT.Damage:GetChild("text"):Show()
			HUD.ASTAT.Downed:GetChild("text"):Show()
			HUD.ASTAT.Deaths:GetChild("text"):Show()
			if (ARCHTYPE == "bunker" or ARCHTYPE == "medic") then
				HUD.ASTAT.Heal:GetChild("text"):Show()
			end
		else
			HUD.HEALTH.Text:GetChild("text"):Hide()
			HUD.AMMO.Text:GetChild("text"):Hide()
			HUD.ENERGY.Text:GetChild("text"):Hide()
			HUD.ASTAT.Heal:GetChild("text"):Hide()
			HUD.ASTAT.Damage:GetChild("text"):Hide()
			HUD.ASTAT.Downed:GetChild("text"):Hide()
			HUD.ASTAT.Deaths:GetChild("text"):Hide()
			HUD.ASTAT.Heal:GetChild("text"):Hide()
		end
	end

--HUD Functions
	--Player
		function WeaponUpdate(args)
			local weaponStates = Player.GetWeaponState(true)
			AMMO = weaponStates.Ammo
			CLIP = weaponStates.Clip
			AMMO_PCT = round(CLIP/Player.GetWeaponInfo().ClipSize, 4)
			COLORS.AMMO = Colors.Mix(RED, GREEN, AMMO_PCT)
			COLORS.AMMO.a = limit(math.abs(AMMO_PCT-1), 0.50, 1)

			HUD.AMMO.Text:GetChild("text"):SetText(tostring(CLIP).."/"..tostring(AMMO))
			HUD.AMMO.Text:GetChild("text"):SetTextColor(COLORS.AMMO)
		end

		function HealthUpdate(args)
			local vitals = Player.GetLifeInfo()
			HEALTH_CURRENT = vitals.Health
			HEALTH_MAX = vitals.MaxHealth
			HEALTH_PCT = round(HEALTH_CURRENT/HEALTH_MAX, 4)
			COLORS.HEALTH = Colors.Mix(RED, GREEN, HEALTH_PCT)
			COLORS.HEALTH.a = limit(math.abs(HEALTH_PCT-1), 0.50, 1)

			HUD.HEALTH.Text:GetChild("text"):SetText((HEALTH_PCT*100).."%".."|"..Player.GetInfo())
			HUD.HEALTH.Text:GetChild("text"):SetTextColor(COLORS.HEALTH)
		end

		function EnergyUpdate(args)
			ENERGY_CURRENT, ENERGY_MAX = Player.GetEnergy();
			ENERGY_PCT = round(ENERGY_CURRENT/ENERGY_MAX, 4)
			COLORS.ENERGY = Colors.Mix(RED, GREEN, ENERGY_PCT)
			COLORS.ENERGY.a = limit(math.abs(ENERGY_PCT-1), 0.50, 1)

			HUD.ENERGY.Text:GetChild("text"):SetText((ENERGY_PCT*100).."%")
			HUD.ENERGY.Text:GetChild("text"):SetTextColor(COLORS.ENERGY)
		end

		function KillsUpdate(args)
			if (KILLS >= 1000000000) then
				KILLS = round(KILLS/1000000000, 1)
				HUD.ASTAT.Kills:GetChild("text"):SetText(KILLS.."B:KILL")
			elseif (KILLS >= 1000000) then
				KILLS = round(KILLS/1000000, 1)
				HUD.ASTAT.Kills:GetChild("text"):SetText(KILLS.."M:KILL")
			elseif (KILLS >= 1000) then
				KILLS = round(KILLS/1000, 1)
				HUD.ASTAT.Kills:GetChild("text"):SetText(KILLS.."K:KILL")
			else
				HUD.ASTAT.Kills:GetChild("text"):SetText(KILLS..":KILL")
			end
			HUD.ASTAT.Kills:GetChild("text"):SetTextColor(BLUE)
		end

		function DamageUpdate(args)
			if (DAMAGE >= 1000000000) then
				DAMAGE = round(DAMAGE/1000000000, 1)
				HUD.ASTAT.Damage:GetChild("text"):SetText(DAMAGE.."B:DAMG")
			elseif (DAMAGE >= 1000000) then
				DAMAGE = round(DAMAGE/1000000, 1)
				HUD.ASTAT.Damage:GetChild("text"):SetText(DAMAGE.."M:DAMG")
			elseif (DAMAGE >= 1000) then
				DAMAGE = round(DAMAGE/1000, 1)
				HUD.ASTAT.Damage:GetChild("text"):SetText(DAMAGE.."K:DAMG")
			else
				HUD.ASTAT.Damage:GetChild("text"):SetText(DAMAGE..":DAMG")
			end
			HUD.ASTAT.Damage:GetChild("text"):SetTextColor(BLUE)
		end

		function DownedUpdate(args)
			if (DOWNED >= 1000000000) then
				DOWNED = round(DOWNED/1000000000, 1)
				HUD.ASTAT.Downed:GetChild("text"):SetText(DOWNED.."B:DOWN")
			elseif (DOWNED >= 1000000) then
				DOWNED = round(DOWNED/1000000, 1)
				HUD.ASTAT.Downed:GetChild("text"):SetText(DOWNED.."M:DOWN")
			elseif (DOWNED >= 1000) then
				DOWNED = round(DOWNED/1000, 1)
				HUD.ASTAT.Downed:GetChild("text"):SetText(DOWNED.."K:DOWN")
			else
				HUD.ASTAT.Downed:GetChild("text"):SetText(DOWNED..":DOWN")
			end
			HUD.ASTAT.Downed:GetChild("text"):SetTextColor(BLUE)
		end

		function DeathsUpdate(args)
			if (DEATHS >= 1000000000) then
				DEATHS = round(DEATHS/1000000000, 1)
				HUD.ASTAT.Deaths:GetChild("text"):SetText(DEATHS.."B:DEAD")
			elseif (DEATHS >= 1000000) then
				DEATHS = round(DEATHS/1000000, 1)
				HUD.ASTAT.Deaths:GetChild("text"):SetText(DEATHS.."M:DEAD")
			elseif (DEATHS >= 1000) then
				DEATHS = round(DEATHS/1000, 1)
				HUD.ASTAT.Deaths:GetChild("text"):SetText(DEATHS.."K:DEAD")
			else
				HUD.ASTAT.Deaths:GetChild("text"):SetText(DEATHS..":DEAD")
			end
			HUD.ASTAT.Deaths:GetChild("text"):SetTextColor(BLUE)
		end

		function HealUpdate(args)
			if (ARCHTYPE == "bunker") then
				if (REPAIR >= 1000000000) then
					REPAIR = round(REPAIR/1000000000, 1)
					HUD.ASTAT.Heal:GetChild("text"):SetText(REPAIR.."B:REPR")
				elseif (REPAIR >= 1000000) then
					REPAIR = round(REPAIR/1000000, 1)
					HUD.ASTAT.Heal:GetChild("text"):SetText(REPAIR.."M:REPR")
				elseif (REPAIR >= 1000) then
					REPAIR = round(REPAIR/1000, 1)
					HUD.ASTAT.Heal:GetChild("text"):SetText(REPAIR.."K:REPR")
				else
					HUD.ASTAT.Heal:GetChild("text"):SetText(REPAIR..":REPR")
				end
			elseif (ARCHTYPE == "medic") then
				if (HEAL >= 1000000000) then
					HEAL = round(HEAL/1000000000, 1)
					HUD.ASTAT.Heal:GetChild("text"):SetText(HEAL.."B:HEAL")
				elseif (HEAL >= 1000000) then
					HEAL = round(HEAL/1000000, 1)
					HUD.ASTAT.Heal:GetChild("text"):SetText(HEAL.."M:HEAL")
				elseif (HEAL >= 1000) then
					HEAL = round(HEAL/1000, 1)
					HUD.ASTAT.Heal:GetChild("text"):SetText(HEAL.."K:HEAL")
				else
					HUD.ASTAT.Heal:GetChild("text"):SetText(HEAL..":HEAL")
				end
			else
				HUD.ASTAT.Heal:GetChild("text"):Hide()
			end

			HUD.ASTAT.Heal:GetChild("text"):SetTextColor(BLUE)
		end

	--Squad
		function JoinSquad(args)
			Component.SaveSetting(normalize(args.event), args)
		end

		function LeaveSquad(args)
			Component.SaveSetting(normalize(args.event), args)
		end

		function UpdateSquad(args)
			Component.SaveSetting(normalize(args.event), args)
		end

--Other Functions
	function round(num, idp)
		local mult = 10^(idp or 0)
		return math.floor(num * mult + 0.5) / mult
	end

	function limit(number, min, max)
		if (number > max) then number = max end
		if (number < min) then number = min end
		return number
	end

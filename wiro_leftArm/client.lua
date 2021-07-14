local camtoggle = false
local cam = nil
local bekle = 1000
Citizen.CreateThread(function()
	while true do
		SetBlackout(false)
		Citizen.Wait(bekle)
		if IsPlayerFreeAiming(PlayerId())then
			bekle = 0
			if IsControlJustPressed(0, 246) then
				if camtoggle then
					SetCamActive(cam, false)
					RenderScriptCams(false, true, 500, true, true)
					camtoggle = false
				else
					cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
					AttachCamToPedBone(cam, PlayerPedId(), 31086, -0.3, -1.2, 0.1, GetEntityHeading(PlayerPedId()) + .0)
					SetCamAffectsAiming(cam, false)
					SetCamFov(cam, 50.0)
					RenderScriptCams(true, true, 500, true, true)
					camtoggle = true
					guncel()
				end
			end
		else
			bekle = 1000
			SetCamActive(cam, false)
			RenderScriptCams(false, true, 500, true, true)
			camtoggle = false
		end
	end
end)

function guncel()
	Citizen.CreateThread(function()
		while camtoggle do
			Citizen.Wait(1)
			SetCamRot(cam, GetEntityRotation(PlayerPedId(), 2), 2)
		end
	end)
end
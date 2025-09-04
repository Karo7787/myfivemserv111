function Camera(defPos, defPoint)
    local self = {}
    self.camInstance = nil
    self.create = function(pos, point, fov, offsets, entity)
        fov = fov or 75.0

        self.camInstance = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos, 0, 0, 0, fov * 1.0)
        if not self.camInstance then
            dbg.critical("Cannot create camera!")
            return
        end

        SetCamAffectsAiming(self.camInstance, false)
        if entity ~= nil and DoesEntityExist(entity) then
            PointCamAtEntity(self.camInstance, entity, offsets.x, offsets.y, offsets.z, true)
        elseif point ~= nil then
            PointCamAtCoord(self.camInstance, point.x, point.y, point.z)
        end
        dbg.debug("Setting cam active")
    end
    self.render = function()
        SetCamActive(self.camInstance, true)
        RenderScriptCams(true, false, 3000, true, true, 0)
    end
    self.renderInter = function(newCam, dur)
        SetCamActiveWithInterp(newCam, self.camInstance, dur, 1.0, 1.0)
        RenderScriptCams(true, false, 3000, true, true, 0)
    end
    self.stopRender = function()
        SetCamActive(self.camInstance, false)
        RenderScriptCams(false, false, 3000, true, false, 0)
    end
    self.destroy = function()
        if IsCamActive(self.camInstance) then
            SetCamActive(self.camInstance, false)
        end

        if DoesCamExist(self.camInstance) then
            DestroyCam(self.camInstance, false)
        end
    end
    self.setPos = function(pos)
        SetCamCoord(self.camInstance, pos.x, pos.y, pos.z)
    end
    self.getPos = function()
        return GetCamCoord(self.camInstance)
    end
    self.setRot = function(rot)
        SetCamRot(self.camInstance, rot.x, rot.y, rot.z, 2)
    end
    self.getRot = function()
        return GetCamRot(self.camInstance)
    end
    self.setPoint = function(point)
        PointCamAtCoord(self.camInstance, point.x, point.y, point.z)
    end
    return self
end

Config.Bodycam = {}

--@param Enabled: boolean [set to false to disable bodycam functionality]
Config.Bodycam.Enabled = true -- set to false to disable bodycam functionality

--@param Enabled: boolean
Config.Bodycam.JobRestricted = true -- if true player can only check bodycams from he's job, if false he can check bodycams from all jobs

Config.Bodycam.OnStartWatching = function() -- CLIENT SIDED FUNCTION
    -- DO SOMETHING
end

Config.Bodycam.OnStopWatching = function() -- CLIENT SIDED FUNCTION
    -- DO SOMETHING
end

Config.Bodycam.OnStartWatching_Server = function() -- SERVER SIDED FUNCTION
    -- DO SOMETHING
end
Config.Bodycam.OnStopWatching_Server = function() -- SERVER SIDED FUNCTION
    -- DO SOMETHING
end
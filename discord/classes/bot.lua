local netlib = require("discord.netlib")
local events = require("discord.libs.event")
local context = require("discord.classes.ctx")

-- TODO:
-- add payloads to netlib.ws_connect
-- to make an identifier for the bot

local bot = {}
bot.__index = bot

function bot.new(tbl)
    local self = setmetatable({}, bot)
    self._tbl = tbl
    self.token = tbl.Token
    self.intents = tbl.Intents
    self.prefix = tbl.Prefix
    
    self.OnReady = events.new()
    self.OnMessage = events.new()
    
    return self
end

function bot:Command(name, func)
    self.OnMessage:Connect(function(ctx)
        local msg = ctx.Content and ctx.Content.Text
        if not msg then return end
        
        local args = {}
        for gm in string.gmatch(msg, "%S+") do
            table.insert(args, gm)
        end
        
        if args[1] == (self.Prefix .. name) then
            local cmdArgs = {}
            for i = 2, #args do
                table.insert(cmdArgs, args[i])
            end
            
            func(ctx, table.unpack(cmdArgs))
        end
    end)
end

return bot
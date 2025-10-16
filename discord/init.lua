local netlib = require("discord.netlib") -- .so/.dll library
local event = require("discord.libs.event")
local bot = require("discord.classes.bot")

local bit32 = require("bit32")

local discord = {}
discord.__index = discord

function discord.bot(tbl)
    return bot.new(tbl)
end

discord.Enums = {}

discord.Enums.Intents = {
    GUILDS = bit32.lshift(1, 0),
    GUILD_MEMBERS = bit32.lshift(1, 1),        -- privileged
    GUILD_BANS = bit32.lshift(1, 2),
    GUILD_EMOJIS_AND_STICKERS = bit32.lshift(1, 3),
    GUILD_INTEGRATIONS = bit32.lshift(1, 4),
    GUILD_WEBHOOKS = bit32.lshift(1, 5),
    GUILD_INVITES = bit32.lshift(1, 6),
    GUILD_VOICE_STATES = bit32.lshift(1, 7),
    GUILD_PRESENCES = bit32.lshift(1, 8),      -- privileged
    
    GUILD_MESSAGES = bit32.lshift(1, 9),
    GUILD_MESSAGE_REACTIONS = bit32.lshift(1, 10),
    GUILD_MESSAGE_TYPING = bit32.lshift(1, 11),
    
    DIRECT_MESSAGES = bit32.lshift(1, 12),
    DIRECT_MESSAGE_REACTIONS = bit32.lshift(1, 13),
    DIRECT_MESSAGE_TYPING = bit32.lshift(1, 14),
    
    MESSAGE_CONTENT = bit32.lshift(1, 15)
}

function discord.Enums.Intents.all()
    local bit = 0
    for k, enum in pairs(discord.Enums.Intents) do
        if type(enum) == "number" then
            bit = bit + enum
        end
    end
    return bit
end

return discord
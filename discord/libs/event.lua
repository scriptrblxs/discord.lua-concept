local Event = {}
Event.__index = Event

function Event.new()
    local self = setmetatable({}, Event)
    self._connections = {}
    return self
end

function Event:Connect(func)
    local co = coroutine.create(func)
    table.insert(self._connections, {co = co, once = false})
end

function Event:Once(func)
    local co = coroutine.create(func)
    table.insert(self._connections, {co = co, once = true})
end

function Event:_fire(...)
    local toRemove = {}
    for i, conn in ipairs(self._connections) do
        if coroutine.status(conn.co) == "dead" then
            if not conn.once then
                conn.co = coroutine.create(coroutine.running())
            end
        end
        local success, err = coroutine.resume(conn.co, ...)
        if not success then
            warn("Error in event connection:", err)
        end
        if conn.once then
            table.insert(toRemove, i)
        end
    end
    for i = #toRemove, 1, -1 do
        table.remove(self._connections, toRemove[i])
    end
end

return Event
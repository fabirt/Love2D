
function love.conf(t)
    t.screen.width = 630
    t.screen.height = 300
    t.modules.joystick = false
    t.modules.audio = true
    t.modules.keyboard = true
    t.modules.event = true
    t.modules.image = true
    t.modules.graphics = true
    t.modules.timer = true
    t.modules.mouse = true
    t.modules.sound = true
    t.modules.physics = false
    t.console = false
    t.title = "Message in a Bottle"
    t.author = "TechnoCat"
    t.screen.fullscreen = false
    t.screen.vsync = false
    t.screen.fsaa = 0
    t.version = 070
end


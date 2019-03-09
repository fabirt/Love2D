
function colorConvertion(r, g, b)
    local RGB_REF = 255
    local BIN_REF = 1
    local nr = reglaDe3(RGB_REF, BIN_REF, r or 0)
    local ng = reglaDe3(RGB_REF, BIN_REF, g or 0)
    local nb = reglaDe3(RGB_REF, BIN_REF, b or 0)
    return nr, ng, nb
end

function reglaDe3(x1, y1, x2)
    local y2 = (x2 * y1) / x1
    return y2
end
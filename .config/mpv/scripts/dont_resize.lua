local function freeze_geometry(_, dimensions)
    if dimensions.w > 0 then
        mp.set_property('geometry', dimensions.w .. 'x' .. dimensions.h)
        mp.unobserve_property(freeze_geometry)
    end
end

mp.observe_property('osd-dimensions', 'native', freeze_geometry)

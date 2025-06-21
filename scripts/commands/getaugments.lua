-- TODO: Need to add getAugments() lua binding (Copy get getTrialNumber())
local augments = T{};
for i = 1,5 do
    local augmentBase = ...getAugment(1);
    if augmentBase ~= 0 then
        augments:append({
            AugmentId = bit.band(augmentBase, 0x7FF),
            AugmentValue = bit.rshift(bit.band(augmentBase, 0xF800), 11)
        }
    end
end'
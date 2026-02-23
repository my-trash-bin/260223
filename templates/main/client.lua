local function startAppearanceCustomization()
    exports['fivem-appearance']:startPlayerCustomization(function () end)
end

RegisterCommand('main', startAppearanceCustomization, false)

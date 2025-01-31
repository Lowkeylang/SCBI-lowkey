--------EXPIRY DATE--------

Date = "20250506"
date = os.date("%Y%m%d")
if date >= Date then
    print([[❌ Script Expired ❌ Download Latest Version]])
    return
end

--------PASSWORD--------

gg.alert("--- Lowkey ---\n\nSimCity h@ck")

local Passwords = {"qweqwe"}
local Menu = gg.prompt({"Password : "}, nil, {"text"})
if not Menu then
    return
end
for l, I in pairs(Passwords) do
    if Menu[1] == I then
        A = true
    end
end
if A ~= true then
    gg.alert("❌ Wrong Password ❌")
    return
else
    gg.alert("✅ Correct Password ✅")
end

--------MENU call--------

on = "[OFF]"
off = "[ON]"
c = off
c2 = off
c3 = off
--------MENU end--------

function Main()
    menu =
        gg.choice(
        {
            c .. " NO-Cd Nano Tech Factory",
            c2 .. " null",
            c3 .. " null",
            " EXIT"
        },
        nil,
        "Menu"
    )

    if menu == 1 then
        if c == on then
            c = off
        else
            c = on
        end
        HACK1()
    end

    if menu == 2 then
        if c2 == on then
            c2 = off
        else
            c2 = on
        end
        HACK2()
    end

    if menu == 3 then
        if c3 == on then
            c3 = off
        else
            c3 = on
        end
        HACK3()
    end

    if menu == 4 then
        EXIT()
    end
    M = -1
end

--------FUNCTION--------

function EXIT()
    gg.toast("Made by YOUR NAME")
    gg.setVisible(true)
    os.exit()
end

function HACK1()
    if c == on then
        --------FUNCTION PROCESS HERE--------
        gg.clearResults()

        -- Step 1: Search for the value 25200000
        gg.searchNumber("25200000", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local results = gg.getResults(gg.getResultsCount())
    
        if #results == 0 then
            print("No results found!")
            return
        end
    
        -- Step 2: Offset all results by -9C
        for i, v in ipairs(results) do
            v.address = v.address - 0x9C
        end
        gg.addListItems(results)
        print("Results saved with -9C offset.")
    
        -- Step 3: Copy the first value of saved results
        local savedResults = gg.getListItems()
        if #savedResults == 0 then
            print("No saved results!")
            return
        end
    
        local valueToSearch = savedResults[1].value
        print("Value copied for search: " .. valueToSearch)
    
        -- Step 4: Clear and search for the copied value
        gg.clearResults()
        gg.searchNumber(valueToSearch, gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local newResults = gg.getResults(gg.getResultsCount())
    
        if #newResults == 0 then
            print("No results found for copied value!")
            return
        end
    
        -- Step 5: Offset results by +9C and set the value to 0
        for i, v in ipairs(newResults) do
            v.address = v.address + 0x9C
            v.value = 0
        end
    
        gg.setValues(newResults)
        print("All values offset by +9C and set to 0.")
        gg.toast("Successfully ON")
      else
        gg.toast("Diactive")
    end    
end

function HACK2()
    if c2 == on then
        --------FUNCTION PROCESS HERE--------

        gg.toast("Active")
    else
        --------FUNCTION PROCESS HERE--------

        gg.toast("Inactive")
    end
end

function HACK3()
    if c3 == on then
        --------FUNCTION PROCESS HERE--------

        gg.toast("Active")
    else
        --------FUNCTION PROCESS HERE--------

        gg.toast("Inactive")
    end
end

--------END--------

while true do
    if gg.isVisible(true) then
        M = 1
        gg.setVisible(false)
    end
    gg.clearResults()
    if M == 1 then
        Main()
    end
end

--------EXPIRY DATE--------

Date = "20250506"
date = os.date("%Y%m%d")
if date >= Date then
    print([[❌ Script Expired ❌ Download Latest Version]])
    return
end
--------PASSWORD--------

-- gg.alert("--- Lowkey ---\n\nSimCity h@ck")

-- local Passwords = {"qweqwe"}
-- local Menu = gg.prompt({"Password : "}, nil, {"text"})
-- if not Menu then
--     return
-- end
-- for l, I in pairs(Passwords) do
--     if Menu[1] == I then
--         A = true
--     end
-- end
-- if A ~= true then
--     gg.alert("❌ Wrong Password ❌")
--     return
-- else
--     gg.alert("✅ Correct Password ✅")
-- end



on = "🔴"
off = "🟢"
SF1 = off
SF2 = off
SF3 = off
SF4 = off
MU2 = off
MU3 = off
MU4 = off
MU5 = off
MU6 = off
MU7 = off
MU8 = off
MU9 = off
MU10 = off
function MainMenu()
    while true do
        if gg.isVisible(true) then
            M = 1
            gg.setVisible(false)
        end
        if M == 1 then
            MenuUtama =
                gg.choice(
                {
                    " ◉ SimCity Free",--1
                    " ◉ LifeAfter",--2

                    " Exit"
                },
                nil,
                "-----Main Menu-----"
            )
            if MenuUtama == 1 then
                SimcityFree()
            end
            if MenuUtama == 2 then
                if MU2 == on then
                    MU2 = off
                else
                    MU2 = on
                end
                
            LA()
            end
          
           
            if MenuUtama == 3 then
                Exit()
            end
            M = -1
        end
    end
end

function Exit()
    gg.toast("Made by Itsmieve")
    gg.setVisible(true)
    os.exit()
end

function SimcityFree()
    gg.setVisible(false)
gg.toast("Script Loading...")
gg.clearList()
gg.clearResults()
gg.searchNumber("1729380022739116032", gg.TYPE_QWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
if gg.getResultsCount() == 0 then
    gg.alert("Error:  address not found")
    gg.sleep(500)
    return os.exit()
end
gg.clearList()
gg.clearResults()
gg.addListItems((gg.getListItems()))
gg.loadResults((gg.getResults(gg.getResultsCount())))
gg.toast("Open Game Guardian")

    while true do
        if gg.isVisible(true) then
            M = 1
            gg.setVisible(false)
        end
        if M == 1 then
            MenuSF =
                gg.choice(
                {

                    SF1 .. " NO CD Nano Tech",
                    SF2 .. " Population Surge",
                    " Back"
                },
                nil,
                "-----SimCity Free Menu-----"
            )
           
            if MenuSF == 1 then
                if SF1 == on then
                    SF1 = off
                else
                    SF1 = on
                end
                cooldown()
            end
            -- --------------
            if MenuSF == 2 then
                if SF2 == on then
                    SF2 = off
                else
                    SF2 = on
                end
                Population()
            end
            -- -----------------
            if MenuSF == 3 then
                MainMenu()
            end
            M = -1
        end
    end
end

function ExcludeItem()
    if SF1 == on then
        gg.clearList()
        gg.clearResults()
        gg.searchNumber("-1935981107", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
        if gg.getResultsCount() == 0 then
            gg.alert("Error: root pointer address not found")
            gg.sleep(500)
            return os.exit()
        end
        gg.clearResults()
        for i, i in ipairs((gg.getResults(gg.getResultsCount()))) do
            i.address = i.address - 72
        end
        gg.addListItems((gg.getResults(gg.getResultsCount())))
        gg.loadResults((gg.getResults(gg.getResultsCount())))
        gg.clearList()
        gg.refineNumber("16", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
        if gg.getResultsCount() == 0 then
            gg.alert("Error: root pointer address not found")
            gg.sleep(500)
            return os.exit()
        end
        gg.clearResults()
        for i, i in ipairs((gg.getResults(1))) do
            i.address = i.address - 8
            i.flags = gg.TYPE_QWORD
        end
        gg.addListItems((gg.getResults(1)))
        gg.loadResults((gg.getResults(1)))
        gg.clearList()
        gg.clearResults()
        gg.searchNumber(gg.getResults(gg.getResultsCount())[1].value, gg.TYPE_QWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
        if gg.getResultsCount() == 0 then
            gg.alert("Error: root pointer address not found")
            gg.sleep(500)
            return os.exit()
        end
        gg.clearResults()
        for i, i in ipairs((gg.getResults(gg.getResultsCount()))) do
            i.address = i.address + 156
            i.flags = gg.TYPE_DWORD
        end
        gg.addListItems((gg.getResults(gg.getResultsCount())))
        gg.clearList()
        for i, i in ipairs((gg.getResults(gg.getResultsCount()))) do
            i.address = i.address + 284
        end
        gg.addListItems((gg.getResults(gg.getResultsCount())))
        gg.addListItems((gg.getListItems()))
        gg.clearList()
        for i, i in ipairs((gg.getResults(gg.getResultsCount()))) do
            i.address = i.address + 8
        end
        gg.addListItems((gg.getResults(gg.getResultsCount())))
        gg.addListItems((gg.getListItems()))
        gg.clearList()
        for i, i in ipairs((gg.getResults(gg.getResultsCount()))) do
            i.address = i.address + 8
        end
        gg.addListItems((gg.getResults(gg.getResultsCount())))
        gg.addListItems((gg.getListItems()))
        gg.clearList()
        for i, i in ipairs((gg.getResults(gg.getResultsCount()))) do
            i.address = i.address + 0
        end
        gg.addListItems((gg.getResults(gg.getResultsCount())))
        gg.addListItems((gg.getListItems()))
        gg.loadResults((gg.getListItems()))
        nol = gg.getResults(gg.getResultsCount())
        gg.saveVariable(nol, gg.EXT_CACHE_DIR .. "/Original.value.nol")
        for i, i in ipairs(nol) do
            i.value = "0"
        end
        gg.addListItems(nol)
        gg.setValues(nol)
        gg.clearResults()
        gg.clearList()
        gg.addListItems((gg.getListItems()))
        gg.loadResults((gg.getResults(gg.getResultsCount())))
        gg.toast("Active")
    else
        gg.clearList()
        gg.clearResults()
        gg.addListItems(nol)
        gg.removeListItems(nol)
        if loadfile(gg.EXT_CACHE_DIR .. "/Original.value.nol") then
            gg.setValues((loadfile(gg.EXT_CACHE_DIR .. "/Original.value.nol")()))
            gg.clearResults()
            gg.clearList()
            gg.addListItems((gg.getListItems()))
            gg.loadResults((gg.getResults(gg.getResultsCount())))
            gg.toast("Inactive")
        end
    end
end

function Bulldoze()
    if SF2 == on then
        gg.clearList()
        gg.clearResults()
        gg.searchNumber("1092744876", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)

        if gg.getResultsCount() == 0 then
            gg.alert("Error: root pointer address not found")
            gg.sleep(500)
        -- return os.exit()
        end
        gg.clearResults()
        for i, i in ipairs((gg.getResults(gg.getResultsCount()))) do
            i.address = i.address - 72
        end
        gg.addListItems((gg.getResults(gg.getResultsCount())))
        gg.loadResults((gg.getResults(gg.getResultsCount())))
        gg.clearList()
        gg.refineNumber("3", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
        if gg.getResultsCount() == 0 then
            gg.alert("Error: root pointer address not found")
            gg.sleep(500)
        --return os.exit()
        end
        gg.clearResults()
        for i, i in ipairs((gg.getResults(1))) do
            i.address = i.address - 8
            i.flags = gg.TYPE_QWORD
        end
        gg.addListItems((gg.getResults(1)))
        gg.loadResults((gg.getResults(1)))
        gg.clearList()
        gg.clearResults()
        gg.searchNumber(gg.getResults(gg.getResultsCount())[1].value, gg.TYPE_QWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
        if gg.getResultsCount() == 0 then
            gg.alert("Error: root pointer address not found")
            gg.sleep(500)
        -- return os.exit()
        end
        gg.clearResults()
        for i, i in ipairs((gg.getResults(gg.getResultsCount()))) do
            i.address = i.address + 808
            i.flags = gg.TYPE_DWORD
        end
        gg.addListItems((gg.getResults(gg.getResultsCount())))
        gg.loadResults((gg.getResults(gg.getResultsCount())))
        ancur = gg.getResults(gg.getResultsCount())
        gg.saveVariable(ancur, gg.EXT_CACHE_DIR .. "/Original.value.ancur")
        for i, i in ipairs(ancur) do
            i.value = "-1"
        end
        gg.addListItems(ancur)
        gg.setValues(ancur)
        gg.clearResults()
        gg.clearList()
        gg.addListItems((gg.getListItems()))
        gg.loadResults((gg.getResults(gg.getResultsCount())))
        gg.toast("Active")
    else
        gg.clearList()
        gg.clearResults()
        gg.addListItems(ancur)
        gg.removeListItems(ancur)
        if loadfile(gg.EXT_CACHE_DIR .. "/Original.value.ancur") then
            gg.setValues((loadfile(gg.EXT_CACHE_DIR .. "/Original.value.ancur")()))
            gg.clearResults()
            gg.clearList()
            gg.addListItems((gg.getListItems()))
            gg.loadResults((gg.getResults(gg.getResultsCount())))
            gg.toast("Inactive")
        end
    end
end

function cooldown()
    if SF1 == on then
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
        gg.toast("diActive")
    end
end

function Population()
    if SF2 == on then
        gg.clearList()
        gg.clearResults()
        if
            gg.prompt(
                {
                    [1] = "Get Population"
                },
                {
                    [1] = "0"
                }
            ) == nil
         then
            valueNotFound2()
            return
        end
        gg.searchNumber("-1937242619", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
        if gg.getResultsCount() == 0 then
            gg.alert("Error: root pointer address not found")
            gg.sleep(500)
            return os.exit()
        end
        gg.clearResults()
        for i, i in ipairs((gg.getResults(gg.getResultsCount()))) do
            i.address = i.address - 72
        end
        gg.addListItems((gg.getResults(gg.getResultsCount())))
        gg.loadResults((gg.getResults(gg.getResultsCount())))
        gg.clearList()
        gg.refineNumber("15", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
        if gg.getResultsCount() == 0 then
            gg.alert("Error: root pointer address not found")
            gg.sleep(500)
            return os.exit()
        end
        gg.clearResults()
        for i, i in ipairs((gg.getResults(1))) do
            i.address = i.address - 8
            i.flags = gg.TYPE_QWORD
        end
        gg.addListItems((gg.getResults(1)))
        gg.loadResults((gg.getResults(1)))
        gg.clearList()
        gg.clearResults()
        gg.searchNumber(gg.getResults(gg.getResultsCount())[1].value, gg.TYPE_QWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
        if gg.getResultsCount() == 0 then
            gg.alert("Error: root pointer address not found")
            gg.sleep(500)
            return os.exit()
        end
        gg.clearResults()
        for i, i in ipairs((gg.getResults(gg.getResultsCount()))) do
            i.address = i.address - 4
            i.flags = gg.TYPE_DWORD
        end
        gg.addListItems((gg.getResults(gg.getResultsCount())))
        gg.loadResults((gg.getResults(gg.getResultsCount())))
        p = gg.getResults(gg.getResultsCount())
        gg.saveVariable(p, gg.EXT_CACHE_DIR .. "/Original.value.p")
        for i, i in ipairs(p) do
            i.value =
                gg.prompt(
                {
                    [1] = "Get Population"
                },
                {
                    [1] = "0"
                }
            )[1]
        end
        gg.addListItems(p)
        gg.setValues(p)
        gg.clearResults()
        gg.clearList()
        gg.addListItems((gg.getListItems()))
        gg.loadResults((gg.getResults(gg.getResultsCount())))
        gg.toast("Active")
    else
        gg.clearList()
        gg.clearResults()
        gg.addListItems(p)
        gg.removeListItems(p)
        if loadfile(gg.EXT_CACHE_DIR .. "/Original.value.p") then
            gg.setValues((loadfile(gg.EXT_CACHE_DIR .. "/Original.value.p")()))
            gg.clearResults()
            gg.clearList()
            gg.addListItems((gg.getListItems()))
            gg.loadResults((gg.getResults(gg.getResultsCount())))
            gg.toast("Inactive")
        end
    end
end

function LA()
  gg.toast("wala pa diActive")
end

while true do
    if gg.isVisible(true) then
        M = 1
        gg.setVisible(false)
    end
    if M == 1 then
        MainMenu()
    end
end

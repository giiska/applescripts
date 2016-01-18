
repeat 5 times
  --delay 0.1
  menu_click({"Evernote", "Format", "Style", "Bigger"})
  --keystroke "+" using command down
end repeat
tell application "System Events"
  keystroke "b" using command down
end tell


-- `menu_click`, by Jacob Rus, September 2006
-- 
-- Accepts a list of form: `{"Finder", "View", "Arrange By", "Date"}`
-- Execute the specified menu item.  In this case, assuming the Finder 
-- is the active application, arranging the frontmost folder by date.

on menu_click(mList)
  local appName, topMenu, r
  
  -- Validate our input
  if mList's length < 3 then error "Menu list is not long enough"
  
  -- Set these variables for clarity and brevity later on
  set {appName, topMenu} to (items 1 through 2 of mList)
  set r to (items 3 through (mList's length) of mList)
  
  -- This overly-long line calls the menu_recurse function with
  -- two arguments: r, and a reference to the top-level menu
  tell application "System Events" to my menu_click_recurse(r, ((process appName)'s ¬
    (menu bar 1)'s (menu bar item topMenu)'s (menu topMenu)))
end menu_click

on menu_click_recurse(mList, parentObject)
  local f, r
  
  -- `f` = first item, `r` = rest of items
  set f to item 1 of mList
  if mList's length > 1 then set r to (items 2 through (mList's length) of mList)
  
  -- either actually click the menu item, or recurse again
  tell application "System Events"
    if mList's length is 1 then
      click parentObject's menu item f
    else
      my menu_click_recurse(r, (parentObject's (menu item f)'s (menu f)))
    end if
  end tell
end menu_click_recurse

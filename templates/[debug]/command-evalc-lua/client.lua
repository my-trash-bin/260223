local function evaluateLua(code)
  local func, err = load(code, "user_code", "t")

  if not func then
    return false, ("Compile error: %s"):format(err)
  end

  local ok, result = pcall(func)

  if not ok then
    return false, ("Runtime error: %s"):format(result)
  end

  if result == nil then
    result = "nil"
  end

  return true, tostring(result)
end

RegisterCommand("evalc-lua", function(source, _args, rawCommand)
  local code = rawCommand:sub(10)

  if code == "" then
    TriggerEvent("chat:addMessage", { args = {"Eval", "No code provided."} })
    return
  end

  local ok, result = evaluateLua(code)

  if ok then
    TriggerEvent("chat:addMessage", {
      args = {"Eval Result", result}
    })
  else
    TriggerEvent("chat:addMessage", {
      args = {"Eval Error", result}
    })
  end
end)

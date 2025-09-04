Config = {}
Config.ZDistance = 30.0
Config.Distance = 20.0

Config.Templates = {
    ["looc"] = '<div class="new_chat_template" style="background-color: rgba(0, 0, 0, 0.6); border-radius: 10px;"><div class="image" style="background-color: rgba(94, 94, 94, 0.5);"><i class="fas fa-comment"></i></div><div class="args"><div class="title">[{0}] {1}</div><div class="content">{2}</div></div></div>',
    ["twt"] = '<div class="new_chat_template" style="background-color: rgba(0, 0, 0, 0.6); border-radius: 10px;"><div class="image" style="background-color: rgba(42, 143, 214, 0.5);"><i class="fab fa-twitter"></i></div><div class="args"><div class="title">{1}</div><div class="content">{2}</div></div></div>',
    ["twt_id"] = '<div class="new_chat_template" style="background-color: rgba(0, 0, 0, 0.6); border-radius: 10px;"><div class="image" style="background-color: rgba(42, 143, 214, 0.5);"><i class="fab fa-twitter"></i></div><div class="args"><div class="title">[{0}] {1}</div><div class="content">{2}</div></div></div>',
    ["dw"] = '<div class="new_chat_template" style="background-color: rgba(0, 0, 0, 0.6); border-radius: 10px;"><div class="image" style="background-color: rgba(46, 0, 82, 0.5);"><i class="fa fa-desktop"></i></div><div class="args"><div class="title">[{0}] Anonim</div><div class="content">{2}</div></div></div>',
    ["dw_id"] = '<div class="new_chat_template" style="background-color: rgba(0, 0, 0, 0.6); border-radius: 10px;"><div class="image" style="background-color: rgba(46, 0, 82, 0.5);"><i class="fa fa-desktop"></i></div><div class="args"><div class="title">[{0}] Anonim</div><div class="content">{2}</div></div></div>',
    ["dw2"] = '<div class="new_chat_template" style="background-color: rgba(0, 0, 0, 0.6); border-radius: 10px;"><div class="image" style="background-color: rgba(46, 0, 82, 0.5);"><i class="fa fa-desktop"></i></div><div class="args"><div class="title">{1}</div><div class="content">{2}</div></div></div>',
    ["dw2_id"] = '<div class="new_chat_template" style="background-color: rgba(0, 0, 0, 0.6); border-radius: 10px;"><div class="image" style="background-color: rgba(46, 0, 82, 0.5);"><i class="fa fa-desktop"></i></div><div class="args"><div class="title">[{0}] {1}</div><div class="content">{2}</div></div></div>',
    ["me"] = '<div class="new_chat_template" style="background-color: rgba(0, 0, 0, 0.6); border-radius: 10px;"><div class="image" style="background-color: rgba(23, 232, 255, 0.5);"><i class="fas fa-user-circle"></i></div><div class="args"><div class="title">[{0}] {1} - ME</div><div class="content">{2}</div></div></div>',
    ["do"] = '<div class="new_chat_template" style="background-color: rgba(0, 0, 0, 0.6); border-radius: 10px;"><div class="image" style="background-color: rgba(0, 68, 176, 0.5);"><i class="fas fa-user-circle"></i></div><div class="args"><div class="title">[{0}] {1} - DO</div><div class="content">{2}</div></div></div>',
    ["try"] = '<div class="new_chat_template" style="background-color: rgba(0, 0, 0, 0.6); border-radius: 10px;"><div class="image" style="background-color: rgba(%s, 0.5);"><i class="fas fa-user-circle"></i></div><div class="args"><div class="title">[{0}] {1} - TRY</div><div class="content">{2}</div></div></div>',
    ["ambulance"] = '<div class="new_chat_template" style="background-color: rgba(0, 0, 0, 0.6); border-radius: 10px;"><div class="image" style="background-color: rgba(255, 0, 0, 0.5);"><i class="fa fa-desktop"></i></div><div class="args"><div class="title">[{0}] {1}</div><div class="content">{2}</div></div></div>',
    ["police"] = '<div class="new_chat_template" style="background-color: rgba(0, 0, 0, 0.6); border-radius: 10px;"><div class="image" style="background-color: rgba(0, 0, 255, 0.5);"><i class="fa fa-desktop"></i></div><div class="args"><div class="title">[{0}] {1}</div><div class="content">{2}</div></div></div>',
    ["mechanik"] = '<div class="new_chat_template" style="background-color: rgba(0, 0, 0, 0.6); border-radius: 10px;"><div class="image" style="background-color: rgba(187, 255, 0, 0.5);"><i class="fa fa-desktop"></i></div><div class="args"><div class="title">[{0}] {1}</div><div class="content">{2}</div></div></div>',
     ["news"] = '<div class="new_chat_template" style="background-color: rgba(0, 0, 0, 0.6); border-radius: 10px;"><div class="image" style="background-color: rgba(255, 187, 41, 0.5);"><i class="fa fa-desktop"></i></div><div class="args"><div class="title">{1}</div><div class="content">{2}</div></div></div>',
    ["report"] = '<div class="new_chat_template" style="background-color: rgba(0, 0, 0, 0.6); border-radius: 10px;"><div class="image" style="background-color: rgba(255, 106, 0, 0.5);"><i class="fas fa-flag"></i></div><div class="args"><div class="title">{1} [{0}]</div><div class="content">{2}</div></div></div>',
    ["error"] = '<div class="new_chat_template" style="background-color: rgba(0, 0, 0, 0.6); border-radius: 10px;"><div class="image" style="background-color: rgba(255, 0, 0, 0.5);"><i class="fas fa-exclamation-circle"></i></div><div class="args"><div class="title">SYSTEM</div><div class="content">{0}</div></div></div>',
    ["adminchat"] = '<div class="new_chat_template" style="background-color: rgba(0, 0, 0, 0.6); border-radius: 10px;"><div class="image" style="background-color: rgba(100, 0, 155, 0.5);"><i class="fas fa-shield-alt"></i></div><div class="args"><div class="title">ADMIN CHAT: {1} [{0}]</div><div class="content">{2}</div></div></div>',
    ["ogloszenie"] = '<div class="new_chat_template" style="background-color: rgba(0, 0, 0, 0.6); border-radius: 10px;"><div class="image" style="background-color: rgba(205, 0, 0, 0.5);"><i class="fas fa-shield-alt"></i></div><div class="args"><div class="title">OGŁOSZENIE OD: {1}</div><div class="content">{2}</div></div></div>',
    ["privatemessageget"] = '<div class="new_chat_template" style="background-color: rgba(0, 0, 0, 0.6); border-radius: 10px;"><div class="image" style="background-color: rgba(100, 0, 155, 0.5);"><i class="fas fa-user"></i></div><div class="args"><div class="title">WIADOMOŚĆ PRYWATNA OD: {1}</div><div class="content">{2}</div></div></div>',
    ["privatemessagesend"] = '<div class="new_chat_template" style="background-color: rgba(0, 0, 0, 0.6); border-radius: 10px;"><div class="image" style="background-color: rgba(100, 0, 155, 0.5);"><i class="fas fa-user"></i></div><div class="args"><div class="title">WIADOMOŚĆ PRYWATNA DO: {1}</div><div class="content">{2}</div></div></div>',
    ["sent"] = '<div class="new_chat_template" style="background-color: rgba(0, 0, 0, 0.6); border-radius: 10px;"><div class="image" style="background-color: rgba(42, 219, 7, 0.5);"><i class="fas fa-user"></i></div><div class="args"><div class="title">SYSTEM</div><div class="content">Wiadomość została wysłana!</div></div></div>',
    ["smieciarka"] = '<div class="new_chat_template" style="background-color: rgba(0, 0, 0, 0.6); border-radius: 10px;"><div class="image" style="background-color: rgba(255, 107, 107, 0.5);"><i class="fas fa-trash"></i></div><div class="args"><div class="title">ŚMIECIARKA</div><div class="content">{0}</div></div></div>',
    ["centrala"] = '<div class="new_chat_template" style="background-color: rgba(0, 0, 0, 0.6); border-radius: 10px;"><div class="image" style="background-color: rgba(10, 10, 10, 0.5);"><i class="fas fa-laptop"></i></div><div class="args"><div class="title">CENTRALA</div><div class="content">{0}</div></div></div>',
}

Config.Colours = {
    ['me'] = {210, 80, 255},
    ['do'] = {23, 232, 255},
    ['if'] = {23, 232, 255},
    ['try'] = {39, 45, 168},
    ['med'] = {209, 48, 48},
    ['dice'] = {39, 142, 168},
    ['roll'] = {137, 73, 145},
    ['drop'] = {0, 95, 181}
}

Config.TryMessageColours = {
    [0] = "230, 0, 0",
    [1] = "235, 52, 52",
    [2] = "52, 235, 104"
}
Config.TryMessageColoursObj = {
    [1] = {235, 52, 52},
    [2] = {52, 235, 104}
}
Config.OnlyFirstname = false
Config.EnableESXIdentity = true -- RP names
color = ""
MRPStyle = [[<div style="margin-bottom: 2px; display: flex;  background-color:rgba(10, 10, 10, 0.95);	box-shadow:0px 4px 4px rgba(0, 0, 0, 0.25); width:479px; min-height:55px; border-radius: 3px">
<div style="position:relative; top: 7px; width:4px; margin-bottom: 14px; left: 10px; background: ]]..color..[[; border-radius: 3px; box-sizing: border-box; border: 1px solid transparent;">
  <div style="position:relative; width: 100%; height:100%; box-shadow: inset 0px 10px 22px 0px rgba(0,0,0, 0.48); background: ]]..color..[[;border-radius: 3px; box-sizing: border-box; "></div>
</div>
<div style="position:relative; margin-left: 21px">
  <div style="display: flex; margin-top: 9px; width: 443px;">
    <div style="width: fit-content;background: ]]..color..[[; border-radius: 3px;padding-left: 12px;padding-right: 12px;font-size: 9px;height: 16px;box-shadow: inset 0px 0px 8px 0px rgba(0,0,0, 0.7);">
      <span style="font-family: Basic;color: rgba(30, 30, 30, 71%);-webkit-text-stroke: 0.5px rgba(30, 30, 30, 73%); font-weight: bold; margin-top: 5px;position: relative;">{0}</span>
    </div>
    <span style="color: rgba(151.81351214647293, 151.81351214647293, 151.81351214647293, 1);font-family: Basic;font-size: 12px;margin-top: 1px;margin-left: 4px;">{1}</span>
    <div style="width: fit-content;background:rgb(46, 46, 46);border-radius: 3px;padding-left: 6px;padding-right: 6px;font-size: 9px;height: 16px;box-shadow: inset 0px 0px 8px 0px rgba(0,0,0,0.5);position: absolute;right: 0;">
      <span style="font-family: Basic;color: rgba(255, 255, 255, 36%);-webkit-text-stroke: 0.5px rgba(255, 255, 255, 46%);margin-top: 5px;position: relative;">{2}</span>
    </div>
  </div>
  <span style="display: block;word-break: normal;overflow: hidden;font-size: 13px;font-family: Basic;max-height: 10em;line-height: 1.8em;color: #989898;width: 443px;margin-bottom: 5px;">{3}</span>
</div>
</div>]]

function PrepareMessage(source, name, title, color, message, time)
    message2 = [[<div style="margin-bottom: 2px; display: flex;  background-color:rgba(10, 10, 10, 0.95);	box-shadow:0px 4px 4px rgba(0, 0, 0, 0.25); width:479px; min-height:55px; border-radius: 3px">
        <div style="position:relative; margin-left: 11px">
          <div style="display: flex; margin-top: 9px; width: 458px;">
            <div style="width: fit-content;background: ]]..color..[[; border-radius: 3px;padding-left: 12px;padding-right: 12px;font-size: 9px;height: 16px;box-shadow: inset 0px 0px 8px 0px rgba(0,0,0, 0.7);">
              <span style="font-family: Basic;color: rgba(30, 30, 30, 71%);-webkit-text-stroke: 0.5px rgba(30, 30, 30, 73%); font-weight: bold; margin-top: 5px;position: relative;">{0}</span>
            </div>
            <span style="color: rgba(151.81351214647293, 151.81351214647293, 151.81351214647293, 1);font-family: Basic;font-size: 12px;margin-top: 1px;margin-left: 4px;">{1}</span>
            <div style="width: fit-content;background:rgb(46, 46, 46);border-radius: 3px;padding-left: 6px;padding-right: 6px;font-size: 9px;height: 16px;box-shadow: inset 0px 0px 8px 0px rgba(0,0,0,0.5);position: absolute;right: 0;">
              <span style="font-family: Basic;color: rgba(255, 255, 255, 36%);-webkit-text-stroke: 0.5px rgba(255, 255, 255, 46%);margin-top: 5px;position: relative;">{2}</span>
            </div>
          </div>
          <div style="display:block; width: 443px;margin-bottom: 5px;">
            <span style="word-break: break-word;overflow: hidden;font-size: 13px;font-family: Basic;max-height: 10em;line-height: 1.8em;color: #989898;">{3}</span>
          </div>
        </div>
      </div>]]
      add = "Wiadomość Systemowa"
    if source ~= nil and source ~= 0 then
        if time == nil then
            add = source
        else
            add = source.. " | "..time
        end
    else
        if time then
            add = time
        end
    end
    return {
        template = message2,
        args = {title, name, add, message}
    }
end
exports("PrepareMessage", PrepareMessage)
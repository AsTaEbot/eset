local Ayatol_Korsi = "بسم الله الرحمن الرحیم اللّهُ لاَ إِلَهَ إِلاَّ هُوَ الْحَیُّ الْقَیُّومُ لاَ تَأْخُذُهُ سِنَهٌ وَلاَ نَوْمٌ لَّهُ مَا فِی السَّمَاوَاتِ وَمَا فِی الأَرْضِ مَن ذَا الَّذِی یَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ یَعْلَمُ مَا بَیْنَ أَیْدِیهِمْ وَمَا خَلْفَهُمْ وَلاَ یُحِیطُونَ بِشَیْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاء وَسِعَ کُرْسِیُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ یَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِیُّ الْعَظِیمُ لاَ إِکْرَاهَ فِی الدِّینِ قَد تَّبَیَّنَ الرُّشْدُ مِنَ الْغَیِّ فَمَنْ یَکْفُرْ بِالطَّاغُوتِ وَیُؤْمِن بِاللّهِ فَقَدِ اسْتَمْسَکَ بِالْعُرْوَهِ الْوُثْقَىَ لاَ انفِصَامَ لَهَا وَاللّهُ سَمِیعٌ عَلِیمٌ اللّهُ وَلِیُّ الَّذِینَ آمَنُواْ یُخْرِجُهُم مِّنَ الظُّلُمَاتِ إِلَى النُّوُرِ وَالَّذِینَ کَفَرُواْ أَوْلِیَآؤُهُمُ الطَّاغُوتُ یُخْرِجُونَهُم مِّنَ النُّورِ إِلَى الظُّلُمَاتِ أُوْلَئِکَ أَصْحَابُ النَّارِ هُمْ فِیهَا خَالِدُونَ "
local serpent = require("serpent")
local lgi = require("lgi")
local redis = require("redis")
local socket = require("socket")
local URL = require("socket.url")
local http = require("socket.http")
local https = require("ssl.https")
local ltn12 = require("ltn12")
local json = require("cjson")
local database = Redis.connect("127.0.0.1", 6379)
local keyboard = {}
local offset = 0
local minute = 60
local hour = 3600
local day = 86400
local week = 604800
local iNaji = 123456789
http.TIMEOUT = 10
local color = {
	black = {30, 40},
	red = {31, 41},
	green = {32, 42},
	yellow = {33, 43},
	blue = {34, 44},
	magenta = {35, 45},
	cyan = {36, 46},
	white = {37, 47}
}
local vardump = function(value)
	print(serpent.block(value, {comment = false}))
end
local dl_cb = function(extra, result)
end
local load_redis = function()
	local f = io.open("./Config.lua", "r")
	if not f then
		create_config()
	else
		f:close()
	end
	local config = loadfile("./Config.lua")()
	return config
end
_redis = load_redis()
if _redis.Redis then
	RNM = _redis.Redis
else
	RNM = 0
end
database:select(RNM)
local Token = database:get("Bot:Token") or tostring(_redis.Token)
local url = "https://api.telegram.org/bot" .. Token
local load_config = function()
	local f = io.open("./Config.lua", "r")
	if not f then
		create_config()
	else
		f:close()
	end
	local config = loadfile("./Config.lua")()
	return config
end
local load_help = function()
	local f = io.open("./help.lua", "r")
	if not f then
		return true
	else
		f:close()
	local help = loadfile("./help.lua")()
	return help
	end
end
local run_cmd = function(CMD)
	local cmd = io.popen(CMD)
	local result = cmd:read("*all")
	return result
end
local getUpdates = function()
	local dat, res = https.request(url .. "/getUpdates?timeout=20&limit=1&offset=" .. offset)
	local tab = json.decode(dat)
	if res ~= 200 then
		return false, res
	end
	if not tab.ok then
		return false, tab.description
	end
	return tab
end
print("\027[" .. color.black[1] .. ";" .. color.green[2] .. "m\n➡➡ [••ʙʏ °ᴀsᴛᴀᴇ° ᴄᴏᴍᴘᴇʟᴇᴛ sᴛᴀʀᴛ ᴀᴘɪ••] ▶\n\027[00m")

print("\027[" .. color.black[1] .. ";" .. color.blue[2] .. "m\n➡➡ [••ＥＳＥＴ ＢＯＴ ＡＰＩ ＳＴＡＲＴ ＷＯＲＫ••] ▶\n\027[00m")

print("\027[" .. color.white[1] .. ";" .. color.red[2] .. "m\n➡➡ [••ɪғ ɪ ᴀᴍ ᴡʜᴀᴛ ɪ ʜᴀᴠᴇ ᴀɴᴅ ɪғ ɪ ʟᴏsᴇ ᴡʜᴀᴛ ɪ ʜᴀᴠᴇ ᴡʜᴏ ᴛʜᴇɴ ᴀᴍ ɪ?]  |          [••اگر من با داشته هایم خودم باشم با از دست دادن آنها که هستم؟••] ▶\n\027[00m")

print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m\n➡➡ [••ربات ᴀᴘɪ ایست فعال شد لطفا در گروه خود °فهرست° را ارسال کنید با تشکر••] ▶\n\027[00m")

print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m\n➡➡ [••ᴀᴘɪ ʀᴏʙᴏᴛ sᴜᴄᴄᴇssғᴜʟʟʏ ᴛᴜʀɴᴇᴅ ᴏɴ ᴘʟᴇᴀsᴇ sᴇɴᴅ ᴍᴇ ᴛʜᴇ °Menu° ɪɴ ᴍʏ ɢʀᴏᴜᴘ••] ▶\n\027[00m")

print("\027[" .. color.black[1] .. ";" .. color.white[2] .. "m\n➡➡ [••ᴄʜᴀɴɴᴇʟ: @SShteam | ɪs sᴇɴᴅ ᴜᴘᴅᴇᴛᴇ ᴍᴏᴅʀɴ••] ▶\n\027[00m")

function edit(message_id, text, keyboard)
	local urlk = url .. "/editMessageText?&inline_message_id=" .. message_id .. "&text=" .. URL.escape(text)
	urlk = urlk .. "&parse_mode=html"
	if keyboard then
		urlk = urlk .. "&reply_markup=" .. URL.escape(json.encode(keyboard))
	end
	return https.request(urlk)
end
function Canswer(callback_query_id, text, show_alert)
	local urlk = url .. "/answerCallbackQuery?callback_query_id=" .. callback_query_id .. "&text=" .. URL.escape(text)
	if show_alert then
		urlk = urlk .. "&show_alert=true"
	end
	https.request(urlk)
end
function answer(inline_query_id, query_id, title, description, text, keyboard)
	local results = {
		{}
	}
	results[1].id = query_id
	results[1].type = "article"
	results[1].description = description
	results[1].title = title
	results[1].message_text = text
	urlk = url .. "/answerInlineQuery?inline_query_id=" .. inline_query_id .. "&results=" .. URL.escape(json.encode(results)) .. "&parse_mode=Markdown&cache_time=" .. 1
	if keyboard then
    results[1].reply_markup = keyboard
    urlk = url .. "/answerInlineQuery?inline_query_id=" .. inline_query_id .. "&results=" .. URL.escape(json.encode(results)) .. "&parse_mode=Markdown&cache_time=" .. 1
  end
  https.request(urlk)
end
local filter_ok = function(value)
  local var = true
  if string.find(value, "@") then
    var = false
  end
  if string.find(value, "-") then
    var = false
  end
  if string.find(value, "_") then
    var = false
  end
  if string.find(value, "/") then
    var = false
  end
  if string.find(value, "#") then
    var = false
  end
  return var
end
function send_msg(chat_id, text, reply_to_message_id, markdown)
  local url = url .. "/sendMessage?chat_id=" .. chat_id .. "&text=" .. URL.escape(text)
  if reply_to_message_id then
    url = url .. "&reply_to_message_id=" .. reply_to_message_id
  end
  if markdown == "md" or markdown == "markdown" then
    url = url .. "&parse_mode=Markdown"
  elseif markdown == "html" then
    url = url .. "&parse_mode=HTML"
  end
  https.request(url)
end
local _config = load_config()
local _help = load_help()
local sudo_users = _config.Sudo_Users
local bot_owner = database:get("Bot:BotOwner")
local run = database:get("Bot:Run") or "True"
local bot_id = database:get("Bot:BotAccount") or tonumber(_redis.Bot_ID)
local is_sajjad_momen = function(user_id) --such a useless function
  local var = false
  if user_id == tonumber(sajjad_momen) then
    var = true
  end
  return var
end
local is_leader = function(user_id)
  local var = false
  if user_id == tonumber(bot_owner) then
    var = true
  end
  if user_id == tonumber(iNaji) then
    var = true
  end
  return var
end
local is_sudo = function(user_id)
  local var = false
  if database:sismember("Bot:SudoUsers", user_id) then
    var = true
  end
  if user_id == tonumber(bot_owner) then
    var = true
  end
  return var
end
local is_admin = function(user_id)
  local var = false
  local hashsb = "Bot:Admins"
  local admin = database:sismember(hashsb, user_id)
  if admin then
    var = true
  end
  if database:sismember("Bot:SudoUsers", user_id) then
    var = true
  end
  if user_id == tonumber(bot_owner) then
    var = true
  end
  if user_id == tonumber(iNaji) then
    var = true
  end
  return var
end
local is_owner = function(user_id, chat_id)
  local var = false
  local hash = "bot:owners:" .. chat_id
  local owner = database:sismember(hash, user_id)
  local hashs = "Bot:Admins"
  local admin = database:sismember(hashs, user_id)
  if owner then
    var = true
  end
  if admin then
    var = true
  end
  if database:sismember("Bot:SudoUsers", user_id) then
    var = true
  end
  if user_id == tonumber(bot_owner) then
    var = true
  end
  if user_id == tonumber(iNaji) then
    var = true
  end
  return var
end
local is_momod = function(user_id, chat_id)
  local var = false
  local hash = "bot:momod:" .. chat_id
  local momod = database:sismember(hash, user_id)
  local hashs = "Bot:Admins"
  local admin = database:sismember(hashs, user_id)
  local hashss = "bot:owners:" .. chat_id
  local owner = database:sismember(hashss, user_id)
  local our_id = database:get("Our_ID") or 0
  if momod then
    var = true
  end
  if owner then
    var = true
  end
  if admin then
    var = true
  end
  if database:sismember("Bot:SudoUsers", user_id) then
    var = true
  end
  if user_id == tonumber(bot_owner) then
    var = true
  end
  if user_id == tonumber(iNaji) then
    var = true
  end
  if user_id == tonumber(our_id) then
    var = true
  end
  return var
end
local is_vipmem = function(user_id, chat_id)
  local var = false
  local hash = "bot:momod:" .. chat_id
  local momod = database:sismember(hash, user_id)
  local hashs = "Bot:Admins"
  local admin = database:sismember(hashs, user_id)
  local hashss = "bot:owners:" .. chat_id
  local owner = database:sismember(hashss, user_id)
  local hashsss = "bot:vipmem:" .. chat_id
  local vipmem = database:sismember(hashsss, user_id)
  if vipmem then
    var = true
  end
  if momod then
    var = true
  end
  if owner then
    var = true
  end
  if admin then
    var = true
  end
  if database:sismember("Bot:SudoUsers", user_id) then
    var = true
  end
  if user_id == tonumber(bot_owner) then
    var = true
  end
  if user_id == tonumber(iNaji) then
    var = true
  end
  return var
end
local is_ReqMenu = function(user_id, chat_id)
  local var = false
  local a = "ReqMenu:" .. user_id
  if database:get(a) then
    hash = "ReqMenu:" .. user_id
  else
    hash = "ReqMenu:" .. chat_id .. ":" .. user_id
  end
  local user = database:get(hash)
  function ex(hash)
    database:setex(hash, 160, true)
  end
  if user then
    var = true
    ex(hash)
  end
  return var
end
local is_bot = function(user_id)
  local var = false
  if user_id == tonumber(bot_id) then
    var = true
  end
  return var
end
local having_access = function(user_id, chat, Q_id)
  local var = false
  if is_momod(user_id, chat) and is_ReqMenu(user_id, chat) then
    var = true
  end
  if not is_ReqMenu(user_id, chat) and is_momod(user_id, chat) then
    if database:get("lang:gp:" .. chat) then
      Canswer(Q_id, "• You Have Not Requested This Menu !")
    else
      Canswer(Q_id, "• شما این فهرست را درخواست نکرده اید !")
    end
  end
  if not is_momod(user_id, chat) then
    if database:get("lang:gp:" .. chat) then
      Canswer(Q_id, "• You Do Not Have Access To Make Changes !")
    else
      Canswer(Q_id, "• شما دسترسی به انجام تغییرات ندارید !")
    end
  end
  return var
end
local start = function()
  while true do
    local updates = getUpdates()
    --vardump(updates)
    if updates and updates.result then
      for i = 1, #updates.result do
        local msg = updates.result[i]
        offset = msg.update_id + 1
        if msg.inline_query then
          local Q = msg.inline_query
          if Q.query:match("^-(%d+,%S+)") then
            local chat = "-" .. Q.query:match("(%d+)")
            local lang = Q.query:match(",%S+")
            lang = lang:gsub(",", "")
            lang = lang:match("Fa") or lang:match("En")
            if lang == "Fa" then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "[ تنظیمات گروه •]",
                    callback_data = "GroupSettingsFa:" .. chat
                  }
                },
                {
                  {
                    text = "[ اطلاعات گروه •]",
                    callback_data = "GroupInfoFa:" .. chat
                  }
                },
                {
                  {
                    text = "[ پشتیبانی •]",
                    callback_data = "SupportFa:" .. chat
                  }
                },
                {
                  {
                    text = "[•• بستن فهرست ••]",
                    callback_data = "ExitFa:" .. chat
                  }
                }
              }
              answer(Q.id, "settings", "Menu", chat, "• بخش مورد نظر خود را انتخاب کنید :", keyboard)
            elseif lang == "En" then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "[• Grop settings ]",
                    callback_data = "GroupSettingsEn:" .. chat
                  }
                },
                {
                  {
                    text = "[• Group Info ]",
                    callback_data = "GroupInfoEn:" .. chat
                  }
                },
                {
                  {
                    text = "[• Support ]",
                    callback_data = "SupportEn:" .. chat
                  }
                },
                {
                  {
                    text = "[•• Close List ••]",
                    callback_data = "ExitEn:" .. chat
                  }
                }
              }
              answer(Q.id, "settings", "Menu", chat, "• Choose Your Desired Section :", keyboard)
            end
          end
        end
        if msg.callback_query then
          local Q = msg.callback_query
          local chat = "-" .. Q.data:match("(%d+)") or ""
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("LockFa") then
              if Q.data:match("Strict") then
                local hash = "bot:strict" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• حالت سختگیرانه " .. status
                Q.data = "GroupModeFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("All") then
                local hash = "bot:muteall" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• حالت قفل کلی گروه " .. status
                Q.data = "GroupModeFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Cmd") then
                local hash = "bot:cmds" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• حالت عدم جواب " .. status
                Q.data = "GroupModeFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Auto") then
                local hash = "bot:muteall:Time" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                elseif database:get("bot:muteall:start" .. chat) and database:get("bot:muteall:stop" .. chat) then
                  database:set(hash, true)
                  status = "فعال شد !"
                else
                  Canswer(Q.id, "• ابتدا با دستور Settime قفل خودکار را تنظیم نمایید !")
                end
                if status then
                  result = "• حالت قفل خودکار " .. status
                  Q.data = "GroupModeFa:" .. chat
                  Canswer(Q.id, result)
                end
              end
              if Q.data:match("Spam") then
                local hash = "bot:spam:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل اسپم " .. status
                Q.data = "GroupCentPageOneFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Links") then
                local hash = "bot:links:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل لیتک " .. status
                Q.data = "GroupCentPageOneFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("WebPage") then
                local hash = "bot:webpage:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل آدرس اینترنتی " .. status
                Q.data = "GroupCentPageOneFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Tag") then
                local hash = "tags:lock" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل تگ " .. status
                Q.data = "GroupCentPageOneFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Hashtag") then
                local hash = "bot:hashtag:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل هشتگ " .. status
                Q.data = "GroupCentPageOneFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Forward") then
                local hash = "bot:forward:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل فروارد " .. status
                Q.data = "GroupCentPageOneFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("DupliPost") then
                local hash = "bot:duplipost:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل پست تکراری " .. status
                Q.data = "GroupCentPageOneFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Bots") then
                local hash = "bot:bots:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل ربات " .. status
                Q.data = "GroupCentPageOneFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Edit") then
                local hash = "editmsg" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل ویرایش " .. status
                Q.data = "GroupCentPageOneFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Pin") then
                local hash = "bot:pin:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل سنجاق " .. status
                Q.data = "GroupCentPageTwoFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Inline") then
                local hash = "bot:inline:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل دکمه شیشه ای " .. status
                Q.data = "GroupCentPageTwoFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Farsi") then
                local hash = "bot:arabic:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل نوشتار فارسی " .. status
                Q.data = "GroupCentPageTwoFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("English") then
                local hash = "bot:english:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل نوشتار انگلیسی " .. status
                Q.data = "GroupCentPageTwoFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("MarkDown") then
                local hash = "markdown:lock" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل مدل نشانه گذاری " .. status
                Q.data = "GroupCentPageTwoFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Post") then
                local hash = "post:lock" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل پست " .. status
                Q.data = "GroupCentPageTwoFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Game") then
                local hash = "Game:lock" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل بازی " .. status
                Q.data = "GroupCentPageTwoFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Member") then
                local hash = "bot:member:lock" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل ورود عضو جدید " .. status
                Q.data = "GroupCentPageTwoFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Tgservice") then
                local hash = "bot:tgservice:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل سرویس تلگرام " .. status
                Q.data = "GroupCentPageTwoFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Flood") then
                local hash = "anti-flood:" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل فلود " .. status
                Q.data = "GroupCentPageThreeFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Text") then
                local hash = "bot:text:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل متن " .. status
                Q.data = "GroupMediaFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Photo") then
                local hash = "bot:photo:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل عکس " .. status
                Q.data = "GroupMediaFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Video") then
                local hash = "bot:video:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل فیلم " .. status
                Q.data = "GroupMediaFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("SelfFilm") then
                local hash = "bot:selfvideo:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل فیلم سلفی " .. status
                Q.data = "GroupMediaFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Music") then
                local hash = "bot:music:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل آهنگ " .. status
                Q.data = "GroupMediaFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Voice") then
                local hash = "bot:voice:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل ویس " .. status
                Q.data = "GroupMediaFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("File") then
                local hash = "bot:document:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل فایل " .. status
                Q.data = "GroupMediaFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Sticker") then
                local hash = "bot:sticker:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل استیکر " .. status
                Q.data = "GroupMediaFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Gifs") then
                local hash = "bot:gifs:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل گیف " .. status
                Q.data = "GroupMediaFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Contacts") then
                local hash = "bot:contact:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل مخاطبین " .. status
                Q.data = "GroupMediaFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Location") then
                local hash = "bot:location:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "غیرفعال شد !"
                else
                  database:set(hash, true)
                  status = "فعال شد !"
                end
                result = "• قفل موقعیت مکانی " .. status
                Q.data = "GroupMediaFa:" .. chat
                Canswer(Q.id, result)
              end
            elseif Q.data:match("LockEn") then
              if Q.data:match("Spam") then
                local hash = "bot:spam:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock Spam " .. status
                Q.data = "GroupCentPageOneEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Links") then
                local hash = "bot:links:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock Links " .. status
                Q.data = "GroupCentPageOneEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("WebPage") then
                local hash = "bot:webpage:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock WebPage " .. status
                Q.data = "GroupCentPageOneEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Tag") then
                local hash = "tags:lock" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock Tag " .. status
                Q.data = "GroupCentPageOneEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Hashtag") then
                local hash = "bot:hashtag:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock Hashtag " .. status
                Q.data = "GroupCentPageOneEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Forward") then
                local hash = "bot:forward:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock Forward " .. status
                Q.data = "GroupCentPageOneEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("DupliPost") then
                local hash = "bot:duplipost:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock DupliPost " .. status
                Q.data = "GroupCentPageOneEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Bots") then
                local hash = "bot:bots:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock Bots " .. status
                Q.data = "GroupCentPageOneEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Edit") then
                local hash = "editmsg" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock Edit " .. status
                Q.data = "GroupCentPageOneEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Pin") then
                local hash = "bot:pin:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock Pin " .. status
                Q.data = "GroupCentPageTwoEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Inline") then
                local hash = "bot:inline:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock Inline " .. status
                Q.data = "GroupCentPageTwoEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Farsi") then
                local hash = "bot:arabic:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock Farsi " .. status
                Q.data = "GroupCentPageTwoEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("English") then
                local hash = "bot:english:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock English " .. status
                Q.data = "GroupCentPageTwoEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("MarkDown") then
                local hash = "markdown:lock" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock Markdown " .. status
                Q.data = "GroupCentPageTwoEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Post") then
                local hash = "post:lock" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock Post " .. status
                Q.data = "GroupCentPageTwoEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Game") then
                local hash = "Game:lock" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock Game " .. status
                Q.data = "GroupCentPageTwoEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Member") then
                local hash = "bot:member:lock" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock Member " .. status
                Q.data = "GroupCentPageTwoEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Tgservice") then
                local hash = "bot:tgservice:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock Tgservice " .. status
                Q.data = "GroupCentPageTwoEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Flood") then
                local hash = "anti-flood:" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock Flood " .. status
                Q.data = "GroupCentPageThreeEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Text") then
                local hash = "bot:text:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock Text " .. status
                Q.data = "GroupMediaEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Photo") then
                local hash = "bot:photo:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock Photo " .. status
                Q.data = "GroupMediaEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Video") then
                local hash = "bot:video:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock Video " .. status
                Q.data = "GroupMediaEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("SelfFilm") then
                local hash = "bot:selfvideo:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock Self Video " .. status
                Q.data = "GroupMediaEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Music") then
                local hash = "bot:music:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock Music " .. status
                Q.data = "GroupMediaEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Voice") then
                local hash = "bot:voice:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock Voice " .. status
                Q.data = "GroupMediaEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("File") then
                local hash = "bot:document:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock File " .. status
                Q.data = "GroupMediaEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Sticker") then
                local hash = "bot:sticker:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock Sticker " .. status
                Q.data = "GroupMediaEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Gifs") then
                local hash = "bot:gifs:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock Gif " .. status
                Q.data = "GroupMediaEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Contacts") then
                local hash = "bot:contact:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock Contacts" .. status
                Q.data = "GroupMediaEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Location") then
                local hash = "bot:location:mute" .. chat
                if database:get(hash) then
                  database:del(hash)
                  status = "Has Been Disabled !"
                else
                  database:set(hash, true)
                  status = "Has Been Activated !"
                end
                result = "• Lock Location" .. status
                Q.data = "GroupMediaEn:" .. chat
                Canswer(Q.id, result)
              end
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("SensFa") then
              if Q.data:match("FloodMax") then
                Canswer(Q.id, "• از دکمه های پایین برای تنظیم حساسیت فلود استفاده کنید !")
              end
              if Q.data:match("Spam") then
                Canswer(Q.id, "• از دکمه های پایین برای تنظیم حساسیت اسپم استفاده کنید !")
              end
              if Q.data:match("Warn") then
                Canswer(Q.id, "• از دکمه های پایین برای تنظیم حساسیت اخطار استفاده کنید !")
              end
            elseif Q.data:match("SensEn") then
              if Q.data:match("FloodMax") then
                Canswer(Q.id, "• Use The Down Buttons To Set Flood Sensitivity !")
              end
              if Q.data:match("Spam") then
                Canswer(Q.id, "• Use The Down Buttons To Set Spam Sensitivity !")
              end
              if Q.data:match("Warn") then
                Canswer(Q.id, "• Use The Down Buttons To Set Warn Sensitivity !")
              end
            end
          end
          if Q.data:match("SensUpOneFa") then
            if having_access(Q.from.id, chat, Q.id) and Q.data:match("FloodMax") then
              if not database:get("flood:max:" .. chat) then
                flood_m = 5
              else
                flood_m = tonumber(database:get("flood:max:" .. chat))
              end
              local res = flood_m + 1
              if not (res > 20) then
                database:set("flood:max:" .. chat, res)
                result = "• حساسیت فلود بر روی " .. res .. " تنظیم شد !"
                Q.data = "GroupCentPageThreeFa:" .. chat
                Canswer(Q.id, result)
              else
                Canswer(Q.id, "• حداکثر حساسیت فلود 20 میباشد !")
              end
            end
            if having_access(Q.from.id, chat, Q.id) and Q.data:match("Spam") then
              if not database:get("bot:sens:spam" .. chat) then
                spam_c = 400
              else
                spam_c = tonumber(database:get("bot:sens:spam" .. chat))
              end
              local res = spam_c + 25
              if not (res > 4000) then
                database:set("bot:sens:spam" .. chat, res)
                result = "• حساسیت اسپم بر روی " .. res .. " تنظیم شد !"
                Q.data = "GroupCentPageThreeFa:" .. chat
                Canswer(Q.id, result)
              else
                Canswer(Q.id, "• حداکثر حساسیت اسپم 4000 میباشد !")
              end
            end
            if having_access(Q.from.id, chat, Q.id) and Q.data:match("Warn") then
              if database:get("warn:max:" .. chat) then
                sencwarn = tonumber(database:get("warn:max:" .. chat))
              else
                sencwarn = 4
              end
              local res = sencwarn + 1
              if not (res > 30) then
                database:set("warn:max:" .. chat, res)
                result = "• حساسیت اخطار بر روی " .. res .. " تنظیم شد !"
                Q.data = "GroupCentPageThreeFa:" .. chat
                Canswer(Q.id, result)
              else
                Canswer(Q.id, "• حداکثر حساسیت اخطار 30 میباشد !")
              end
            end
          elseif Q.data:match("SensUpOneEn") then
            if having_access(Q.from.id, chat, Q.id) and Q.data:match("FloodMax") then
              if not database:get("flood:max:" .. chat) then
                flood_m = 5
              else
                flood_m = tonumber(database:get("flood:max:" .. chat))
              end
              local res = flood_m + 1
              if not (res > 20) then
                database:set("flood:max:" .. chat, res)
                result = "• Flood Sensitivity Was Set To " .. res .. " !"
                Q.data = "GroupCentPageThreeEn:" .. chat
                Canswer(Q.id, result)
              else
                Canswer(Q.id, "• The Maximum Flood Sensitivity is 20 !")
              end
            end
            if having_access(Q.from.id, chat, Q.id) and Q.data:match("Spam") then
              if not database:get("bot:sens:spam" .. chat) then
                spam_c = 400
              else
                spam_c = tonumber(database:get("bot:sens:spam" .. chat))
              end
              local res = spam_c + 25
              if not (res > 400) then
                database:set("bot:sens:spam" .. chat, res)
                result = "• Spam Sensitivity Was Set To " .. res .. " !"
                Q.data = "GroupCentPageThreeEn:" .. chat
                Canswer(Q.id, result)
              else
                Canswer(Q.id, "• Maximum Spam Sensitivity is 4000 !")
              end
            end
            if having_access(Q.from.id, chat, Q.id) and Q.data:match("Warn") then
              if database:get("warn:max:" .. chat) then
                sencwarn = tonumber(database:get("warn:max:" .. chat))
              else
                sencwarn = 4
              end
              local res = sencwarn + 1
              if not (res > 30) then
                database:set("warn:max:" .. chat, res)
                result = "• Warning Sensitivity Was Set To " .. res .. " !"
                Q.data = "GroupCentPageThreeEn:" .. chat
                Canswer(Q.id, result)
              else
                Canswer(Q.id, "• The Maximum Warning Sensitivity is 30 !")
              end
            end
          end
          if Q.data:match("SensUpTwoFa") then
            if having_access(Q.from.id, chat, Q.id) and Q.data:match("FloodMax") then
              if not database:get("flood:max:" .. chat) then
                flood_m = 5
              else
                flood_m = tonumber(database:get("flood:max:" .. chat))
              end
              local res = flood_m + 5
              if not (res > 20) then
                database:set("flood:max:" .. chat, res)
                result = "• حساسیت فلود بر روی " .. res .. " تنظیم شد !"
                Q.data = "GroupCentPageThreeFa:" .. chat
                Canswer(Q.id, result)
              else
                Canswer(Q.id, "• حداکثر حساسیت فلود 20 میباشد !")
              end
            end
            if having_access(Q.from.id, chat, Q.id) and Q.data:match("Spam") then
              if not database:get("bot:sens:spam" .. chat) then
                spam_c = 400
              else
                spam_c = tonumber(database:get("bot:sens:spam" .. chat))
              end
              local res = spam_c + 100
              if not (res > 4000) then
                database:set("bot:sens:spam" .. chat, res)
                result = "• حساسیت اسپم بر روی " .. res .. " تنظیم شد !"
                Q.data = "GroupCentPageThreeFa:" .. chat
                Canswer(Q.id, result)
              else
                Canswer(Q.id, "• حداکثر حساسیت اسپم 4000 میباشد !")
              end
            end
            if having_access(Q.from.id, chat, Q.id) and Q.data:match("Warn") then
              if database:get("warn:max:" .. chat) then
                sencwarn = tonumber(database:get("warn:max:" .. chat))
              else
                sencwarn = 4
              end
              local res = sencwarn + 5
              if not (res > 30) then
                database:set("warn:max:" .. chat, res)
                result = "• حساسیت اخطار بر روی " .. res .. " تنظیم شد !"
                Q.data = "GroupCentPageThreeFa:" .. chat
                Canswer(Q.id, result)
              else
                Canswer(Q.id, "• حداکثر حساسیت اخطار 30 میباشد !")
              end
            end
          elseif Q.data:match("SensUpTwoEn") then
            if having_access(Q.from.id, chat, Q.id) and Q.data:match("FloodMax") then
              if not database:get("flood:max:" .. chat) then
                flood_m = 5
              else
                flood_m = tonumber(database:get("flood:max:" .. chat))
              end
              local res = flood_m + 5
              if not (res > 20) then
                database:set("flood:max:" .. chat, res)
                result = "• Flood Sensitivity Was Set To " .. res .. " !"
                Q.data = "GroupCentPageThreeEn:" .. chat
                Canswer(Q.id, result)
              else
                Canswer(Q.id, "• The Maximum Flood Sensitivity is 20 !")
              end
            end
            if having_access(Q.from.id, chat, Q.id) and Q.data:match("Spam") then
              if not database:get("bot:sens:spam" .. chat) then
                spam_c = 400
              else
                spam_c = tonumber(database:get("bot:sens:spam" .. chat))
              end
              local res = spam_c + 100
              if not (res > 4000) then
                database:set("bot:sens:spam" .. chat, res)
                result = "• Spam Sensitivity Was Set To " .. res .. " !"
                Q.data = "GroupCentPageThreeEn:" .. chat
                Canswer(Q.id, result)
              else
                Canswer(Q.id, "• Maximum Spam Sensitivity is 4000 !")
              end
            end
            if having_access(Q.from.id, chat, Q.id) and Q.data:match("Warn") then
              if database:get("warn:max:" .. chat) then
                sencwarn = tonumber(database:get("warn:max:" .. chat))
              else
                sencwarn = 4
              end
              local res = sencwarn + 5
              if not (res > 30) then
                database:set("warn:max:" .. chat, res)
                result = "• Warning Sensitivity Was Set To " .. res .. " !"
                Q.data = "GroupCentPageThreeEn:" .. chat
                Canswer(Q.id, result)
              else
                Canswer(Q.id, "• The Maximum Warning Sensitivity is 30 !")
              end
            end
          end
          if Q.data:match("SensDownOneFa") then
            if having_access(Q.from.id, chat, Q.id) and Q.data:match("FloodMax") then
              if not database:get("flood:max:" .. chat) then
                flood_m = 5
              else
                flood_m = tonumber(database:get("flood:max:" .. chat))
              end
              local res = flood_m - 1
              if not (res < 3) then
                database:set("flood:max:" .. chat, res)
                result = "• حساسیت فلود بر روی " .. res .. " تنظیم شد !"
                Q.data = "GroupCentPageThreeFa:" .. chat
                Canswer(Q.id, result)
              else
                Canswer(Q.id, "• حداقل حساسیت فلود 3 میباشد !")
              end
            end
            if having_access(Q.from.id, chat, Q.id) and Q.data:match("Spam") then
              if not database:get("bot:sens:spam" .. chat) then
                spam_c = 400
              else
                spam_c = tonumber(database:get("bot:sens:spam" .. chat))
              end
              local res = spam_c - 25
              if not (res < 50) then
                database:set("bot:sens:spam" .. chat, res)
                result = "• حساسیت اسپم بر روی " .. res .. " تنظیم شد !"
                Q.data = "GroupCentPageThreeFa:" .. chat
                Canswer(Q.id, result)
              else
                Canswer(Q.id, "• حداقل حساسیت اسپم 50 میباشد !")
              end
            end
            if having_access(Q.from.id, chat, Q.id) and Q.data:match("Warn") then
              if database:get("warn:max:" .. chat) then
                sencwarn = tonumber(database:get("warn:max:" .. chat))
              else
                sencwarn = 4
              end
              local res = sencwarn - 1
              if not (res < 2) then
                database:set("warn:max:" .. chat, res)
                result = "• حساسیت اخطار بر روی " .. res .. " تنظیم شد !"
                Q.data = "GroupCentPageThreeFa:" .. chat
                Canswer(Q.id, result)
              else
                Canswer(Q.id, "• حداقل حساسیت اخطار 2 میباشد !")
              end
            end
          elseif Q.data:match("SensDownOneEn") then
            if having_access(Q.from.id, chat, Q.id) and Q.data:match("FloodMax") then
              if not database:get("flood:max:" .. chat) then
                flood_m = 5
              else
                flood_m = tonumber(database:get("flood:max:" .. chat))
              end
              local res = flood_m - 1
              if not (res < 3) then
                database:set("flood:max:" .. chat, res)
                result = "• Flood Sensitivity Was Set To " .. res .. " !"
                Q.data = "GroupCentPageThreeEn:" .. chat
                Canswer(Q.id, result)
              else
                Canswer(Q.id, "• Minimum The Sensitivity of Flood is 3 !")
              end
            end
            if having_access(Q.from.id, chat, Q.id) and Q.data:match("Spam") then
              if not database:get("bot:sens:spam" .. chat) then
                spam_c = 400
              else
                spam_c = tonumber(database:get("bot:sens:spam" .. chat))
              end
              local res = spam_c - 25
              if not (res < 50) then
                database:set("bot:sens:spam" .. chat, res)
                result = "• Spam Sensitivity Was Set To " .. res .. " !"
                Q.data = "GroupCentPageThreeEn:" .. chat
                Canswer(Q.id, result)
              else
                Canswer(Q.id, "• Minimum The Sensitivity of Spam is 3 !")
              end
            end
            if having_access(Q.from.id, chat, Q.id) and Q.data:match("Warn") then
              if database:get("warn:max:" .. chat) then
                sencwarn = tonumber(database:get("warn:max:" .. chat))
              else
                sencwarn = 4
              end
              local res = sencwarn - 1
              if not (res < 2) then
                database:set("warn:max:" .. chat, res)
                result = "• Warning Sensitivity Was Set To " .. res .. " !"
                Q.data = "GroupCentPageThreeEn:" .. chat
                Canswer(Q.id, result)
              else
                Canswer(Q.id, "• Minimum The Sensitivity of Warn is 2 !")
              end
            end
          end
          if Q.data:match("SensDownTwoFa") then
            if having_access(Q.from.id, chat, Q.id) and Q.data:match("FloodMax") then
              if not database:get("flood:max:" .. chat) then
                flood_m = 5
              else
                flood_m = tonumber(database:get("flood:max:" .. chat))
              end
              local res = flood_m - 5
              if not (res < 3) then
                database:set("flood:max:" .. chat, res)
                result = "• حساسیت فلود بر روی " .. res .. " تنظیم شد !"
                Q.data = "GroupCentPageThreeFa:" .. chat
                Canswer(Q.id, result)
              else
                Canswer(Q.id, "• حداقل حساسیت فلود 3 میباشد !")
              end
            end
            if having_access(Q.from.id, chat, Q.id) and Q.data:match("Spam") then
              if not database:get("bot:sens:spam" .. chat) then
                spam_c = 400
              else
                spam_c = tonumber(database:get("bot:sens:spam" .. chat))
              end
              local res = spam_c - 100
              if not (res < 50) then
                database:set("bot:sens:spam" .. chat, res)
                result = "• حساسیت اسپم بر روی " .. res .. " تنظیم شد !"
                Q.data = "GroupCentPageThreeFa:" .. chat
                Canswer(Q.id, result)
              else
                Canswer(Q.id, "• حداقل حساسیت اسپم 50 میباشد !")
              end
            end
            if having_access(Q.from.id, chat, Q.id) and Q.data:match("Warn") then
              if database:get("warn:max:" .. chat) then
                sencwarn = tonumber(database:get("warn:max:" .. chat))
              else
                sencwarn = 4
              end
              local res = sencwarn - 5
              if not (res < 2) then
                database:set("warn:max:" .. chat, res)
                result = "• حساسیت اخطار بر روی " .. res .. " تنظیم شد !"
                Q.data = "GroupCentPageThreeFa:" .. chat
                Canswer(Q.id, result)
              else
                Canswer(Q.id, "• حداقل حساسیت اخطار 2 میباشد !")
              end
            end
          elseif Q.data:match("SensDownTwoEn") then
            if having_access(Q.from.id, chat, Q.id) and Q.data:match("FloodMax") then
              if not database:get("flood:max:" .. chat) then
                flood_m = 5
              else
                flood_m = tonumber(database:get("flood:max:" .. chat))
              end
              local res = flood_m - 5
              if not (res < 3) then
                database:set("flood:max:" .. chat, res)
                result = "• Flood Sensitivity Was Set To " .. res .. " !"
                Q.data = "GroupCentPageThreeEn:" .. chat
                Canswer(Q.id, result)
              else
                Canswer(Q.id, "• Minimum The Sensitivity of Flood is 3 !")
              end
            end
            if having_access(Q.from.id, chat, Q.id) and Q.data:match("Spam") then
              if not database:get("bot:sens:spam" .. chat) then
                spam_c = 400
              else
                spam_c = tonumber(database:get("bot:sens:spam" .. chat))
              end
              local res = spam_c - 100
              if not (res < 50) then
                database:set("bot:sens:spam" .. chat, res)
                result = "• Spam Sensitivity Was Set To " .. res .. " !"
                Q.data = "GroupCentPageThreeEn:" .. chat
                Canswer(Q.id, result)
              else
                Canswer(Q.id, "• Minimum The Sensitivity of Spam is 3 !")
              end
            end
            if having_access(Q.from.id, chat, Q.id) and Q.data:match("Warn") then
              if database:get("warn:max:" .. chat) then
                sencwarn = tonumber(database:get("warn:max:" .. chat))
              else
                sencwarn = 4
              end
              local res = sencwarn - 5
              if not (res < 2) then
                database:set("warn:max:" .. chat, res)
                result = "• Warning Sensitivity Was Set To " .. res .. " !"
                Q.data = "GroupCentPageThreeEn:" .. chat
                Canswer(Q.id, result)
              else
                Canswer(Q.id, "• Minimum The Sensitivity of Warn is 2 !")
              end
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("StatusFa") then
              if Q.data:match("Flood") then
                if database:get("floodstatus" .. chat) == "DelMsg" then
                  floodstatus = "اخراج"
                  res = "Kicked"
                elseif database:get("floodstatus" .. chat) == "Kicked" then
                  floodstatus = "حذف پیام"
                  res = "DelMsg"
                elseif not database:get("floodstatus" .. chat) then
                  floodstatus = "اخراج"
                  res = "Kicked"
                end
                database:set("floodstatus" .. chat, res)
                result = "• وضعیت فلود بر روی حالت " .. floodstatus .. " تنظیم شد !"
                Q.data = "GroupCentPageThreeFa:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Warn") then
                if database:get("warnstatus" .. chat) == "Muteuser" then
                  warnstatus = "اخراج"
                  res = "Remove"
                elseif database:get("warnstatus" .. chat) == "Remove" then
                  warnstatus = "بی صدا"
                  res = "Muteuser"
                elseif not database:get("warnstatus" .. chat) then
                  warnstatus = "اخراج"
                  res = "Remove"
                end
                database:set("warnstatus" .. chat, res)
                result = "• وضعیت اخطار بر روی حالت " .. warnstatus .. " تنظیم شد !"
                Q.data = "GroupCentPageThreeFa:" .. chat
                Canswer(Q.id, result)
              end
            elseif Q.data:match("StatusEn") then
              if Q.data:match("Flood") then
                if database:get("floodstatus" .. chat) == "DelMsg" then
                  floodstatus = "Kicking"
                  res = "Kicked"
                elseif database:get("floodstatus" .. chat) == "Kicked" then
                  floodstatus = "Deleting"
                  res = "DelMsg"
                elseif not database:get("floodstatus" .. chat) then
                  floodstatus = "Kicking"
                  res = "Kicked"
                end
                database:set("floodstatus" .. chat, res)
                result = "• Flood Status Has Been Change To " .. floodstatus .. " !"
                Q.data = "GroupCentPageThreeEn:" .. chat
                Canswer(Q.id, result)
              end
              if Q.data:match("Warn") then
                if database:get("warnstatus" .. chat) == "Muteuser" then
                  warnstatus = "Remove"
                  res = "Remove"
                elseif database:get("warnstatus" .. chat) == "Remove" then
                  warnstatus = "Muteuser"
                  res = "Muteuser"
                elseif not database:get("warnstatus" .. chat) then
                  warnstatus = "Remove"
                  res = "Remove"
                end
                database:set("warnstatus" .. chat, res)
                result = "• Warn Status Has Been Change To " .. warnstatus .. " !"
                Q.data = "GroupCentPageThreeEn:" .. chat
                Canswer(Q.id, result)
              end
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("CleanModListFa") then
              database:del("bot:momod:" .. chat)
              result = "• لیست مدیران گروه پاکسازی شد !"
              Q.data = "ModlistFa:" .. chat
              Canswer(Q.id, result)
            elseif Q.data:match("CleanModListEn") then
              database:del("bot:momod:" .. chat)
              result = "• Modlist has been Cleared !"
              Q.data = "ModlistEn:" .. chat
              Canswer(Q.id, result)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("UpdateModListFa") then
              result = "• لیست مدیران گروه بروزرسانی شد !"
              Q.data = "ModlistFa:" .. chat
              Canswer(Q.id, result)
            elseif Q.data:match("UpdateModListEn") then
              chat = "-" .. Q.data:match("(%d+)$")
              result = "• Modlist Has Been Updated !"
              Q.data = "ModlistEn:" .. chat
              Canswer(Q.id, result)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("CleanBanListFa") then
              database:del("bot:banned:" .. chat)
              result = "• لیست افراد مسدود پاکسازی شد !"
              Q.data = "BanlistFa:" .. chat
              Canswer(Q.id, result)
            elseif Q.data:match("CleanBanListEn") then
              database:del("bot:banned:" .. chat)
              result = "• Banlist Has Been Cleared !"
              Q.data = "BanlistEn:" .. chat
              Canswer(Q.id, result)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("UpdateBanListFa") then
              result = "• لیست افراد مسدود بروزرسانی شد !"
              Q.data = "BanlistFa:" .. chat
              Canswer(Q.id, result)
            elseif Q.data:match("UpdateBanListEn") then
              result = "• Banlist Has Been Updated !"
              Q.data = "BanlistEn:" .. chat
              Canswer(Q.id, result)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("CleanFilterListFa") then
              database:del("bot:filters:" .. chat)
              result = "• لیست کلمات فیلتر شده پاکسازی شد !"
              Q.data = "FilterListFa:" .. chat
              Canswer(Q.id, result)
            elseif Q.data:match("CleanFilterListEn") then
              database:del("bot:filters:" .. chat)
              result = "• Filterlist Has Been Cleared !"
              Q.data = "FilterListEn:" .. chat
              Canswer(Q.id, result)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("UpdateFilterListFa") then
              result = "• لیست کلمات فیلتر شده بروزرسانی شد !"
              Q.data = "FilterListFa:" .. chat
              Canswer(Q.id, result)
            elseif Q.data:match("UpdateFilterListEn") then
              result = "• Filterlist Has Been Updated !"
              Q.data = "FilterListEn:" .. chat
              Canswer(Q.id, result)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("CleanMuteListFa") then
              database:del("bot:muted:" .. chat)
              result = "• لیست افراد بی صدا پاکسازی شد !"
              Q.data = "MutelistEn:" .. chat
              Canswer(Q.id, result)
            elseif Q.data:match("CleanMuteListEn") then
              database:del("bot:muted:" .. chat)
              result = "• MuteList Has Been Cleared !"
              Q.data = "MutelistEn:" .. chat
              Canswer(Q.id, result)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("UpdateMuteListFa") then
              result = "• لیست افراد بی صدا بروزرسانی شد !"
              Q.data = "MutelistEn:" .. chat
              Canswer(Q.id, result)
            elseif Q.data:match("UpdateMuteListEn") then
              result = "• MuteList Has Been Updated !"
              Q.data = "MutelistEn:" .. chat
              Canswer(Q.id, result)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("CleanRulesFa") then
              database:del("bot:rules" .. chat)
              result = "• قوانین گروه پاکسازی شد !"
              Q.data = "RulesFa:" .. chat
              Canswer(Q.id, result)
            elseif Q.data:match("CleanRulesEn") then
              database:del("bot:rules" .. chat)
              result = "• Rules Has Been Cleared !"
              Q.data = "RulesEn:" .. chat
              Canswer(Q.id, result)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("SetRulesFa") then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "بازگشت »",
                    callback_data = "GroupInfoFa:" .. chat
                  }
                }
              }
              edit(Q.inline_message_id, "• برای تنظیم قوانین از دستور Setrules استفاده نمایید !", keyboard)
            elseif Q.data:match("SetRulesEn") then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "« Back",
                    callback_data = "GroupInfoEn:" .. chat
                  }
                }
              }
              edit(Q.inline_message_id, "• Use the Setrules Command To Set Rules !", keyboard)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("CleanLinkFa") then
              database:del("bot:group:link" .. chat)
              result = "• لینک گروه پاکسازی شد !"
              Q.data = "GroupLinkFa:" .. chat
              Canswer(Q.id, result)
            elseif Q.data:match("CleanLinkEn") then
              database:del("bot:group:link" .. chat)
              result = "• Group Link Has Been Cleared !"
              Q.data = "GroupLinkEn:" .. chat
              Canswer(Q.id, result)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("CleanLinkFa") then
              result = "• لینک گروه بروزرسانی شد !"
              Q.data = "GroupLinkFa:" .. chat
              Canswer(Q.id, result)
            elseif Q.data:match("CleanLinkEn") then
              result = "• Group Link Has Been Updated !"
              Q.data = "GroupLinkEn:" .. chat
              Canswer(Q.id, result)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("SetLinkFa") then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "بازگشت »",
                    callback_data = "GroupInfoFa:" .. chat
                  }
                }
              }
              edit(Q.inline_message_id, "• برای تنظیم لینک از دستور <b>Setlink</b> استفاده نمایید !", keyboard)
            elseif Q.data:match("SetRulesEn") then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "« Back",
                    callback_data = "GroupInfoEn:" .. chat
                  }
                }
              }
              edit(Q.inline_message_id, "• Use the <b>Setlink</b> Command To Set Group Link !", keyboard)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("FirstMenuFa") then
              local keyboard = {}
              keyboard.inline_keyboard = {
                {
                  {
                    text = "• تنظیمات گروه",
                    callback_data = "GroupSettingsFa:" .. chat
                  }
                },
                {
                  {
                    text = "• اطلاعات گروه",
                    callback_data = "GroupInfoFa:" .. chat
                  }
                },
                {
                  {
                    text = "• پشتیبانی",
                    callback_data = "SupportFa:" .. chat
                  }
                },
                {
                  {
                    text = "○ خروج",
                    callback_data = "ExitFa:" .. chat
                  }
                }
              }
              edit(Q.inline_message_id, "• بخش مورد نظر خود را انتخاب کنید :", keyboard)
            elseif Q.data:match("FirstMenuEn") then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "• Group Settings",
                    callback_data = "GroupSettingsEn:" .. chat
                  }
                },
                {
                  {
                    text = "• Group Info",
                    callback_data = "GroupInfoEn:" .. chat
                  }
                },
                {
                  {
                    text = "• Support",
                    callback_data = "SupportEn:" .. chat
                  }
                },
                {
                  {
                    text = "○ Exit",
                    callback_data = "ExitEn:" .. chat
                  }
                }
              }
              edit(Q.inline_message_id, "• Choose Your Desired Section :", keyboard)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("GroupSettingsFa") then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "• حالت های گروه",
                    callback_data = "GroupModeFa:" .. chat
                  }
                },
                {
                  {
                    text = "• قفل های اصلی",
                    callback_data = "GroupCentPageOneFa:" .. chat
                  }
                },
                {
                  {
                    text = "• قفل های رسانه",
                    callback_data = "GroupMediaFa:" .. chat
                  }
                },
                {
                  {
                    text = "بازگشت »",
                    callback_data = "FirstMenuFa:" .. chat
                  }
                }
              }
              edit(Q.inline_message_id, "• بخش مورد نظر خود را انتخاب نمایید :", keyboard)
            elseif Q.data:match("GroupSettingsEn") then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "• Group Modes",
                    callback_data = "GroupModeEn:" .. chat
                  }
                },
                {
                  {
                    text = "• Centerial Locks",
                    callback_data = "GroupCentPageOneEn:" .. chat
                  }
                },
                {
                  {
                    text = "• Media Locks",
                    callback_data = "GroupMediaEn:" .. chat
                  }
                },
                {
                  {
                    text = "« Back",
                    callback_data = "FirstMenuEn:" .. chat
                  }
                }
              }
              edit(Q.inline_message_id, "• Choose Your Settings Desired Section :", keyboard)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("GroupInfoFa") then
              local keyboard = {}
              keyboard.inline_keyboard = {
                {
                  {
                    text = "• لیست صاحبان گروه",
                    callback_data = "OwnerlistFa:" .. chat
                  }
                },
                {
                  {
                    text = "• لیست مدیران گروه",
                    callback_data = "ModlistFa:" .. chat
                  }
                },
                {
                  {
                    text = "• لیست افراد مسدود",
                    callback_data = "BanlistFa:" .. chat
                  }
                },
                {
                  {
                    text = "• لیست فیلتر",
                    callback_data = "FilterListFa:" .. chat
                  }
                },
                {
                  {
                    text = "• لیست افراد بی صدا",
                    callback_data = "MutelistFa:" .. chat
                  }
                },
                {
                  {
                    text = "• مشاهده قوانین گروه",
                    callback_data = "RulesFa:" .. chat
                  }
                },
                {
                  {
                    text = "• مشاهده لینک گروه",
                    callback_data = "GroupLinkFa:" .. chat
                  }
                },
                {
                  {
                    text = "• مشاهده اعتبار گروه",
                    callback_data = "GroupChargeFa:" .. chat
                  }
                },
                {
                  {
                    text = "بازگشت »",
                    callback_data = "FirstMenuFa:" .. chat
                  }
                }
              }
              edit(Q.inline_message_id, "• بخش مورد نظر خود را انتخاب نمایید :", keyboard)
            elseif Q.data:match("GroupInfoEn") then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "• Owners List",
                    callback_data = "OwnerlistEn:" .. chat
                  }
                },
                {
                  {
                    text = "• Moderators List",
                    callback_data = "ModlistEn:" .. chat
                  }
                },
                {
                  {
                    text = "• Ban List",
                    callback_data = "BanlistEn:" .. chat
                  }
                },
                {
                  {
                    text = "• Filter List",
                    callback_data = "FilterListEn:" .. chat
                  }
                },
                {
                  {
                    text = "• Mute List",
                    callback_data = "MutelistEn:" .. chat
                  }
                },
                {
                  {
                    text = "• See Group Rules",
                    callback_data = "RulesEn:" .. chat
                  }
                },
                {
                  {
                    text = "• See Group Link",
                    callback_data = "GroupLinkEn:" .. chat
                  }
                },
                {
                  {
                    text = "• See Group Credit",
                    callback_data = "GroupChargeEn:" .. chat
                  }
                },
                {
                  {
                    text = "« Back",
                    callback_data = "FirstMenuEn:" .. chat
                  }
                }
              }
              edit(Q.inline_message_id, "• Choose Your Desired Section :", keyboard)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("SupportFa") then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "• دست اندرکاران",
                    callback_data = "AuthoritiesFa:" .. chat
                  }
                },
                {
                  {
                    text = "• ارتباط",
                    callback_data = "SupportLinkFa:" .. chat
                  }
                },
                {
                  {
                    text = "• گزارش مشکل",
                    callback_data = "ReportFa:" .. chat
                  }
                },
                {
                  {
                    text = "بازگشت »",
                    callback_data = "FirstMenuFa:" .. chat
                  }
                }
              }
              edit(Q.inline_message_id, "• بخش مورد نظر خود را انتخاب نمایید :", keyboard)
            elseif Q.data:match("SupportEn") then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "• Authorities",
                    callback_data = "AuthoritiesEn:" .. chat
                  }
                },
                {
                  {
                    text = "• Relationship",
                    callback_data = "SupportLinkEn:" .. chat
                  }
                },
                {
                  {
                    text = "• Report Problem",
                    callback_data = "ReportEn:" .. chat
                  }
                },
                {
                  {
                    text = "« Back",
                    callback_data = "FirstMenuEn:" .. chat
                  }
                }
              }
              edit(Q.inline_message_id, "• Choose Your Desired Section :", keyboard)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("HelpFa") then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "• راهنمای دستورات صاحب گروه",
                    callback_data = "HelpOwnerFa:" .. chat
                  }
                },
                {
                  {
                    text = "• راهنمای دستورات مدیر گروه",
                    callback_data = "HelpModFa:" .. chat
                  }
                },
                {
                  {
                    text = "• راهنمای دستورات تفریحی و عمومی",
                    callback_data = "HelpFunFa:" .. chat
                  }
                },
                {
                  {
                    text = "بازگشت »",
                    callback_data = "FirstMenuFa:" .. chat
                  }
                }
              }
              edit(Q.inline_message_id, "• بخش مورد نظر خود را انتخاب نمایید :", keyboard)
            elseif Q.data:match("HelpEn") then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "• Group Owner's Guide",
                    callback_data = "HelpOwnerEn:" .. chat
                  }
                },
                {
                  {
                    text = "• Group Manager's Guide",
                    callback_data = "HelpModEn:" .. chat
                  }
                },
                {
                  {
                    text = "• General Guidelines Guide",
                    callback_data = "HelpFunEn:" .. chat
                  }
                },
                {
                  {
                    text = "« Back",
                    callback_data = "FirstMenuEn:" .. chat
                  }
                }
              }
              edit(Q.inline_message_id, "• Choose Your Desired Section :", keyboard)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("ExitFa") then
              edit(Q.inline_message_id, "• فهرست بسته شد !", nil)
            elseif Q.data:match("ExitEn") then
              edit(Q.inline_message_id, "• Menu Has Been Closed !", nil)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("GroupModeFa") then
              local hash1 = database:get("bot:strict" .. chat)
              local hash2 = database:get("bot:muteall" .. chat)
              local hash3 = database:get("bot:cmds" .. chat)
              local hash4 = database:get("bot:muteall:Time" .. chat)
              if hash1 then
                strict = "فعال"
              else
                strict = "غیرفعال"
              end
              if hash2 then
                all = "فعال"
              else
                all = "غیرفعال"
              end
              if hash3 then
                cmd = "فعال"
              else
                cmd = "غیرفعال"
              end
              if hash4 then
                auto = "فعال"
              else
                auto = "غیرفعال"
              end
              keyboard.inline_keyboard = {
                {
                  {
                    text = "• حالت سختگیرانه : " .. strict,
                    callback_data = "LockFa Strict:" .. chat
                  }
                },
                {
                  {
                    text = "• حالت قفل کلی گروه : " .. all,
                    callback_data = "LockFa All:" .. chat
                  }
                },
                {
                  {
                    text = "• حالت عدم جواب : " .. cmd,
                    callback_data = "LockFa Cmd:" .. chat
                  }
                },
                {
                  {
                    text = "• حالت قفل خودکار : " .. auto,
                    callback_data = "LockFa Auto:" .. chat
                  }
                },
                {
                  {
                    text = "بازگشت »",
                    callback_data = "GroupSettingsFa:" .. chat
                  }
                }
              }
              edit(Q.inline_message_id, "• حالت های گروه  :", keyboard)
            elseif Q.data:match("GroupModeEn") then
              local hash1 = database:get("bot:strict" .. chat)
              local hash2 = database:get("bot:muteall" .. chat)
              local hash3 = database:get("bot:cmds" .. chat)
              local hash4 = database:get("bot:muteall:Time" .. chat)
              if hash1 then
                strict = "Active"
              else
                strict = "Inactive"
              end
              if hash2 then
                all = "Active"
              else
                all = "Inactive"
              end
              if hash3 then
                cmd = "Active"
              else
                cmd = "Inactive"
              end
              if hash4 then
                auto = "Active"
              else
                auto = "Inactive"
              end
              keyboard.inline_keyboard = {
                {
                  {
                    text = "• Strict Mode : " .. strict,
                    callback_data = "LockEn Strict:" .. chat
                  }
                },
                {
                  {
                    text = "• Lock All Mode : " .. all,
                    callback_data = "LockEn All:" .. chat
                  }
                },
                {
                  {
                    text = "• No Answer : " .. cmd,
                    callback_data = "LockEn Cmd:" .. chat
                  }
                },
                {
                  {
                    text = "• Auto-Lock : " .. auto,
                    callback_data = "LockEn Auto:" .. chat
                  }
                },
                {
                  {
                    text = "« Back",
                    callback_data = "GroupSettingsEn:" .. chat
                  }
                }
              }
              edit(Q.inline_message_id, "• Group Modes :", keyboard)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("GroupCentPageOneFa") then
              local hash1 = database:get("bot:spam:mute" .. chat)
              local hash2 = database:get("bot:links:mute" .. chat)
              local hash3 = database:get("bot:webpage:mute" .. chat)
              local hash4 = database:get("tags:lock" .. chat)
              local hash5 = database:get("bot:hashtag:mute" .. chat)
              local hash6 = database:get("bot:forward:mute" .. chat)
              local hash7 = database:get("bot:duplipost:mute" .. chat)
              local hash8 = database:get("bot:bots:mute" .. chat)
              local hash9 = database:get("editmsg" .. chat)
              if hash1 then
                spam = "فعال"
              else
                spam = "غیرفعال"
              end
              if hash2 then
                links = "فعال"
              else
                links = "غیرفعال"
              end
              if hash3 then
                webpage = "فعال"
              else
                webpage = "غیرفعال"
              end
              if hash4 then
                tag = "فعال"
              else
                tag = "غیرفعال"
              end
              if hash5 then
                hashtag = "فعال"
              else
                hashtag = "غیرفعال"
              end
              if hash6 then
                fwd = "فعال"
              else
                fwd = "غیرفعال"
              end
              if hash7 then
                duplipost = "فعال"
              else
                duplipost = "غیرفعال"
              end
              if hash8 then
                bots = "فعال"
              else
                bots = "غیرفعال"
              end
              if hash9 then
                edits = "فعال"
              else
                edits = "غیرفعال"
              end
              keyboard.inline_keyboard = {
                {
                  {
                    text = "• قفل اسپم : " .. spam,
                    callback_data = "LockFa Spam:" .. chat
                  }
                },
                {
                  {
                    text = "• قفل لینک : " .. links,
                    callback_data = "LockFa Links:" .. chat
                  }
                },
                {
                  {
                    text = "• قفل آدرس اینترنتی : " .. webpage,
                    callback_data = "LockFa WebPage:" .. chat
                  }
                },
                {
                  {
                    text = "• قفل تگ : " .. tag,
                    callback_data = "LockFa Tag:" .. chat
                  }
                },
                {
                  {
                    text = "• قفل هشتگ : " .. hashtag,
                    callback_data = "LockFa Hashtag:" .. chat
                  }
                },
                {
                  {
                    text = "• قفل فروارد : " .. fwd,
                    callback_data = "LockFa Forward:" .. chat
                  }
                },
                {
                  {
                    text = "• قفل پست تکراری : " .. duplipost,
                    callback_data = "LockFa DupliPost:" .. chat
                  }
                },
                {
                  {
                    text = "• قفل ورود ربات : " .. bots,
                    callback_data = "LockFa Bots:" .. chat
                  }
                },
                {
                  {
                    text = "• قفل ویرایش پیام : " .. edits,
                    callback_data = "LockFa Edit:" .. chat
                  }
                },
                {
                  {
                    text = "بازگشت »",
                    callback_data = "GroupSettingsFa:" .. chat
                  },
                  {
                    text = "« بعدی",
                    callback_data = "GroupCentPageTwoFa:" .. chat
                  }
                }
              }
              edit(Q.inline_message_id, "• قفل های اصلی ( صفحه اول ) :", keyboard)
            elseif Q.data:match("GroupCentPageOneEn") then
              local hash1 = database:get("bot:spam:mute" .. chat)
              local hash2 = database:get("bot:links:mute" .. chat)
              local hash3 = database:get("bot:webpage:mute" .. chat)
              local hash4 = database:get("tags:lock" .. chat)
              local hash5 = database:get("bot:hashtag:mute" .. chat)
              local hash6 = database:get("bot:forward:mute" .. chat)
              local hash7 = database:get("bot:duplipost:mute" .. chat)
              local hash8 = database:get("bot:bots:mute" .. chat)
              local hash9 = database:get("editmsg" .. chat)
              if hash1 then
                spam = "Active"
              else
                spam = "Inactive"
              end
              if hash2 then
                links = "Active"
              else
                links = "Inactive"
              end
              if hash3 then
                webpage = "Active"
              else
                webpage = "Inactive"
              end
              if hash4 then
                tag = "Active"
              else
                tag = "Inactive"
              end
              if hash5 then
                hashtag = "Active"
              else
                hashtag = "Inactive"
              end
              if hash6 then
                fwd = "Active"
              else
                fwd = "Inactive"
              end
              if hash7 then
                duplipost = "Active"
              else
                duplipost = "Inactive"
              end
              if hash8 then
                bots = "Active"
              else
                bots = "Inactive"
              end
              if hash9 then
                edits = "Active"
              else
                edits = "Inactive"
              end
              keyboard.inline_keyboard = {
                {
                  {
                    text = "• Lock Spam : " .. spam,
                    callback_data = "LockEn Spam:" .. chat
                  }
                },
                {
                  {
                    text = "• Lock Links : " .. links,
                    callback_data = "LockEn Links:" .. chat
                  }
                },
                {
                  {
                    text = "• Lock WebPage : " .. webpage,
                    callback_data = "LockEn WebPage:" .. chat
                  }
                },
                {
                  {
                    text = "• Lock Tag: " .. tag,
                    callback_data = "LockEn Tag:" .. chat
                  }
                },
                {
                  {
                    text = "• Lock Hashtag : " .. hashtag,
                    callback_data = "LockEn Hashtag:" .. chat
                  }
                },
                {
                  {
                    text = "• Lock Forward : " .. fwd,
                    callback_data = "LockEn Forward:" .. chat
                  }
                },
                {
                  {
                    text = "• Lock DupliPost : " .. duplipost,
                    callback_data = "LockEn DupliPost:" .. chat
                  }
                },
                {
                  {
                    text = "• Lock Bots : " .. bots,
                    callback_data = "LockEn Bots:" .. chat
                  }
                },
                {
                  {
                    text = "• Lock Edit : " .. edits,
                    callback_data = "LockEn Edit:" .. chat
                  }
                },
                {
                  {
                    text = "« Back",
                    callback_data = "GroupSettingsEn:" .. chat
                  },
                  {
                    text = "Next »",
                    callback_data = "GroupCentPageTwoEn:" .. chat
                  }
                }
              }
              edit(Q.inline_message_id, "• Centerial Locks ( Front Page ) :", keyboard)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("GroupCentPageTwoFa") then
              local hash1 = database:get("bot:pin:mute" .. chat)
              local hash2 = database:get("bot:inline:mute" .. chat)
              local hash3 = database:get("bot:arabic:mute" .. chat)
              local hash4 = database:get("bot:english:mute" .. chat)
              local hash5 = database:get("markdown:lock" .. chat)
              local hash6 = database:get("post:lock" .. chat)
              local hash7 = database:get("Game:lock" .. chat)
              local hash8 = database:get("bot:member:lock" .. chat)
              local hash9 = database:get("bot:tgservice:mute" .. chat)
              if hash1 then
                pin = "فعال"
              else
                pin = "غیرفعال"
              end
              if hash2 then
                inline = "فعال"
              else
                inline = "غیرفعال"
              end
              if hash3 then
                arabic = "فعال"
              else
                arabic = "غیرفعال"
              end
              if hash4 then
                english = "فعال"
              else
                english = "غیرفعال"
              end
              if hash5 then
                markdown = "فعال"
              else
                markdown = "غیرفعال"
              end
              if hash6 then
                post = "فعال"
              else
                post = "غیرفعال"
              end
              if hash7 then
                game = "فعال"
              else
                game = "غیرفعال"
              end
              if hash8 then
                member = "فعال"
              else
                member = "غیرفعال"
              end
              if hash9 then
                tgservice = "فعال"
              else
                tgservice = "غیرفعال"
              end
              keyboard.inline_keyboard = {
                {
                  {
                    text = "• قفل سنجاق : " .. pin,
                    callback_data = "LockFa Pin:" .. chat
                  }
                },
                {
                  {
                    text = "• قفل دکمه شیشه ای : " .. inline,
                    callback_data = "LockFa Inline:" .. chat
                  }
                },
                {
                  {
                    text = "• قفل نوشتار فارسی : " .. arabic,
                    callback_data = "LockFa Farsi:" .. chat
                  }
                },
                {
                  {
                    text = "• قفل نوشتار انگلیسی : " .. english,
                    callback_data = "LockFa English:" .. chat
                  }
                },
                {
                  {
                    text = "• قفل مدل نشانه گذاری : " .. markdown,
                    callback_data = "LockFa MarkDown:" .. chat
                  }
                },
                {
                  {
                    text = "• قفل پست: " .. post,
                    callback_data = "LockFa Post:" .. chat
                  }
                },
                {
                  {
                    text = "• قفل بازی : " .. game,
                    callback_data = "LockFa Game:" .. chat
                  }
                },
                {
                  {
                    text = "• قفل ورود عضو جدید : " .. member,
                    callback_data = "LockFa Member:" .. chat
                  }
                },
                {
                  {
                    text = "• قفل سرویس تلگرام : " .. tgservice,
                    callback_data = "LockFa Tgservice:" .. chat
                  }
                },
                {
                  {
                    text = "بازگشت »",
                    callback_data = "GroupCentPageOneFa:" .. chat
                  },
                  {
                    text = "« بعدی",
                    callback_data = "GroupCentPageThreeFa:" .. chat
                  }
                }
              }
              edit(Q.inline_message_id, "• قفل های اصلی ( صفحه دوم ) :", keyboard)
            elseif Q.data:match("GroupCentPageTwoEn") then
              local hash1 = database:get("bot:pin:mute" .. chat)
              local hash2 = database:get("bot:inline:mute" .. chat)
              local hash3 = database:get("bot:arabic:mute" .. chat)
              local hash4 = database:get("bot:english:mute" .. chat)
              local hash5 = database:get("markdown:lock" .. chat)
              local hash6 = database:get("post:lock" .. chat)
              local hash7 = database:get("Game:lock" .. chat)
              local hash8 = database:get("bot:member:lock" .. chat)
              local hash9 = database:get("bot:tgservice:mute" .. chat)
              if hash1 then
                pin = "Active"
              else
                pin = "Inactive"
              end
              if hash2 then
                inline = "Active"
              else
                inline = "Inactive"
              end
              if hash3 then
                arabic = "Active"
              else
                arabic = "Inactive"
              end
              if hash4 then
                english = "Active"
              else
                english = "Inactive"
              end
              if hash5 then
                markdown = "Active"
              else
                markdown = "Inactive"
              end
              if hash6 then
                post = "Active"
              else
                post = "Inactive"
              end
              if hash7 then
                game = "Active"
              else
                game = "Inactive"
              end
              if hash8 then
                member = "Active"
              else
                member = "Inactive"
              end
              if hash9 then
                tgservice = "Active"
              else
                tgservice = "Inactive"
              end
              keyboard.inline_keyboard = {
                {
                  {
                    text = "• Lock Pin : " .. pin,
                    callback_data = "LockEn Pin:" .. chat
                  }
                },
                {
                  {
                    text = "• Lock Inline : " .. inline,
                    callback_data = "LockEn Inline:" .. chat
                  }
                },
                {
                  {
                    text = "• Lock Farsi : " .. arabic,
                    callback_data = "LockEn Farsi:" .. chat
                  }
                },
                {
                  {
                    text = "• Lock English: " .. english,
                    callback_data = "LockEn English:" .. chat
                  }
                },
                {
                  {
                    text = "• Lock Markdown : " .. markdown,
                    callback_data = "LockEn MarkDown:" .. chat
                  }
                },
                {
                  {
                    text = "• Lock Post : " .. post,
                    callback_data = "LockEn Post:" .. chat
                  }
                },
                {
                  {
                    text = "• Lock Game : " .. game,
                    callback_data = "LockEn Game:" .. chat
                  }
                },
                {
                  {
                    text = "• Lock Member : " .. member,
                    callback_data = "LockEn Member:" .. chat
                  }
                },
                {
                  {
                    text = "• Lock Tgservice : " .. tgservice,
                    callback_data = "LockEn Tgservice:" .. chat
                  }
                },
                {
                  {
                    text = "« Back",
                    callback_data = "GroupCentPageOneEn:" .. chat
                  },
                  {
                    text = "Next »",
                    callback_data = "GroupCentPageThreeEn:" .. chat
                  }
                }
              }
              edit(Q.inline_message_id, "• Centerial Locks ( Second Page ) :", keyboard)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("GroupCentPageThreeFa") then
              if database:get("floodstatus" .. chat) == "DelMsg" then
                floodstatus = "حذف پیام"
              elseif database:get("floodstatus" .. chat) == "Kicked" then
                floodstatus = "اخراج"
              elseif not database:get("floodstatus" .. chat) then
                floodstatus = "حذف پیام"
              end
              if database:get("warnstatus" .. chat) == "Muteuser" then
                warnstatus = "بی صدا"
              elseif database:get("warnstatus" .. chat) == "Remove" then
                warnstatus = "اخراج"
              elseif not database:get("warnstatus" .. chat) then
                warnstatus = "بی صدا"
              end
              if not database:get("flood:max:" .. chat) then
                flood_m = "5"
              else
                flood_m = database:get("flood:max:" .. chat)
              end
              if not database:get("bot:sens:spam" .. chat) then
                spam_c = "400"
              else
                spam_c = database:get("bot:sens:spam" .. chat)
              end
              if database:get("anti-flood:" .. chat) then
                mute_flood = "فعال"
              else
                mute_flood = "غیرفعال"
              end
              if database:get("warn:max:" .. chat) then
                sencwarn = database:get("warn:max:" .. chat)
              else
                sencwarn = "4"
              end
              sencwarn = sencwarn:gsub("0", "۰")
              sencwarn = sencwarn:gsub("1", "۱")
              sencwarn = sencwarn:gsub("2", "۲")
              sencwarn = sencwarn:gsub("3", "۳")
              sencwarn = sencwarn:gsub("4", "۴")
              sencwarn = sencwarn:gsub("5", "۵")
              sencwarn = sencwarn:gsub("6", "۶")
              sencwarn = sencwarn:gsub("7", "۷")
              sencwarn = sencwarn:gsub("8", "۸")
              sencwarn = sencwarn:gsub("9", "۹")
              spam_c = spam_c:gsub("0", "۰")
              spam_c = spam_c:gsub("1", "۱")
              spam_c = spam_c:gsub("2", "۲")
              spam_c = spam_c:gsub("3", "۳")
              spam_c = spam_c:gsub("4", "۴")
              spam_c = spam_c:gsub("5", "۵")
              spam_c = spam_c:gsub("6", "۶")
              spam_c = spam_c:gsub("7", "۷")
              spam_c = spam_c:gsub("8", "۸")
              spam_c = spam_c:gsub("9", "۹")
              flood_m = flood_m:gsub("0", "۰")
              flood_m = flood_m:gsub("1", "۱")
              flood_m = flood_m:gsub("2", "۲")
              flood_m = flood_m:gsub("3", "۳")
              flood_m = flood_m:gsub("4", "۴")
              flood_m = flood_m:gsub("5", "۵")
              flood_m = flood_m:gsub("6", "۶")
              flood_m = flood_m:gsub("7", "۷")
              flood_m = flood_m:gsub("8", "۸")
              flood_m = flood_m:gsub("9", "۹")
              keyboard.inline_keyboard = {
                {
                  {
                    text = "• قفل فلود : " .. mute_flood,
                    callback_data = "LockFa Flood:" .. chat
                  }
                },
                {
                  {
                    text = "• وضعیت فلود : " .. floodstatus,
                    callback_data = "StatusFa Flood:" .. chat
                  }
                },
                {
                  {
                    text = "• حساسیت فلود : " .. flood_m,
                    callback_data = "SensFa FloodMax:" .. chat
                  }
                },
                {
                  {
                    text = "≪≪",
                    callback_data = "SensDownTwoFa FloodMax:" .. chat
                  },
                  {
                    text = "≪",
                    callback_data = "SensDownOneFa FloodMax:" .. chat
                  },
                  {
                    text = "≫",
                    callback_data = "SensUpOneFa FloodMax:" .. chat
                  },
                  {
                    text = "≫≫",
                    callback_data = "SensUpTwoFa FloodMax:" .. chat
                  }
                },
                {
                  {
                    text = "• حساسیت اسپم : " .. spam_c,
                    callback_data = "SensFa Spam:" .. chat
                  }
                },
                {
                  {
                    text = "≪≪",
                    callback_data = "SensDownTwoFa Spam:" .. chat
                  },
                  {
                    text = "≪",
                    callback_data = "SensDownOneFa Spam:" .. chat
                  },
                  {
                    text = "≫",
                    callback_data = "SensUpOneFa Spam:" .. chat
                  },
                  {
                    text = "≫≫",
                    callback_data = "SensUpTwoFa Spam:" .. chat
                  }
                },
                {
                  {
                    text = "• وضعیت اخطار : " .. warnstatus,
                    callback_data = "StatusFa Warn:" .. chat
                  }
                },
                {
                  {
                    text = "• حداکثر اخطار : " .. sencwarn,
                    callback_data = "SensFa Warn:" .. chat
                  }
                },
                {
                  {
                    text = "≪≪",
                    callback_data = "SensDownTwoFa Warn:" .. chat
                  },
                  {
                    text = "≪",
                    callback_data = "SensDownOneFa Warn:" .. chat
                  },
                  {
                    text = "≫",
                    callback_data = "SensUpOneFa Warn:" .. chat
                  },
                  {
                    text = "≫≫",
                    callback_data = "SensUpTwoFa Warn:" .. chat
                  }
                },
                {
                  {
                    text = "بازگشت »",
                    callback_data = "GroupCentPageTwoFa:" .. chat
                  }
                }
              }
              edit(Q.inline_message_id, "• قفل های اصلی ( صفحه سوم ) :", keyboard)
            elseif Q.data:match("GroupCentPageThreeEn") then
              if database:get("floodstatus" .. chat) == "DelMsg" then
                floodstatus = "Deleting"
              elseif database:get("floodstatus" .. chat) == "Kicked" then
                floodstatus = "Kicking"
              elseif not database:get("floodstatus" .. chat) then
                floodstatus = "Deleting"
              end
              if database:get("warnstatus" .. chat) == "Muteuser" then
                warnstatus = "Mute"
              elseif database:get("warnstatus" .. chat) == "Remove" then
                warnstatus = "Kicking"
              elseif not database:get("warnstatus" .. chat) then
                warnstatus = "Mute"
              end
              if not database:get("flood:max:" .. chat) then
                flood_m = 5
              else
                flood_m = database:get("flood:max:" .. chat)
              end
              if not database:get("bot:sens:spam" .. chat) then
                spam_c = 400
              else
                spam_c = database:get("bot:sens:spam" .. chat)
              end
              if database:get("anti-flood:" .. chat) then
                mute_flood = "Active"
              else
                mute_flood = "Inactive"
              end
              if database:get("warn:max:" .. chat) then
                sencwarn = tonumber(database:get("warn:max:" .. chat))
              else
                sencwarn = 4
              end
              keyboard.inline_keyboard = {
                {
                  {
                    text = "• Lock Flood : " .. mute_flood,
                    callback_data = "LockEn Flood:" .. chat
                  }
                },
                {
                  {
                    text = "• Flood Status : " .. floodstatus,
                    callback_data = "StatusEn Flood:" .. chat
                  }
                },
                {
                  {
                    text = "• Flood Sensitivity : " .. flood_m,
                    callback_data = "SensEn FloodMax:" .. chat
                  }
                },
                {
                  {
                    text = "≪≪",
                    callback_data = "SensDownTwoEn FloodMax:" .. chat
                  },
                  {
                    text = "≪",
                    callback_data = "SensDownOneEn FloodMax:" .. chat
                  },
                  {
                    text = "≫",
                    callback_data = "SensUpOneEn FloodMax:" .. chat
                  },
                  {
                    text = "≫≫",
                    callback_data = "SensUpTwoEn FloodMax:" .. chat
                  }
                },
                {
                  {
                    text = "• Spam Sensitivity : " .. spam_c,
                    callback_data = "SensEn Spam:" .. chat
                  }
                },
                {
                  {
                    text = "≪≪",
                    callback_data = "SensDownTwoEn Spam:" .. chat
                  },
                  {
                    text = "≪",
                    callback_data = "SensDownOneEn Spam:" .. chat
                  },
                  {
                    text = "≫",
                    callback_data = "SensUpOneEn Spam:" .. chat
                  },
                  {
                    text = "≫≫",
                    callback_data = "SensUpTwoEn Spam:" .. chat
                  }
                },
                {
                  {
                    text = "• Warn Status : " .. warnstatus,
                    callback_data = "StatusEn Warn:" .. chat
                  }
                },
                {
                  {
                    text = "• Maximum Warning : " .. sencwarn,
                    callback_data = "SensEn Warn:" .. chat
                  }
                },
                {
                  {
                    text = "≪≪",
                    callback_data = "SensDownTwoEn Warn:" .. chat
                  },
                  {
                    text = "≪",
                    callback_data = "SensDownOneEn Warn:" .. chat
                  },
                  {
                    text = "≫",
                    callback_data = "SensUpOneEn Warn:" .. chat
                  },
                  {
                    text = "≫≫",
                    callback_data = "SensUpTwoEn Warn:" .. chat
                  }
                },
                {
                  {
                    text = "« Back",
                    callback_data = "GroupCentPageTwoEn:" .. chat
                  }
                }
              }
              edit(Q.inline_message_id, "• Centerial Locks ( Third Page ) :", keyboard)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("GroupMediaFa") then
              hash1 = database:get("bot:text:mute" .. chat)
              hash2 = database:get("bot:photo:mute" .. chat)
              hash3 = database:get("bot:video:mute" .. chat)
              hash4 = database:get("bot:selfvideo:mute" .. chat)
              hash5 = database:get("bot:gifs:mute" .. chat)
              hash6 = database:get("bot:music:mute" .. chat)
              hash7 = database:get("bot:voice:mute" .. chat)
              hash8 = database:get("bot:document:mute" .. chat)
              hash9 = database:get("bot:sticker:mute" .. chat)
              hash10 = database:get("bot:contact:mute" .. chat)
              hash11 = database:get("bot:location:mute" .. chat)
              if hash1 then
                text = "فعال"
              else
                text = "غیرفعال"
              end
              if hash2 then
                photo = "فعال"
              else
                photo = "غیرفعال"
              end
              if hash3 then
                video = "فعال"
              else
                video = "غیرفعال"
              end
              if hash4 then
                selfvideo = "فعال"
              else
                selfvideo = "غیرفعال"
              end
              if hash5 then
                gifs = "فعال"
              else
                gifs = "غیرفعال"
              end
              if hash6 then
                music = "فعال"
              else
                music = "غیرفعال"
              end
              if hash7 then
                voice = "فعال"
              else
                voice = "غیرفعال"
              end
              if hash8 then
                file = "فعال"
              else
                file = "غیرفعال"
              end
              if hash9 then
                sticker = "فعال"
              else
                sticker = "غیرفعال"
              end
              if hash10 then
                contact = "فعال"
              else
                contact = "غیرفعال"
              end
              if hash11 then
                location = "فعال"
              else
                location = "غیرفعال"
              end
              keyboard.inline_keyboard = {
                {
                  {
                    text = "• قفل متن : " .. text,
                    callback_data = "LockFa Text:" .. chat
                  }
                },
                {
                  {
                    text = "• قفل عکس : " .. photo,
                    callback_data = "LockFa Photo:" .. chat
                  }
                },
                {
                  {
                    text = "• قفل فیلم : " .. video,
                    callback_data = "LockFa Video:" .. chat
                  }
                },
                {
                  {
                    text = "• قفل فیلم سلفی : " .. selfvideo,
                    callback_data = "LockFa SelfFilm:" .. chat
                  }
                },
                {
                  {
                    text = "• قفل گیف : " .. gifs,
                    callback_data = "LockFa Gifs:" .. chat
                  }
                },
                {
                  {
                    text = "• قفل آهنگ : " .. music,
                    callback_data = "LockFa Music:" .. chat
                  }
                },
                {
                  {
                    text = "• قفل ویس : " .. voice,
                    callback_data = "LockFa Voice:" .. chat
                  }
                },
                {
                  {
                    text = "• قفل فایل : " .. file,
                    callback_data = "LockFa File:" .. chat
                  }
                },
                {
                  {
                    text = "• قفل استیکر : " .. sticker,
                    callback_data = "LockFa Sticker:" .. chat
                  }
                },
                {
                  {
                    text = "• قفل مخاطب : " .. contact,
                    callback_data = "LockFa Contacts:" .. chat
                  }
                },
                {
                  {
                    text = "• قفل موقعیت مکانی : " .. location,
                    callback_data = "LockFa Location:" .. chat
                  }
                },
                {
                  {
                    text = "بازگشت »",
                    callback_data = "GroupSettingsFa:" .. chat
                  }
                }
              }
              edit(Q.inline_message_id, "• قفل های رسانه :", keyboard)
            elseif Q.data:match("GroupMediaEn") then
              hash1 = database:get("bot:text:mute" .. chat)
              hash2 = database:get("bot:photo:mute" .. chat)
              hash3 = database:get("bot:video:mute" .. chat)
              hash4 = database:get("bot:selfvideo:mute" .. chat)
              hash5 = database:get("bot:gifs:mute" .. chat)
              hash6 = database:get("bot:music:mute" .. chat)
              hash7 = database:get("bot:voice:mute" .. chat)
              hash8 = database:get("bot:document:mute" .. chat)
              hash9 = database:get("bot:sticker:mute" .. chat)
              hash10 = database:get("bot:contact:mute" .. chat)
              hash11 = database:get("bot:location:mute" .. chat)
              if hash1 then
                text = "Active"
              else
                text = "Inactive"
              end
              if hash2 then
                photo = "Active"
              else
                photo = "Inactive"
              end
              if hash3 then
                video = "Active"
              else
                video = "Inactive"
              end
              if hash4 then
                selfvideo = "Active"
              else
                selfvideo = "Inactive"
              end
              if hash5 then
                gifs = "Active"
              else
                gifs = "Inactive"
              end
              if hash6 then
                music = "Active"
              else
                music = "Inactive"
              end
              if hash7 then
                voice = "Active"
              else
                voice = "Inactive"
              end
              if hash8 then
                file = "Active"
              else
                file = "Inactive"
              end
              if hash9 then
                sticker = "Active"
              else
                sticker = "Inactive"
              end
              if hash10 then
                contact = "Active"
              else
                contact = "Inactive"
              end
              if hash11 then
                location = "Active"
              else
                location = "Inactive"
              end
              keyboard.inline_keyboard = {
                {
                  {
                    text = "• Lock Text : " .. text,
                    callback_data = "LockEn Text:" .. chat
                  }
                },
                {
                  {
                    text = "• Lock Photo : " .. photo,
                    callback_data = "LockEn Photo:" .. chat
                  }
                },
                {
                  {
                    text = "• Lock Videos : " .. video,
                    callback_data = "LockEn Videos:" .. chat
                  }
                },
                {
                  {
                    text = "• Lock Self Videos: " .. selfvideo,
                    callback_data = "LockEn SelfFilm:" .. chat
                  }
                },
                {
                  {
                    text = "• Lock Gifs : " .. gifs,
                    callback_data = "LockEn Gifs:" .. chat
                  }
                },
                {
                  {
                    text = "• Lock Music : " .. music,
                    callback_data = "LockEn Music:" .. chat
                  }
                },
                {
                  {
                    text = "• Lock Voice : " .. voice,
                    callback_data = "LockEn Voice:" .. chat
                  }
                },
                {
                  {
                    text = "• Lock File : " .. file,
                    callback_data = "LockEn File:" .. chat
                  }
                },
                {
                  {
                    text = "• Lock Sticker : " .. sticker,
                    callback_data = "LockEn Sticker:" .. chat
                  }
                },
                {
                  {
                    text = "• Lock Contact : " .. contact,
                    callback_data = "LockEn Contact:" .. chat
                  }
                },
                {
                  {
                    text = "• Lock Location : " .. location,
                    callback_data = "LockEn Location:" .. chat
                  }
                },
                {
                  {
                    text = "« Back",
                    callback_data = "GroupSettingsEn:" .. chat
                  }
                }
              }
              edit(Q.inline_message_id, "• Media Locks :", keyboard)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("OwnerlistFa") then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "بازگشت »",
                    callback_data = "GroupInfoFa:" .. chat
                  }
                }
              }
              local hash = "bot:owners:" .. chat
              local list = database:smembers(hash)
              text = "• لیست صاحبان گروه : \n\n"
              for k, v in pairs(list) do
                local user_info = database:get("user:Name" .. v)
                if user_info then
                  local username = user_info
                  text = text .. k .. " - " .. username .. " ( " .. v .. " )\n"
                else
                  text = text .. k .. " - ( " .. v .. " )\n"
                end
              end
              if #list == 0 then
                text = "• لیست صاحبان گروه خالی است !"
              end
              edit(Q.inline_message_id, text, keyboard)
            elseif Q.data:match("OwnerlistEn") then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "« Back",
                    callback_data = "GroupInfoEn:" .. chat
                  }
                }
              }
              local hash = "bot:owners:" .. chat
              local list = database:smembers(hash)
              text = "• <b>Owners</b> list : \n\n"
              for k, v in pairs(list) do
                local user_info = database:get("user:Name" .. v)
                if user_info then
                  local username = user_info
                  text = text .. k .. " - " .. username .. " ( " .. v .. " )\n"
                else
                  text = text .. k .. " - ( " .. v .. " )\n"
                end
              end
              if #list == 0 then
                text = "• <b>Owner list</b> is Empty !"
              end
              edit(Q.inline_message_id, text, keyboard)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("ModlistFa") then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "• بروزرسانی",
                    callback_data = "UpdateModListFa:" .. chat
                  },
                  {
                    text = "• پاکسازی لیست",
                    callback_data = "CleanModListFa:" .. chat
                  }
                },
                {
                  {
                    text = "بازگشت »",
                    callback_data = "GroupInfoFa:" .. chat
                  }
                }
              }
              local hash = "bot:momod:" .. chat
              local list = database:smembers(hash)
              text = "• لیست مدیران گروه : \n\n"
              for k, v in pairs(list) do
                local user_info = database:get("user:Name" .. v)
                if user_info then
                  local username = user_info
                  text = text .. k .. " - " .. username .. " ( " .. v .. ")\n"
                else
                  text = text .. k .. " - ( " .. v .. " )\n"
                end
              end
              if #list == 0 then
                keyboard.inline_keyboard = {
                  {
                    {
                      text = "• بروزرسانی",
                      callback_data = "UpdateModListFa:" .. chat
                    }
                  },
                  {
                    {
                      text = "بازگشت »",
                      callback_data = "GroupInfoFa:" .. chat
                    }
                  }
                }
                text = "• لیست مدیران خالی است !"
              end
              edit(Q.inline_message_id, text, keyboard)
            elseif Q.data:match("ModlistEn") then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "• Update",
                    callback_data = "UpdateModListEn:" .. chat
                  },
                  {
                    text = "• Clean List",
                    callback_data = "CleanModListEn:" .. chat
                  }
                },
                {
                  {
                    text = "« Back",
                    callback_data = "GroupInfoEn:" .. chat
                  }
                }
              }
              local hash = "bot:momod:" .. chat
              local list = database:smembers(hash)
              text = "• List Of <b>Moderator</b> : \n\n"
              for k, v in pairs(list) do
                local user_info = database:get("user:Name" .. v)
                if user_info then
                  local username = user_info
                  text = text .. k .. " - " .. username .. " ( " .. v .. " )\n"
                else
                  text = text .. k .. " - ( " .. v .. " )\n"
                end
              end
              if #list == 0 then
                keyboard.inline_keyboard = {
                  {
                    {
                      text = "• Update",
                      callback_data = "UpdateModListEn:" .. chat
                    }
                  },
                  {
                    {
                      text = "« Back",
                      callback_data = "GroupInfoEn:" .. chat
                    }
                  }
                }
                text = "• List Of <b>Moderator</b> is Empty !"
              end
              edit(Q.inline_message_id, text, keyboard)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("BanlistFa") then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "• بروزرسانی",
                    callback_data = "UpdateBanListFa:" .. chat
                  },
                  {
                    text = "• پاکسازی لیست",
                    callback_data = "CleanBanListFa:" .. chat
                  }
                },
                {
                  {
                    text = "بازگشت »",
                    callback_data = "GroupInfoFa:" .. chat
                  }
                }
              }
              local hash = "bot:banned:" .. chat
              local list = database:smembers(hash)
              text = "• لیست افراد مسدود شده : \n\n"
              for k, v in pairs(list) do
                local user_info = database:get("user:Name" .. v)
                if user_info then
                  local username = user_info
                  text = text .. k .. " - " .. username .. " [" .. v .. "]\n"
                else
                  text = text .. k .. " - [" .. v .. "]\n"
                end
              end
              if #list == 0 then
                keyboard.inline_keyboard = {
                  {
                    {
                      text = "• بروزرسانی",
                      callback_data = "UpdateBanListFa:" .. chat
                    }
                  },
                  {
                    {
                      text = "بازگشت »",
                      callback_data = "GroupInfoFa:" .. chat
                    }
                  }
                }
                text = "• لیست افراد مسدود شده خالی است !"
              end
              edit(Q.inline_message_id, text, keyboard)
            elseif Q.data:match("BanlistEn") then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "• Update",
                    callback_data = "UpdateBanListEn:" .. chat
                  },
                  {
                    text = "• Clean List",
                    callback_data = "CleanBanListEn:" .. chat
                  }
                },
                {
                  {
                    text = "« Back",
                    callback_data = "GroupInfoEn:" .. chat
                  }
                }
              }
              local hash = "bot:banned:" .. chat
              local list = database:smembers(hash)
              text = "• List of <b>Banlist</b> : \n\n"
              for k, v in pairs(list) do
                local user_info = database:get("user:Name" .. v)
                if user_info then
                  local username = user_info
                  text = text .. k .. " - " .. username .. " [" .. v .. "]\n"
                else
                  text = text .. k .. " - [" .. v .. "]\n"
                end
              end
              if #list == 0 then
                keyboard.inline_keyboard = {
                  {
                    {
                      text = "• Update",
                      callback_data = "UpdateBanListEn:" .. chat
                    }
                  },
                  {
                    {
                      text = "« Back",
                      callback_data = "GroupInfoEn:" .. chat
                    }
                  }
                }
                text = "• List of <b>Banlist</b> is Empty !"
              end
              edit(Q.inline_message_id, text, keyboard)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("FilterListFa") then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "• بروزرسانی",
                    callback_data = "UpdateFilterListFa:" .. chat
                  },
                  {
                    text = "• پاکسازی لیست",
                    callback_data = "CleanFilterListFa:" .. chat
                  }
                },
                {
                  {
                    text = "بازگشت »",
                    callback_data = "GroupInfoFa:" .. chat
                  }
                }
              }
              local hash = "bot:filters:" .. chat
              local names = database:hkeys(hash)
              texti = "• لیست کلمات فیلتر شده : \n\n"
              local b = 1
              for i = 1, #names do
                texti = texti .. b .. ". " .. names[i] .. "\n"
                b = b + 1
              end
              if #names == 0 then
                keyboard.inline_keyboard = {
                  {
                    {
                      text = "• بروزرسانی",
                      callback_data = "UpdateFilterListFa:" .. chat
                    }
                  },
                  {
                    {
                      text = "بازگشت »",
                      callback_data = "GroupInfoFa:" .. chat
                    }
                  }
                }
                texti = "• لیست کلمات فیلتر شده خالی است !"
              end
              edit(Q.inline_message_id, texti, keyboard)
            elseif Q.data:match("FilterListEn") then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "• Update",
                    callback_data = "UpdateFilterListEn:" .. chat
                  },
                  {
                    text = "• Clean List",
                    callback_data = "CleanFilterListEn:" .. chat
                  }
                },
                {
                  {
                    text = "« Back",
                    callback_data = "GroupInfoEn:" .. chat
                  }
                }
              }
              local hash = "bot:filters:" .. chat
              local names = database:hkeys(hash)
              texti = "• <b>Filterlist</b> : \n\n"
              local b = 1
              for i = 1, #names do
                texti = texti .. b .. ". " .. names[i] .. "\n"
                b = b + 1
              end
              if #names == 0 then
                keyboard.inline_keyboard = {
                  {
                    {
                      text = "• Update",
                      callback_data = "UpdateFilterListEn:" .. chat
                    }
                  },
                  {
                    {
                      text = "« Back",
                      callback_data = "GroupInfoEn:" .. chat
                    }
                  }
                }
                texti = "• <b>Filterlist</b> is Empty !"
              end
              edit(Q.inline_message_id, texti, keyboard)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("MutelistFa") then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "• بروزرسانی",
                    callback_data = "UpdateMuteListFa:" .. chat
                  },
                  {
                    text = "• پاکسازی لیست",
                    callback_data = "CleanMuteListFa:" .. chat
                  }
                },
                {
                  {
                    text = "بازگشت »",
                    callback_data = "GroupInfoFa:" .. chat
                  }
                }
              }
              local hash = "bot:muted:" .. chat
              local list = database:smembers(hash)
              text = "• لیست افراد بی صدا : \n\n"
              for k, v in pairs(list) do
                local TTL = database:ttl("bot:muted:Time" .. chat .. ":" .. v)
                if TTL == 0 or TTL == -2 then
                  if database:get("lang:gp:" .. chat) then
                    Time_S = "[ Free ]"
                  else
                    Time_S = "[ آزاد ]"
                  end
                elseif TTL == -1 then
                  if database:get("lang:gp:" .. chat) then
                    Time_S = "[ No time ]"
                  else
                    Time_S = "[ بدون مدت ]"
                  end
                else
                  local Time_ = getTime(TTL)
                  Time_S = "[ " .. Time_ .. " ]"
                end
                local user_info = database:get("user:Name" .. v)
                if user_info then
                  local username = user_info
                  text = text .. k .. " - " .. username .. " [" .. v .. "]\n" .. Time_S .. "\n"
                else
                  text = text .. k .. " - [" .. v .. "]\n" .. Time_S .. "\n"
                end
              end
              if #list == 0 then
                keyboard.inline_keyboard = {
                  {
                    {
                      text = "• بروزرسانی",
                      callback_data = "UpdateMuteListFa:" .. chat
                    }
                  },
                  {
                    {
                      text = "بازگشت »",
                      callback_data = "GroupInfoFa:" .. chat
                    }
                  }
                }
                text = "• لیست افراد بی صدا خالی است ! "
              end
              edit(Q.inline_message_id, text, keyboard)
            elseif Q.data:match("MutelistEn") then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "• Update",
                    callback_data = "UpdateMuteListEn:" .. chat
                  },
                  {
                    text = "• Clean List",
                    callback_data = "CleanMuteListEn:" .. chat
                  }
                },
                {
                  {
                    text = "« Back",
                    callback_data = "GroupInfoEn:" .. chat
                  }
                }
              }
              local hash = "bot:muted:" .. chat
              local list = database:smembers(hash)
              text = "• List of <b>Muted users</b> : \n\n"
              for k, v in pairs(list) do
                if database:get("bot:muted:Time" .. chat .. ":" .. v) then
                  local TTL = database:ttl("bot:muted:Time" .. chat .. ":" .. v)
                  local Time_ = getTime(TTL)
                  Time_S = "[ " .. Time_ .. " ]"
                else
                  Time_S = "[ No time ]"
                end
                local user_info = database:get("user:Name" .. v)
                if user_info then
                  local username = user_info
                  text = text .. k .. " - " .. username .. " [" .. v .. "]\n" .. Time_S .. "\n"
                else
                  text = text .. k .. " - [" .. v .. "]\n" .. Time_S .. "\n"
                end
              end
              if #list == 0 then
                text = "• List of <b>Muted users</b> is Empty ! "
                keyboard.inline_keyboard = {
                  {
                    {
                      text = "• Update",
                      callback_data = "UpdateMuteListEn:" .. chat
                    }
                  },
                  {
                    {
                      text = "« Back",
                      callback_data = "GroupInfoEn:" .. chat
                    }
                  }
                }
              end
              edit(Q.inline_message_id, text, keyboard)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("^RulesFa") then
              local rules = database:get("bot:rules" .. chat)
              if rules then
                keyboard.inline_keyboard = {
                  {
                    {
                      text = "• تنظیم مجدد",
                      callback_data = "SetRulesFa:" .. chat
                    },
                    {
                      text = "• حذف قوانین",
                      callback_data = "CleanRulesFa:" .. chat
                    }
                  },
                  {
                    {
                      text = "بازگشت »",
                      callback_data = "GroupInfoFa:" .. chat
                    }
                  }
                }
                edit(Q.inline_message_id, rules, keyboard)
              else
                keyboard.inline_keyboard = {
                  {
                    {
                      text = "• تنظیم قوانین",
                      callback_data = "SetRulesFa:" .. chat
                    }
                  },
                  {
                    {
                      text = "بازگشت »",
                      callback_data = "GroupInfoFa:" .. chat
                    }
                  }
                }
                edit(Q.inline_message_id, "• قوانینی جهت نمایش وجود ندارد !", keyboard)
              end
            elseif Q.data:match("^RulesEn") then
              local rules = database:get("bot:rules" .. chat)
              if rules then
                keyboard.inline_keyboard = {
                  {
                    {
                      text = "• Set Againg",
                      callback_data = "SetRulesEn:" .. chat
                    },
                    {
                      text = "• Clean Rules",
                      callback_data = "CleanRulesEn:" .. chat
                    }
                  },
                  {
                    {
                      text = "« Back",
                      callback_data = "GroupInfoEn:" .. chat
                    }
                  }
                }
                edit(Q.inline_message_id, rules, keyboard)
              else
                keyboard.inline_keyboard = {
                  {
                    {
                      text = "• Set Rules",
                      callback_data = "SetRulesEn:" .. chat
                    }
                  },
                  {
                    {
                      text = "« Back",
                      callback_data = "GroupInfoEn:" .. chat
                    }
                  }
                }
                edit(Q.inline_message_id, "• There Are No Rules To Display !", keyboard)
              end
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("GroupLinkFa") then
              local link = database:get("bot:group:link" .. chat)
              if link then
                keyboard.inline_keyboard = {
                  {
                    {
                      text = "• تنظیم مجدد",
                      callback_data = "SetLinkFa:" .. chat
                    },
                    {
                      text = "• حذف لینک",
                      callback_data = "CleanLinkFa:" .. chat
                    }
                  },
                  {
                    {
                      text = "بازگشت »",
                      callback_data = "GroupInfoFa:" .. chat
                    }
                  }
                }
                edit(Q.inline_message_id, "• لینک گروه :\n\n" .. link, keyboard)
              else
                keyboard.inline_keyboard = {
                  {
                    {
                      text = "• تنظیم لینک",
                      callback_data = "SetLinkFa:" .. chat
                    }
                  },
                  {
                    {
                      text = "بازگشت »",
                      callback_data = "GroupInfoFa:" .. chat
                    }
                  }
                }
                edit(Q.inline_message_id, "• لینک گروه ثبت نشده است !", keyboard)
              end
            elseif Q.data:match("GroupLinkEn") then
              local link = database:get("bot:group:link" .. chat)
              if link then
                keyboard.inline_keyboard = {
                  {
                    {
                      text = "• Set Againg",
                      callback_data = "SetLinkEn:" .. chat
                    },
                    {
                      text = "• Clean Link",
                      callback_data = "CleanLinkEn:" .. chat
                    }
                  },
                  {
                    {
                      text = "« Back",
                      callback_data = "GroupInfoEn:" .. chat
                    }
                  }
                }
                edit(Q.inline_message_id, "•<b>Group link</b> :\n\n" .. link, keyboard)
              else
                keyboard.inline_keyboard = {
                  {
                    {
                      text = "• Set Link",
                      callback_data = "SetLinkEn:" .. chat
                    }
                  },
                  {
                    {
                      text = "« Back",
                      callback_data = "GroupInfoEn:" .. chat
                    }
                  }
                }
                edit(Q.inline_message_id, "• The Group Link is Not Registered!", keyboard)
              end
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("GroupChargeFa") then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "بازگشت »",
                    callback_data = "GroupInfoFa:" .. chat
                  }
                }
              }
              local ex = database:ttl("bot:charge:" .. chat)
              if ex == -1 then
                text = "• بدون محدودیت !"
              else
                local b = math.floor(ex / day) + 1
                if b == 0 then
                  text = "• اعتبار گروه به پایان رسیده است !"
                else
                  local d = math.floor(ex / day) + 1
                  text = "• گروه دارای " .. d .. " روز اعتبار میباشد "
                end
              end
              edit(Q.inline_message_id, text, keyboard)
            elseif Q.data:match("GroupChargeEn") then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "« Back",
                    callback_data = "GroupInfoEn:" .. chat
                  }
                }
              }
              local ex = database:ttl("bot:charge:" .. chat)
              if ex == -1 then
                text = "• Unlimited !"
              else
                local b = math.floor(ex / day) + 1
                if b == 0 then
                  text = "• Credit Group has Ended !"
                else
                  local d = math.floor(ex / day) + 1
                  text = "• Group have Validity for " .. d .. " Day !"
                end
              end
              edit(Q.inline_message_id, text, keyboard)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("AuthoritiesFa") then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "بازگشت »",
                    callback_data = "SupportFa:" .. chat
                  }
                }
              }
              local text = database:get("AuthoritiesFa")
              if text then
                edit(Q.inline_message_id, text, keyboard)
              else
                edit(Q.inline_message_id, "• اطلاعات موجود نیست !", keyboard)
              end
            elseif Q.data:match("AuthoritiesEn") then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "« Back",
                    callback_data = "SupportEn:" .. chat
                  }
                }
              }
              local text = database:get("AuthoritiesEn")
              if text then
                edit(Q.inline_message_id, text, keyboard)
              else
                edit(Q.inline_message_id, "• No Data Available !", keyboard)
              end
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("SupportLinkFa") then
              local link = database:get("bot:supports:link")
              keyboard.inline_keyboard = {
                {
                  {
                    text = "بازگشت »",
                    callback_data = "SupportFa:" .. chat
                  }
                }
              }
              if link then
                if link:match("https://") then
                  text = "• لینک گروه پشتیبانی : \n\n" .. link
                else
                  text = "• آیدی ربات پشتیبانی : @" .. link
                end
              else
                text = "• اطلاعات موجود نیست !"
              end
              edit(Q.inline_message_id, text, keyboard)
            elseif Q.data:match("SupportLinkEn") then
              local link = database:get("bot:supports:link")
              keyboard.inline_keyboard = {
                {
                  {
                    text = "« Back",
                    callback_data = "SupportEn:" .. chat
                  }
                }
              }
              if link then
                if link:match("https://") then
                  text = "• Support Group Link : \n\n" .. link
                else
                  text = "• Support Bot ID : @" .. link
                end
              else
                text = "• No Data Available !"
              end
              edit(Q.inline_message_id, text, keyboard)
            end
          end
          if having_access(Q.from.id, chat, Q.id) then
            if Q.data:match("ReportFa") then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "بازگشت »",
                    callback_data = "SupportFa:" .. chat
                  }
                }
              }
              edit(Q.inline_message_id, "• شما می توانید با استفاده از دستور <b>Feedback</b> به پشتیبانی پیام ارسال کرده و آنها از وجود مشکل باخبر سازید !", keyboard)
            elseif Q.data:match("ReportFa") then
              keyboard.inline_keyboard = {
                {
                  {
                    text = "« Back",
                    callback_data = "SupportEn:" .. chat
                  }
                }
              }
              edit(Q.inline_message_id, "• You Can Send Message Support Using The <b>Feedback</b> Command And Inform Them of The Problem !", keyboard)
            end
          end
        end
        if msg.message then
          local text = msg.message.text
          local user = msg.message.from.id
          if text then
            if (text:match("^/[Pp]ing$") or text:match("^[Pp]ing$")) and is_admin(user) then
              if database:get("lang:gp:" .. msg.message.chat.id) then
                send_msg(msg.message.chat.id, "• Helper is Now *Online* !", msg.message.message_id, "md")
              else
                send_msg(msg.message.chat.id, "• هلپر هم اکنون آنلاین میباشد !", msg.message.message_id, "md")
              end
            end
            if database:get("Filtering:" .. user) and not text:match("^/[Ss]tart$") then
              local chat = database:get("Filtering:" .. user)
              local name = string.sub(text, 1, 50)
              local hash = "bot:filters:" .. chat
              if text:match("^/[Dd]one$") then
                if database:get("lang:gp:" .. msg.message.chat.id) then
                  send_msg(msg.message.chat.id, "• The *Operation* is Over !", msg.message.message_id, "md")
                else
                  send_msg(msg.message.chat.id, "• عملیات به پایان رسید !", msg.message.message_id, "md")
                end
                database:del("Filtering:" .. user, 80, chat)
              elseif text:match("^/[Cc]ancel$") then
                if database:get("lang:gp:" .. msg.message.chat.id) then
                  send_msg(msg.message.chat.id, "• *Operation* Canceled !", msg.message.message_id, "md")
                else
                  send_msg(msg.message.chat.id, "• عملیات لغو شد !", msg.message.message_id, "md")
                end
                database:del("Filtering:" .. user, 80, chat)
              elseif filter_ok(name) then
                database:hset(hash, name, "newword")
                if database:get("lang:gp:" .. msg.message.chat.id) then
                  send_msg(msg.message.chat.id, "• Word `[" .. name .. [[
]` has been *Filtered* !
If You No Longer Want To Filter a Word, Send The /done Command !]], "md")
                else
                  send_msg(msg.message.chat.id, "• کلمه [ " .. name .. " ] فیلتر شد !\nاگر کلمه ای دیگری را نمیخواهید فیلتر کنید دستور /done را ارسال نمایید !", "md")
                end
                database:setex("Filtering:" .. user, 80, chat)
              else
                if database:get("lang:gp:" .. msg.message.chat.id) then
                  send_msg(msg.message.chat.id, "• Word `[" .. name .. "]` Can Not *Filtering* !", "md")
                else
                  send_msg(msg.message.chat.id, "• کلمه [ " .. name .. " ] قابل فیلتر شدن نمیباشد !", "md")
                end
                database:setex("Filtering:" .. user, 80, chat)
                return
              end
            end
          end
        end
      end
    end
  end
end
return start()

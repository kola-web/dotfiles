-- mini-template.yazi
--
-- 在 yazi 的当前目录下，从 Neovim 的小程序模板目录创建 component / page。
-- 对应原 mini.files 的 wc / wp。
--
-- 绑定（见同目录上一级的 keymap.toml）：
--   w c  -> plugin mini-template -- --kind=component
--   w p  -> plugin mini-template -- --kind=page
--
-- 模板目录：
--   Windows: %LOCALAPPDATA%\nvim\template
--   其他:    $HOME/.config/nvim/template
-- 模板子目录：wxmlComponent / wxmlPage

local KINDS = {
	component = { dir = "wxmlComponent", label = "Component" },
	page = { dir = "wxmlPage", label = "Page" },
}

local get_cwd = ya.sync(function()
	return tostring(cx.active.current.cwd)
end)

--- 返回可用的 PowerShell 名称；非 Windows 返回 nil
local function find_shell()
	if ya.target_os() ~= "windows" then
		return nil
	end
	for _, name in ipairs({ "pwsh", "powershell" }) do
		local out = Command(name)
			:arg { "-NoProfile", "-NonInteractive", "-Command", "$PSVersionTable.PSVersion.Major" }
			:output()
		if out and out.status.success then
			return name
		end
	end
	return nil
end

local function trim(s)
	return (s:gsub("^%s+", ""):gsub("%s+$", ""))
end

--- 模板根目录
local function template_root(shell)
	if shell then
		local out = Command(shell)
			:arg { "-NoProfile", "-NonInteractive", "-Command", "[Environment]::GetFolderPath('LocalApplicationData')" }
			:output()
		if out and out.status.success then
			local base = trim(out.stdout)
			if base ~= "" then
				return base .. "\\nvim\\template"
			end
		end
		return nil
	end

	local out = Command("sh"):arg { "-c", 'printf %s "$HOME/.config/nvim/template"' }:output()
	if out and out.status.success then
		local root = trim(out.stdout)
		if root ~= "" then
			return root
		end
	end
	return nil
end

--- 递归复制目录（Windows 用 PowerShell，其余用 cp -R）
local function copy_tree(shell, src, dst)
	if shell then
		local function quote(s)
			return "'" .. s:gsub("'", "''") .. "'"
		end
		local script = string.format(
			"Copy-Item -LiteralPath %s -Destination %s -Recurse -Force -ErrorAction Stop",
			quote(src),
			quote(dst)
		)
		local out = Command(shell)
			:arg { "-NoProfile", "-NonInteractive", "-Command", script }
			:output()
		if out == nil then
			return false, "无法启动 " .. shell
		end
		return out.status.success, trim(out.stderr)
	end

	local out = Command("cp"):arg { "-R", src, dst }:output()
	if out == nil then
		return false, "无法启动 cp"
	end
	return out.status.success, trim(out.stderr)
end

local function notify(content, level)
	ya.notify {
		title = "mini-template",
		content = content,
		timeout = 4,
		level = level or "info",
	}
end

return {
	entry = function(_, job)
		local kind = job.args.kind or job.args[1]
		local spec = KINDS[kind]
		if spec == nil then
			notify("未知类型: " .. tostring(kind), "error")
			return
		end

		local shell = find_shell()
		local root = template_root(shell)
		if root == nil then
			notify("找不到模板根目录", "error")
			return
		end

		local src = Url(root):join(Url(spec.dir))
		local cha = fs.cha(src)
		if cha == nil or cha.is_dir == false then
			notify("模板不存在: " .. tostring(src), "error")
			return
		end

		local cwd = get_cwd()
		local name, event = ya.input {
			pos = { "top-center", y = 2, w = 46 },
			title = spec.label .. " 名称（如 index）:",
			value = "",
		}
		if event ~= 1 or name == nil then
			return
		end

		name = trim(name)
		if name == "" then
			return
		end
		if name:find("[/\\]") then
			notify("名称不能包含路径分隔符", "warn")
			return
		end

		local dst = Url(cwd):join(Url(name))
		if fs.cha(dst) ~= nil then
			notify("目标已存在: " .. tostring(dst), "warn")
			return
		end

		local ok, err = copy_tree(shell, tostring(src), tostring(dst))
		if not ok then
			notify("创建失败: " .. (err ~= "" and err or tostring(dst)), "error")
			return
		end

		ya.emit("reveal", { dst })
		notify(spec.label .. " 已创建: " .. name, "info")
	end,
}

local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")
local b = require("luasnip.extras.conditions.expand").line_begin
local events = require("luasnip.util.events")
local postfix = require("luasnip.extras.postfix").postfix

local math_mode = function()
	return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

local try_replace = function(c)
	if c == "q" then return "\\psi"
	elseif c == "Q" then return "\\Psi"
	elseif c == "p" then return "\\phi"
	elseif c == "P" then return "\\Phi"
	end
	return c
end

return {
	s(
		{ trig = "ket", snippetType = "autosnippet", wordTrig = false },
		{
			t("\\ket{"), i(1), t("} "), i(0)
		},
		{ condition = math_mode }
	)
,
	s(
		{ trig = "bra", snippetType = "autosnippet", wordTrig = false },
		{
			t("\\bra{"), i(1), t("} "), i(0)
		},
		{ condition = math_mode,
	--callbacks = {
	--[1] = {[events.leave] = function(node, _)
	--	local replace = try_replace(node:get_text()[1])
	--	vim.notify(replace)
	--	node:set_text(0, replace)
	--end }}}
}
),
s(
	{ trig = "bkt", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\braket{<>}{<>} <>
	]],
	{
		i(1), i(2), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "dag", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	^{\dagger} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "hbar", snippetType = "autosnippet", wordTrig = false, priority = 1200 },
	fmta([[
	\hbar <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
)
}

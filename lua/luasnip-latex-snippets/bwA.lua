local ls = require("luasnip")
local t = ls.text_node
local i = ls.insert_node

local M = {}

function M.retrieve(not_math)
  local utils = require("luasnip-latex-snippets.util.utils")
  local pipe = utils.pipe

  local conds = require("luasnip.extras.expand_conditions")
  local condition = pipe({ conds.line_begin, not_math })

  local parse_snippet = ls.extend_decorator.apply(ls.parser.parse_snippet, {
    condition = condition,
  }) --[[@as function]]

  local s = ls.extend_decorator.apply(ls.snippet, {
    condition = condition,
  }) --[[@as function]]

  return {
    s(
      { trig = "ali", name = "Align" },
      { t({ "\\begin{align*}", "\t" }), i(1), t({ "", ".\\end{align*}" }) }
    ),

    parse_snippet(
      { trig = "tuilun", name = "corollary" },
      "\\begin{corollary}[$1]\n\t$2\n\\end{corollary} \n\t$0"
    ),
    parse_snippet(
      { trig = "dingli", name = "theorem" },
      "\\begin{theorem}[$1]\n\t$2\n\\end{theorem} \n\t$0"
    ),
    parse_snippet(
      { trig = "btab", name = "book table" },
        "\\begin{table}[htpb] \n \t \\centering \n\t \\caption{${1:caption}} \n\t \\begin {tabular} \n\t \\toprule \n\t $0 \\midrule \n\t \\bottomrule \n \\end{tabular} ",
    ),
    parse_snippet({ trig = "beg", name = "begin{} / end{}" }, "\\begin{$1}\n\t$0\n\\end{$1}"),
    parse_snippet({ trig = "case", name = "cases" }, "\\begin{cases}\n\t$1\n\\end{cases}"),

    s({ trig = "bigfun", name = "Big function" }, {
      t({ "\\begin{align*}", "\t" }),
      i(1),
      t(":"),
      t(" "),
      i(2),
      t("&\\longrightarrow "),
      i(3),
      t({ " \\", "\t" }),
      i(4),
      t("&\\longmapsto "),
      i(1),
      t("("),
      i(4),
      t(")"),
      t(" = "),
      i(0),
      t({ "", ".\\end{align*}" }),
    }),
  }
end

return M

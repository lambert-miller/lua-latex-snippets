local ls = require("luasnip")
local utils = require("luasnip-latex-snippets.util.utils")
local pipe = utils.pipe

local M = {}

function M.retrieve(not_math)
  local parse_snippet = ls.extend_decorator.apply(ls.parser.parse_snippet, {
    condition = pipe({ not_math }),
  }) --[[@as function]]

  return {
    parse_snippet({ trig = "mk", name = "Math" }, "$ ${1:${TM_SELECTED_TEXT}} $ $0"),
    parse_snippet(
      { trig = "md", name = "Math" },
      "$ \\displaystyle  ${1:${TM_SELECTED_TEXT}} $ $0"
    ),
    parse_snippet({ trig = "dm", name = "Block Math" }, "\\[\n\t${1:${TM_SELECTED_TEXT}}\n.\\] $0"),
    parse_snippet({ trig = "ss1", name = "section" }, "\\section { $1} \n $0 "),
    parse_snippet({ trig = "ss2", name = "subsection" }, "\\subsection { $1} \n $0 "),
    parse_snippet({ trig = "ss3", name = "subsubsection" }, "\\subsubsection { $1} \n $0 "),
  }
end

return M

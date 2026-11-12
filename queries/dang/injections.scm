; Multi-line strings with a language tag: highlight the body using the named
; language. Interpolated `${...}` regions are left out of the injection so they
; remain Dang. The body of a `"""` string still holds its escapes as written.
(multi_template
  (lang_tag_part (lang_tag_name) @injection.language)
  (multi_template_part !e)+ @injection.content)

(triple_quote_string
  (lang_tag_part (lang_tag_name) @injection.language)
  [(string_content) (immediate_escape)]+ @injection.content)

(triple_single_quote_string
  (lang_tag_part (lang_tag_name) @injection.language)
  (string_content) @injection.content)

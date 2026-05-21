;; Keywords
[
  (let_token)
  (pub_token)
] @keyword

[
  (type_token)
  (interface_token)
  (union_token)
  (implements_token)
  (enum_token)
  (scalar_token)
  (if_token)
  (else_token)
  (for_token)
  (break_token)
  (continue_token)
  (case_token)
  (assert_token)
  (directive_token)
  (on_token)
  (import_token)
  (new_token)
  (try_token)
  (catch_token)
  (raise_token)
  (return_token)

  (and_token)
  (or_token)
] @keyword

(self_keyword) @variable.builtin

;; Literals
(string) @string
(string (immediate_escape) @string.escape)
(doc_string) @string
(triple_quote_string) @string
(single_template) @string
(multi_template) @string
(multi_template
  (lang_tag_part (lang_tag_name) @label))
(int) @number
(boolean) @boolean
(null) @constant.builtin

;; Comments
(comment_token) @comment

;; Types
(upper_token) @type

;; Directives
(directive_name) @function.macro
(directive_application
  (id) @function.macro)
(directive_location
  (upper_id) @constant.builtin)

;; Operators and punctuation
[
  (equal_token)
  (plus_equal_token)
  (double_interro_token)
  (bang_token)
  (arrow_token)
  (ampersand_token)
] @operator

["{{" "}}" "{" "}" "[" "]" "(" ")"] @punctuation.bracket

[
  (comma_token)
  (dot_token)
] @punctuation.delimiter

["@" "|"] @punctuation.special

;; Identifiers
(symbol) @variable
(call (symbol) @function.call)

;; Key-value pairs
(key_value
  (word_token) @property)

;; Built-in functions
((call
  (symbol) @function.builtin)
  (#match? @function.builtin "^(print|toJSON)$"))

;; Field selections
(select_or_call
  (field_id) @function.method.call)

;; Object selection
(field_selection
  (id) @property)

;; Error
(ERROR) @error

;; Slot definitions
(type_and_block_slot
  (symbol) @function.method)
(type_and_args_and_block_slot
  (symbol) @function.method)
(type_and_value_slot
  (symbol) @function.method)
(value_only_slot
  (symbol) @function.method)
(type_only_slot
  (symbol) @function.method)
(type_only_fun_slot
  (symbol) @function.method)

;; Parameters
(arg_with_block_default
  (symbol) @variable.parameter)
(arg_with_type
  (symbol) @variable.parameter)
(arg_with_default
  (symbol) @variable.parameter)

;; Type definitions
(class (symbol) @type)
(implements (symbol) @type)
(interface (symbol) @type)
(enum (symbol) @type)
(enum (caps_symbol) @property)
(scalar (symbol) @type)

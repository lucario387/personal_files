;; extends

(
  method_invocation
    name: (identifier) @_method
    arguments: 
      (argument_list . [ (string_literal) (text_block) ] @printf)
  (#any-of? @_method "format" "printf")
)

;; extends

(method_invocation
  name: (identifier) @_method
  (#any-of? @_method "format" "printf")
  arguments: (argument_list . 
    [
      (string_literal) 
      (text_block)
    ]
    @printf
  )
)

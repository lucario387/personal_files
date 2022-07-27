;; extends
; el.innerHTML = `<html>`
(assignment_expression
  left: (member_expression
          property: (property_identifier) @_prop
          (#match? @_prop "(out|inn)erHTML"))
  right: (template_string) @html
    (#offset! @html 0 1 0 -1))

; el.innerHTML = '<html>'
(assignment_expression
   left: (member_expression
           property: (property_identifier) @_prop
           (#match? @_prop "(out|inn)erHTML"))
   right: (string) @html
            (#offset! @html 0 1 0 -1))

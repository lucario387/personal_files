;; extends
; el.innerHTML = `<html>`
(
  assignment_expression
    left: 
      (member_expression
        property: (property_identifier) @_prop)
    right: (template_string) @html

  (#match? @_prop "(out|inn)erHTML")
  (#offset! @html 0 1 0 -1)
)

; el.innerHTML = '<html>'
(
  assignment_expression
    left: 
      (member_expression
        property: (property_identifier) @_prop)
    right: (string) @html

  (#match? @_prop "(out|inn)erHTML")
  (#offset! @html 0 1 0 -1)
)

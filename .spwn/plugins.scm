(require-builtin steel/time)

; Set the current year
(define (info text) (string-replace text "{{ year }}" (local-time/now! "%Y")))

(define (validate identifier value)
  (case identifier
    [("vendor") (validate-vendor value)]
    [("name") (validate-name value)]
    [else #t]))

; Validate vendor name
(define (validate-vendor vendor)
  (cond
    [(string-contains? vendor " ") "Vendor name can't contain spaces"]
    [else #t]))

; Validate module name
(define (validate-name module)
  (cond
    [(string-contains? module " ") "Module name can't contain spaces"]
    [else #t]))

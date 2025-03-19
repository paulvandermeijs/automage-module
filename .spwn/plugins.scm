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

; Find Magento root
(define (cwd cwd)
  (define (search path)
    (if (string=? path "")
      #f
      (let ((composer-path (string-append path "/composer.json")))
        (if (is-file? composer-path)
          (let* ((file-str (read-port-to-string (open-input-file composer-path)))
                 (data (string->jsexpr file-str)))
            (if (and (hash-contains? data 'type)
                 (string=? (hash-ref data 'type) "project"))
              path
              (search (parent-name path))))
          (search (parent-name path))))))
  (let ((found (search cwd)))
    (if found
      (string-append found "/app/code")
      cwd)))

#(define (char-punctuation? ch)
  (char-set-contains? char-set:punctuation ch))

#(define char-set:dynamics
  (char-set #\f #\m #\p #\r #\s #\z))

#(define composite-chars
  (char-set-union char-set:dynamics char-set:punctuation))

#(define-markup-command (dynamic-text layout props str) (string?)
  "Takes a string, puts out a line-markup.
Parts of @var{strg} containing only characters used for dynamics are printed
using \\dynamic (punctuation-signs are disregarded.
Other parts are printed \\italic.

@lilypond[verbatim,quote]
\\markup {
  \\dynamic-text #\"poco f, but p sub. ma non troppo\"
}
@end lilypond
"
  (let* ((str-list (string-split str #\space))
         (text-markup
           (lambda (s) (make-normal-text-markup (make-italic-markup s)))))
    (interpret-markup layout props
      (make-whiteout-markup    ;;agregado por mi!
      (make-line-markup
        ;; iterate over 'str-list'
        ;; - parts only containing dynamics/punctuation are splitted.
        ;;   dynamics are printed \dynamic, others \italic
        ;;   and finally \concat is applied
        ;; - others are printed \italic
        (map
          (lambda (word)
            (if (string-every composite-chars word)
                (let ((word-lst (string->list word)))
                  (make-concat-markup
                    (map
                      (lambda (ch)
                        (let ((print-ch (string ch)))
                          (if (char-punctuation? ch)
                              (text-markup print-ch)
                              (make-dynamic-markup print-ch))))
                      word-lst)))
                (text-markup word)))
          str-list))))))

custDyn =
#(define-event-function (strg) (string?)
"Takes a string and puts out a (composed) dynamic script.
If the first word of the composed string is a dynamic sign, the ready dynamic-
script center-aligns this word at the parent-grob.
Further adapting the result with additional tweaks for X-offset are possible.
"
  (let* ((first-word (car (string-split strg #\space)))
         ;; don't take punctuation into account
         (trimmed-first-word (string-trim-both first-word char-set:punctuation))
         (offset
           (lambda (grob)
             (let* (;; get previous tweaks for X-offset and add their values
                    ;; they are added to the final result
                    (x-offset-tweaks
                      (filter
                        (lambda (tw)
                          (and (number? (cdr tw)) (eq? (car tw) 'X-offset)))
                        (ly:prob-property
                          (ly:grob-property grob 'cause)
                          'tweaks)))
                    (x-off (apply + (map cdr x-offset-tweaks))))
               ;; if 'first-word' is a dynamic, calculate it's x-extent and
               ;; return half of it's value
               ;; always take 'x-off' into account
               (if (string-every composite-chars first-word)
                   (let* ((layout (ly:grob-layout grob))
                          (props
                            (ly:grob-alist-chain grob
                              (ly:output-def-lookup
                                layout
                                'text-font-defaults)))
                          (first-word-stil
                            (interpret-markup layout props
                              (make-dynamic-text-markup trimmed-first-word)))
                          (first-word-stil-center
                            (interval-center
                              (ly:stencil-extent first-word-stil X))))
                     (+ x-off (- first-word-stil-center)))
                    ;; adding -1 is my choice
                    (+ x-off -1))))))

    #{
      -\tweak X-offset $offset
      #(make-dynamic-script (make-dynamic-text-markup strg))
    #}))



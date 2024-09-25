%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%       Corchetes para revisiones   %%%%%%%
%%%       Federico Sarudiansky        %%%%%%%
%%%       2020-04-28		       %%%%%%%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\version "2.24.3"

%Mi primer función en Scheme

bracketArpeggioPS = {
  \once \override PianoStaff.Arpeggio.padding = #1
  \once \override PianoStaff.Arpeggio.stencil =
    #(grob-transformer 'stencil
      (lambda (grob orig)
            (ly:stencil-aligned-to 
               (ly:stencil-combine-at-edge
                      (ly:stencil-combine-at-edge
                      orig
                      Y
                      1
                      (grob-interpret-markup
                        grob
                        (markup #:center-align #:fontsize -1
                                #:bold #:rotate -90 "["))
                      0.5)
                Y
                (- 1)
                (grob-interpret-markup
                  grob
                  (markup #:center-align #:fontsize -1
                          #:bold #:rotate 90 "["))
                0.5) 
               X 
               -0.8
               )))
}

bracketArpeggio = {
  \once \override Staff.Arpeggio.padding = #1
  \once \override Staff.Arpeggio.stencil =
    #(grob-transformer 'stencil
      (lambda (grob orig)
            (ly:stencil-aligned-to 
               (ly:stencil-combine-at-edge
                      (ly:stencil-combine-at-edge
                      orig
                      Y
                      1
                      (grob-interpret-markup
                        grob
                        (markup #:center-align #:fontsize -1
                                #:bold #:rotate -90 "["))
                      0.5)
                Y
                (- 1)
                (grob-interpret-markup
                  grob
                  (markup #:center-align #:fontsize -1
                          #:bold #:rotate 90 "["))
                0.5) 
               X 
               -0.8
               )))
}





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Notas y articulaciones entre corchetes  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sirve para poner notas entre corchetes. No funciona con acordes completos 
% pero sí con notas dentro de acordes

% Uso: c d \bracketify e f  <c \bracketify e g c>
% pone los mies entre corchetes

#(define-public (bracket-stencils grob)
  (let ((lp (grob-interpret-markup grob (markup #:fontsize 3.5 #:translate (cons -0.5 -0.5) "[")))
        (rp (grob-interpret-markup grob (markup #:fontsize 3.5 #:translate (cons  0.0 -0.5) "]"))))
    (list lp rp)))

bracketify = #(define-music-function (parser loc arg) (ly:music?)
   (_i "Tag @var{arg} to be parenthesized.")
#{
  %\once \override Parentheses.stencils = #bracket-stencils
  \tweak Parentheses.stencils #bracket-stencils
  \tweak padding #1
  \parenthesize $arg
#})

bracketizer =
#(grob-transformer 'stencil
                   (lambda (grob default)
                     (bracketify-stencil default Y 0.1 0.5 0.3)))

% se usa:
% \once\override Rest.stencil = \bracketizer
% Y hace un corchete del tamaño del objeto


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alteraciones entre corchetes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pone corchetes en alteraciones dudosas, ya sea al lado de la nota como arriba del pentagrama

% Uso: c4 \brackAcc d? e f c \brackAccCaut d? e f  c \brackAcc ees? \brackAccCaut geses? \brackAcc eisis? \brackAccCaut cis? e g e
% Hay que poner siempre ? a la nota. Si no no funciona y hace cosas raras

%{

#(define (parenthesizesq grob m)
   (let* ((fm (ly:grob-default-font grob))
          (op (ly:font-get-glyph fm "accidentals.leftparen"))
          (cl (ly:font-get-glyph fm "accidentals.rightparen"))
          (m (ly:stencil-combine-at-edge m X LEFT op 0))
          (m (ly:stencil-combine-at-edge m X RIGHT cl 0)))
     m))

#(define (parenthesizesq grob mol)
   (let* ((ext (ly:stencil-extent mol Y))
          (ss (ly:staff-symbol-staff-space grob))
          (ext (interval-widen ext (/ ss 2.0)))
          ; too thin
          ;(thickness (ly:output-def-lookup (ly:grob-layout grob) 'line-thickness))
          (thickness 0.2)
          (protrusion 0.5)
          (lb (ly:bracket Y ext thickness protrusion))
          (rb (ly:bracket Y ext thickness (- protrusion)))
          (mol (ly:stencil-combine-at-edge mol X LEFT lb 0))
          (mol (ly:stencil-combine-at-edge mol X RIGHT rb 0)))
     mol))

#(define accidental-interface::square-brackets
   (lambda (grob)
     (let* ((fm (ly:grob-default-font grob))
            (alist (ly:grob-property grob 'alteration-glyph-name-alist))
            (alt (ly:grob-property grob 'alteration))
            (glyph-name (ly:assoc-get alt alist #f))
            (mol (if (string? glyph-name)
                     (ly:font-get-glyph fm glyph-name)
                     (begin
                      (ly:warning (_ "Could not find glyph-name for alteration ~s") alt)
                      (ly:font-get-glyph fm "noteheads.s1cross"))))
            (mol (if (eq? #t (ly:grob-property grob 'restore-first))
                     (let ((acc (ly:font-get-glyph fm "accidentals.natural")))
                       (if (ly:stencil? acc)
                           (ly:stencil-combine-at-edge mol X LEFT acc 0.1)
                           (begin
                            (ly:warning "natural alteration glyph not found")
                            mol)))
                     mol)))
       (if (eq? #t (ly:grob-property grob 'parenthesized))
           (parenthesizesq grob mol)
           mol))))



brackAcc= {
  \once \override Staff.AccidentalCautionary.stencil = #accidental-interface::square-brackets
}

brackAccCaut = {
  \once \override AccidentalSuggestion.avoid-slur = #'ignore 
  \once \set suggestAccidentals=##t 
  \once \override Staff.AccidentalSuggestion.parenthesized = ##t 
  \once \override Staff.AccidentalSuggestion.stencil = #accidental-interface::square-brackets 
}

%}

bracketAcc = {
  \once \override AccidentalCautionary.parenthesized = ##f
  \once \override AccidentalCautionary.stencil =
  #(lambda (grob)
     (let* ((paren-stil 
              (grob-interpret-markup grob 
                (markup #:musicglyph "accidentals.leftparen")))
            (axis Y)
            (other-axis (lambda (a) (remainder (+ a 1) 2)))
            (ext (ly:stencil-extent paren-stil axis))
            (stil (ly:accidental-interface::print grob))
            (thick 
              (ly:output-def-lookup (ly:grob-layout grob) 'line-thickness 0.1))
            (padding thick)
            (protrusion (* 2.5 thick))
            (lb (ly:bracket axis ext thick protrusion))
            (rb (ly:bracket axis ext thick (- protrusion))))
       (set! stil
             (ly:stencil-combine-at-edge stil (other-axis axis) 1 rb padding))
       (set! stil
             (ly:stencil-combine-at-edge stil (other-axis axis) -1 lb padding))
       stil))
}

bracketAccCaut = {
  \once \override AccidentalSuggestion.avoid-slur = #'ignore 
  \once \set suggestAccidentals=##t 
  \once \override Staff.AccidentalSuggestion.parenthesized = ##f
  \once \override AccidentalSuggestion.stencil =
  #(lambda (grob)
     (let* ((paren-stil 
              (grob-interpret-markup grob 
                (markup #:musicglyph "accidentals.leftparen")))
            (axis Y)
            (other-axis (lambda (a) (remainder (+ a 1) 2)))
            (ext (ly:stencil-extent paren-stil axis))
            (stil (ly:accidental-interface::print grob))
            (thick 
              (ly:output-def-lookup (ly:grob-layout grob) 'line-thickness 0.1))
            (padding thick)
            (protrusion (* 2.5 thick))
            (lb (ly:bracket axis ext thick protrusion))
            (rb (ly:bracket axis ext thick (- protrusion))))
       (set! stil
             (ly:stencil-combine-at-edge stil (other-axis axis) 1 rb padding))
       (set! stil
             (ly:stencil-combine-at-edge stil (other-axis axis) -1 lb padding))
       stil))
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matices y reguladores entre corchetes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Uso:     
%reguladores
%     \brackHairpin c4 \< d e f g\! \brackHairpin c,^\< d e d\!
%     \brackLHairpin c4 \< d e f g \brackRHairpin d \> e d\!
%     \brackLHairpin c4 \< d e\! f g \brackRHairpin d\> e \! \break
     
%dim y cresc. como reguladores
%     c4 \brackDim d e f g\! c,\brackCresc d e\! \break
  
% dinámicas
%     c \brackDyn \fff \< d e f g a b c\! \break

hairpinBetweenText =
#(define-music-function (parser location leftText rightText) (markup? markup?)	
   #{
     \once \override Hairpin.stencil =
     #(lambda (grob)
        (ly:stencil-combine-at-edge
         (ly:stencil-combine-at-edge
          (ly:stencil-aligned-to (grob-interpret-markup grob leftText) Y CENTER)
          X RIGHT
          (ly:stencil-aligned-to (ly:hairpin::print grob) Y CENTER)
          0)
         X RIGHT
         (ly:stencil-aligned-to (grob-interpret-markup grob rightText) Y CENTER)
         0.6))
   #})

brackHairpin = { 
  \once \override Hairpin.padding = #40
  \once \override Hairpin.shorten-pair=#'( 1 . 1 ) 
  \once \override Hairpin.minimum-length=#5
  \hairpinBetweenText \markup " [" \markup "]" 
}

brackLHairpin = { 
  \once \override Hairpin.shorten-pair=#'( 1 . 0 ) 
  \once \override Hairpin.minimum-length=#3
  \hairpinBetweenText \markup " [" \markup "" 
}

brackRHairpin = { 
  \once \override Hairpin.shorten-pair=#'( 0 . 1 ) 
  \once \override Hairpin.minimum-length=#3
  \hairpinBetweenText \markup "" \markup "]" 
}

brackCresc = #(define-event-function (parser location) ()
    #{  
      \tweak bound-details.left.text \markup\concat { \lower #.1 \normal-text "[" "cresc." }
      \tweak bound-details.left.attach-dir #-2
      \tweak bound-details.right-broken.text ##t
      \tweak bound-details.left-broken.text ##t
      \tweak bound-details.right.text \markup { \normal-text \lower #.5 " ]" }
      \tweak bound-details.right.attach-dir # .5
      \tweak shorten-pair #'( 2 . 2 )
      \tweak X-offset #2
      \cresc
    #})

brackDim = #(define-event-function (parser location) ()
    #{  
      \tweak bound-details.left.text \markup\concat { \lower #.1 \normal-text "[" "dim." }
      \tweak bound-details.left.attach-dir #-2
      \tweak bound-details.right-broken.text ##t
      \tweak bound-details.left-broken.text ##t
      \tweak bound-details.right.text \markup { \normal-text \lower #.5 " ]" }
      \tweak bound-details.right.attach-dir # .5
      \tweak shorten-pair #'( 2 . 2 )
      \tweak X-offset #2
      \dim
    #})

brackDyn =
#(define-event-function (parser location dyn) (ly:event?)
   (make-dynamic-script
    #{ \markup \concat {
         \normal-text  \fontsize #2 "["
	 \pad-x #0.2 #(ly:music-property dyn 'text)
	 \normal-text  \fontsize #2 "]"
       }
    #}))


brackTS = \once \override Staff.TimeSignature.stencil = #(lambda (grob)(bracketify-stencil (ly:time-signature::print grob) Y 0.1 0.2 0.1))


brackTextSpan =
#(define-event-function (comienzo)
                    (markup?)
  #{
    \tweak bound-details.left.text \markup {\concat {\normal-text "[" \italic #comienzo } }
    \tweak bound-details.right.text \markup \normal-text "]"
    \tweak bound-details.left-broken.text ##f
    \tweak bound-details.right-broken.text ##f
    \startTextSpan
  #})

brackClef = \once \override Staff.Clef.stencil = #(lambda (grob)
    (bracketify-stencil (ly:clef::print grob) Y 0.1 0.2 0.1))

#(define (special-bracketify original-stencil len thick protusion padding)
  (let* (
         (left-bracket (ly:bracket Y (cons (- len) len) thick (- protusion)))
         (right-bracket (ly:bracket Y (cons (- len) len) thick protusion)))
    (set! original-stencil
	  (ly:stencil-combine-at-edge original-stencil X RIGHT right-bracket (- -0.73 padding)))
    (set! original-stencil
	 (ly:stencil-combine-at-edge original-stencil X RIGHT left-bracket padding))
    original-stencil))

bracketDot = \once \override Dots.stencil = #(lambda (grob)
    (special-bracketify (ly:dots::print grob) 0.4 0.1 0.2 -0.15)) 
% first number (0.4): bracket length
% second number (0.1): thickness
% third number (0.2): protrusion
% fourth number (0.1): space between dot and brackets


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PRUEBAS                               %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
\score {
  \relative c''{
     %notas
     c d \bracketify e f  <c \bracketify e g c> c d \bracketify e f g f \bracketify e d r4 r2 \break
     
     %articulaciones
     c,4 <d f>-\bracketify-. e^\bracketify-. f^\bracketify-> g_\bracketify-> a g g \bracketify \fermata
     
     %alteraciones
     c4 \bracketAcc d? e f 
     c \bracketAccCaut d? e f  
     c \bracketAcc ees? 
     \bracketAccCaut geses? 
     \bracketAcc eisis? 
     \bracketAccCaut cis? e g e \break
     
     %reguladores
     \brackHairpin c4 \< d e f g\! \brackHairpin c,^\< d e d\!
     \brackLHairpin c4 \< d e f g \brackRHairpin d \> e d\!
     \brackLHairpin c4 \< d e\! f g \brackRHairpin d\> e \! \break
     
     %dim y cresc. como reguladores
     c4 \brackDim d e f g\! c,\brackCresc d e\! \break
     
     % dinámicas
     c \brackDyn \fff \< d e f g a b c\! \break
  }
}
%}

%{
convert-ly (GNU LilyPond) 2.24.3  convert-ly: Procesando «»...
Aplicando la conversión: 2.23.1, 2.23.2, 2.23.3, 2.23.4, 2.23.5,
2.23.6, 2.23.7, 2.23.8, 2.23.9, 2.23.10, 2.23.11, 2.23.12, 2.23.13,
2.23.14, 2.24.0
%}

\version "2.25.15"

\include "../ily/brackets.ily"
\include "../ily/makeOctaves.ily"
\include "../ily/copyArticulations.ily"
\include "../ily/changePitch.ily"
\include "../ily/custDyn.ily"


% opposing fermatas on a bar line

twoWayFermata = {
  \once \set Staff.caesuraType = #'((underlying-bar-line . "||"))
  \once \set Staff.caesuraTypeTransform = ##f
  \caesura ^\fermata _\fermata
}

%% Arpeggio bracket en un GrandStaff 
%% LSR466
arpeggioBracketGSOn = \override GrandStaff.Arpeggio.stencil = #ly:arpeggio::brew-chord-bracket

arpeggioBracketGSOff = \revert GrandStaff.Arpeggio.stencil 


%% Puntitos
%% http://lsr.di.unimi.it/LSR/Item?id=772
tongue =
#(define-music-function (dots) (integer?)
  #{
    \tweak stencil
      #(lambda (grob)
        (let ((stil (ly:script-interface::print grob)))
          (let loop ((count (1- dots)) (new-stil stil))
            (if (> count 0)
                (loop (1- count)
                      (ly:stencil-combine-at-edge new-stil X RIGHT stil 0.2))
                (ly:stencil-aligned-to new-stil X CENTER)))))
     \staccato
  #})


%Textos de PartCombine
initPartCombine = {
  \set Staff.soloText = \markup \normal-text \small "I."
  \set Staff.soloIIText = \markup \normal-text \small "II."
  \set Staff.aDueText = \markup \normal-text \small "a 2"
}

% Reguladores con texto centrado. Tomado de LSR 233
hairpinWithCenteredText =
#(define-music-function (text) (markup?)
  #{
    \once \override Voice.Hairpin.after-line-breaking = 
      #(lambda (grob)
        (let* ((stencil (ly:hairpin::print grob))
               (par-y (ly:grob-parent grob Y))
               (dir (ly:grob-property par-y 'direction))
               (staff-line-thickness
                 (ly:output-def-lookup (ly:grob-layout grob) 'line-thickness))
               (new-stencil (ly:stencil-aligned-to
                 (ly:stencil-combine-at-edge
                   (ly:stencil-aligned-to stencil X CENTER)
                   Y dir
                   (ly:stencil-aligned-to
                     (grob-interpret-markup
                       grob
                       (make-fontsize-markup
                         (magnification->font-size
                           (+ (ly:staff-symbol-staff-space grob)
                              (/ staff-line-thickness 2)))
                           text)) X CENTER))
                 X LEFT))
               (staff-space (ly:output-def-lookup
                 (ly:grob-layout grob) 'staff-space))
               (par-x (ly:grob-parent grob X))
               (dyn-text (grob::has-interface par-x 'dynamic-text-interface))
               (dyn-text-stencil-x-length
                 (if dyn-text
                   (interval-length 
                     (ly:stencil-extent (ly:grob-property par-x 'stencil) X))
                   0))
               (x-shift 
                 (if dyn-text 
                   (- 
                     (+ staff-space dyn-text-stencil-x-length)
                     (* 0.5 staff-line-thickness)) 0)))
  
        (ly:grob-set-property! grob 'Y-offset 0)
        (ly:grob-set-property! grob 'stencil 
           (ly:stencil-translate-axis
            new-stencil
            x-shift X))))
  #})


% La instrucción básica de markup
#(define-markup-command (defaultText layout props text) (markup?)
  "formato estándar del texto dentro de la edición"
  (interpret-markup layout props
    #{ \markup \whiteout \concat \pad-around #0.2 { #text }
    #}))
  

% Span para indicar número de cuerda 
stringSpan =
#(define-event-function (cuerda)
                    (markup?)
  #{
    \tweak style #'solid-line  
    \tweak bound-details.right.text \markup { \draw-line #'(0 . -1) } 
    \tweak bound-details.left.text \markup \normal-text #cuerda 
    % \tweak bound-details.right-broken.text ##f
    \tweak bound-details.left-broken.text \markup \concat { \normal-text "(" \normal-text #cuerda \normal-text ")" }
    \startTextSpan
  #})


%Parentizador (paréntesis grandes)
parenthizer =
#(grob-transformer 'stencil
                   (lambda (grob default)
                     (parenthesize-stencil default Y 0.1 0.5 0.3)))

% se usa:
% \once\override Rest.stencil = \parenthizer
% Y hace un corchete del tamaño del objeto


%Equivalencias métricas
istesso =
  #(define-music-function (noteuno notedos) (ly:duration? ly:duration?)
    #{
      \tempo \markup { 
           \teeny
            \concat  {
             (
             \smaller \general-align #Y #DOWN \note #noteuno #UP 
             " = " 
             \smaller \general-align #Y #DOWN \note #notedos #UP 
             " )" }
        }
    #})

%Doble indicación de compás
#(define ((double-time one two oneden twoden) grob)
  (grob-interpret-markup grob
    (markup #:override '(baseline-skip . 0) #:number
      (#:line (
          (#:column (one oneden))
          (#:column (two twoden)))))))

#(define ((double-time-equal one two oneden twoden) grob)
  (grob-interpret-markup grob
    #{ \markup \override #'(baseline-skip . 0) \line { \column \number { #one #oneden } \vcenter \bold "=" \column \number { #two #twoden } } #} ))          

% Un hairpin to barline ##f
noCompas = \once \override Hairpin.to-barline=##f

parenAccCaut = {
  \once \override AccidentalSuggestion.avoid-slur = #'ignore 
  \once \set suggestAccidentals=##t 
  \once \override Staff.AccidentalSuggestion.parenthesized = ##t
}

compasConTexto =
#(define-music-function (texto) (markup?)
   #{ 
     \once \override Staff.BarLine.stencil =
     #(lambda (grob)
     (ly:stencil-combine-at-edge
      (ly:bar-line::print grob)
      X LEFT
      (grob-interpret-markup grob texto)
      0))
   #})

%Fermatas sobre compases
fermataUBar = { 
\once \override Score.TextMark.self-alignment-X = #CENTER \textEndMark \markup { \musicglyph "scripts.ufermata" }
} 

fermataDBar = { 
\once \override Score.TextMark.self-alignment-X = #CENTER 
\tweak direction #DOWN 
\textEndMark \markup { \musicglyph "scripts.dfermata" }
} 

fermataMark = { 
  \once \override Score.RehearsalMark.break-visibility = ##(#t #t #f)
  \mark \markup {\musicglyph "scripts.ufermata"}
}

%Time signature arrba de todo para ligaduras feas
%Poner arriba de todo
layerTS = #(define-music-function (parser location) ()
             #{
               \override Score.StaffSymbol.layer=#4 
               \override Staff.TimeSignature.layer=#3 
             #})
          
%Poner justo antes de la indicación de compás
whiteoutTS = \once \override Staff.TimeSignature.whiteout=##t


% separaciones "subbeams" manuales
sepizq= \set stemLeftBeamCount=#1 
sepder= \set stemRightBeamCount=#1 

%Laissez vibrer largos
extendLV =
#(define-music-function (further) (number?)
#{
  \once \override LaissezVibrerTie.X-extent = #'(0 . 0)
  \once \override LaissezVibrerTie.details.note-head-gap = #(- 0.2 (/ further 2))
  \once \override LaissezVibrerTie.extra-offset = #(cons (/ further 2) 0)
#})


%Voces extra
voiceFive = #(context-spec-music (make-voice-props-set 4) 'Voice)
voiceSix = #(context-spec-music (make-voice-props-set 5) 'Voice)



breatheDoble =  \override BreathingSign.text = \markup {
    \musicglyph "scripts.caesura.straight"
  }


% Crescendos y diminuendos con texto personalizados

custCrescTxt = #(define-music-function (texto)
                    (markup?) 
    #{  
      \once \set crescendoText = \markup { \italic { #texto } }  
      \once \set crescendoSpanner = #'text  
    #})


%Desplazamiento forzado
correte = #(define-music-function (desplaz) (number?)
  #{
    \once \override NoteColumn.force-hshift = #desplaz
  #})

%Desplazamiento forzado con supresión de colisiones: brutal
correteIC = #(define-music-function (desplaz) (number?)
  #{
    \once \override PianoStaff.NoteColumn.ignore-collision = ##t 
    \once \override Voice.NoteColumn.X-offset = #desplaz
  #})



%Tamaños de pentagrama
staffSize = #(define-music-function (new-size) (number?)
  #{
    \set fontSize = #new-size
    \override StaffSymbol.staff-space = #(magstep new-size)
    \override StaffSymbol.thickness = #(magstep new-size)
  #})

cd = \change Staff = "2"
cu = \change Staff = "1"

%Texto con puntitos...
startMyTxtSpan =
#(define-event-function (strng)
                    (markup?)
  #{
    \tweak bound-details.left.text \markup #strng
    \tweak bound-details.right-broken.text ##f
    \tweak bound-details.left-broken.text ##f
    \startTextSpan
    

  #})

startBeginEndSpan =
#(define-event-function (comienzo final)
                    (markup? markup?)
  #{
    \tweak bound-details.left.text \markup #comienzo
    \tweak bound-details.right.text \markup #final
    \tweak bound-details.left-broken.text ##f
    \tweak bound-details.right-broken.text ##f
    \startTextSpan
  #})

% Corchetes y números de n-sillos
tupletOff= {\override TupletBracket.stencil=##f \override TupletNumber.stencil=##f}
tupletOn= {\revert TupletBracket.stencil \revert TupletNumber.stencil}
tupletOnce={\once \override TupletBracket.stencil=##f \once \override TupletNumber.stencil=##f}


%Snippet para agregar corchetes de música optativa

% The number next to "th" in (th 0.2) controls thickness of the brackets. 
#(define-markup-command (left-bracket layout props) ()
"Draw left hand bracket"
(let* ((th 0.2) ;; todo: take from GROB
	(width (* 2.5 th)) ;; todo: take from GROB
	(ext '(-2.8 . 2.8))) ;; todo: take line-count into account
	(ly:bracket Y ext th width)))

leftBracket = {
  \once\override BreathingSign.text = #(make-left-bracket-markup)
  \once\override BreathingSign.break-visibility = #end-of-line-invisible
  \once\override BreathingSign.Y-offset = ##f
  % Trick to print it after barlines and signatures:
  \once\override BreathingSign.break-align-symbol = #'custos
  \breathe 
}


#(define-markup-command (right-bracket layout props) ()
"Draw right hand bracket"
  (let* ((th .2);;todo: take from GROB
          (width (* 2.5 th)) ;; todo: take from GROB
          (ext '(-2.8 . 2.8))) ;; todo: take line-count into account
        (ly:bracket Y ext th (- width))))

rightBracket = {
  \once\override BreathingSign.text = #(make-right-bracket-markup)
  \once\override BreathingSign.Y-offset = ##f
  \breathe
}

% medio corchete para indicar mano derecha dentro de un acorde
% se indica exclusivamente dentro del acorde. Si es una sola nota
% hay que indicar   \set fingeringOrientations=#'(left) antes


rhBrac = -\tweak self-alignment-Y #-1 \finger \markup { 
    \concat { 
    \path #0.1 #'((moveto 0 1)(rlineto 0 -2)(rlineto 0.5 -0.3)) 
}} 

lhBrac = -\tweak self-alignment-Y #1 \finger \markup { 
    \concat { 
    \path #0.1 #'((moveto -1 -1)(rlineto 0 2)(rlineto 0.5 0.3)) 
}} 

%Claves falsas
%% http://lsr.di.unimi.it/LSR/Item?id=326

fakeBassClef = {
  \set Staff.clefGlyph = #"clefs.F"
  \set Staff.clefPosition = #2
  \set Staff.middleCPosition = #-6
}

fakeTrebleClef = {
  \set Staff.clefGlyph = #"clefs.G"
  \set Staff.clefPosition = #-2
  \set Staff.middleCPosition = #6
}

fakeBassClefShift = {
  % Change default prefatory item order so that clef is printed after barline
  \override Score.BreakAlignment.break-align-orders =
    #(make-vector 3 '(span-bar
                      breathing-sign
                      staff-bar
                      clef
                      key
                      time-signature))
  \set Staff.clefGlyph = #"clefs.F"
  \set Staff.clefPosition = #-9
  \set Staff.middleCPosition = #6
}



% Respiración con fermata

breatheFermata = { \once \override BreathingSign.text = \markup {
    \override #'(direction . 1)
    \override #'(baseline-skip . 1.8)
    \dir-column {
      \translate #'(0.155 . 0)
        \center-align \musicglyph "scripts.caesura.curved"
      \center-align \musicglyph "scripts.ufermata"
    }
  }
}


%El pushNC para crossStaffs

pushNC =
\once \override NoteColumn.X-offset =
  #(lambda (grob)
    (let* ((p-c (ly:grob-parent grob X))
           (p-c-elts (ly:grob-object p-c 'elements))
           (stems
             (if (ly:grob-array? p-c-elts)
                 (filter
                   (lambda (elt)(grob::has-interface elt 'stem-interface))
                   (ly:grob-array->list p-c-elts))
                 #f))
           (stems-x-exts
             (if stems
                 (map
                   (lambda (stem)
                     (ly:grob-extent
                       stem
                       (ly:grob-common-refpoint grob stem X)
                       X))
                   stems)
                 '()))
           (sane-ext
             (filter interval-sane? stems-x-exts))
           (cars (map car sane-ext)))
    (if (pair? cars)
        (abs (- (apply max cars)  (apply min cars)))
        0)))


%Merge skips (que se usa con \compressEmptyMeasures y no con \compressMMRests)

#(define (append-merge x l r)
"Add x to the head of list l, merging skips, 
and if r is true also merging full measure rests."
  (if (and (pair? l)
           (ly:music? x)
           (ly:music? (car l))
           (or (and (music-is-of-type? x 'skip-event)
                    (music-is-of-type? (car l) 'skip-event))
               (and r
                    (music-is-of-type? x 'multi-measure-rest)
                    (music-is-of-type? (car l) 'multi-measure-rest)))
           (not (pair? (ly:music-property (car l) 'articulations))))
     (let ((total
            (ly:moment-add 
            (ly:music-duration-length (car l))
            (ly:music-duration-length x)
            )))
       (set! (ly:music-property x 'duration) 
              (make-duration-of-length total))
       (cons x (cdr l)))
    (cons x l)))

mergeSkips = #(define-music-function
 (parser location rests-also music) ((boolean?) ly:music?)
 "Merge successive skips in sequential music, 
  optionally merge full-measure rests as well."
 (music-map
   (lambda (m)
      (if (music-is-of-type? m 'sequential-music)
        (ly:music-set-property! m
           'elements
           (fold-right (lambda (x l)
                         (append-merge x l rests-also))
             '()
             (ly:music-property m 'elements))))
     m)
   music))
   
mergeFullBarRests = #(define-music-function
 (parser location music) (ly:music?)
 #{ \mergeSkips ##t $music #})
\version "2.20.0"

#(define-markup-command (puntitosmarkup layout props cant) (number?)
   (interpret-markup layout props
          #{ \markup  {
              \halign #(+ (* 2.5 cant) -6 )     
              $@(map (lambda (x) #{
               \markup { \hspace #-0.2
                 \musicglyph "scripts.staccato" } 
              #}) (iota cant)) } #} 
          ))

#(define-markup-command (puntitosligadosmarkup layout props cant) (number?)
   (interpret-markup layout props
                     
          #{ \markup  {
              %\override #(cons "direction" 1)
              \tie
              \raise #0.2
              \puntitosmarkup #cant } #}
          ))


%{

\relative c'{ \textLengthOn c4-\markup\puntitosligadosmarkup #6 d-\markup\puntitosmarkup #6 e f }

%}
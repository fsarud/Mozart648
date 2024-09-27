\version "2.25.13"

#(define-markup-command (oldStyleNum layout props text)
  (markup?)
  #:category font
  (interpret-markup layout props
    #{\markup \override #'(font-features . ("onum")) { #text }#}))

%\paper {
%  #(define fonts
%    (make-pango-font-tree "Linux Biolinum O"
%                          "Linux Biolinum O"
%                          "Luxi Mono"
%                          (/ staff-height pt 20)))
%}

\paper {
  property-defaults.fonts.serif = "Linux Biolinum O"
}


\layout {
    \context {
      \Score
      \override BarNumber.stencil = #(lambda (grob) (grob-interpret-markup grob (markup #:abs-fontsize 10 #:oldStyleNum (ly:grob-property grob 'text)))) 
      \override TextScript.stencil = #(lambda (grob) (grob-interpret-markup grob (markup #:oldStyleNum (ly:grob-property grob 'text)))) 
      %\override TupletNumber.stencil = #(lambda (grob) (grob-interpret-markup grob (markup #:oldStyleNum (ly:grob-property grob 'text)))) 
      \override RehearsalMark.stencil = #(lambda (grob) (grob-interpret-markup grob (markup #:oldStyleNum (ly:grob-property grob 'text)))) 
      \override MetronomeMark.stencil = #(lambda (grob) (grob-interpret-markup grob (markup #:oldStyleNum (ly:grob-property grob 'text)))) 
      \override TupletNumber.font-shape = #'()	
      \override BarNumber.Y-offset=#4 
      \override Hairpin.minimum-length = #2 % tamaño mínimo para hairpins
      \override MeasureCounter.font-name = "Linux Biolinum O"
      \override MultiMeasureRestNumber.font-name = "Linux Biolinum O"
      \override MultiMeasureRestNumber.font-size = #2
      %\override Fingering.font-size = #-1

      %\override StringNumber.font-name = "Linux Biolinum O"
      %\override OttavaBracket.stencil = #(lambda (grob) (grob-interpret-markup grob (markup #:oldStyleNum (ly:grob-property grob 'text)))) 
      %\override TupletNumber.stencil = #(lambda (grob) (grob-interpret-markup grob (markup #:oldStyleNum (ly:grob-property grob 'text))))
      \override DynamicTextSpanner.font-size= #0 
    }
    \context {
      \Lyrics
      \consists "Tweak_engraver"
    }
}

%Definiciones de textos de títulos

#(define-markup-command (fmtTitle layout props text) (markup?)
  (interpret-markup layout props
    #{\markup \oldStyleNum { \vspace #1.5 \abs-fontsize #22 { #text } } #}))

#(define-markup-command (fmtSubtitle layout props text) (markup?)
  (interpret-markup layout props
    #{\markup \oldStyleNum \abs-fontsize #14 { #text }#}))

#(define-markup-command (fmtSubsubtitle layout props text) (markup?)
  (interpret-markup layout props
    #{\markup \oldStyleNum \abs-fontsize #12 { #text }#}))

#(define-markup-command (fmtComposer layout props texta textb) (markup? markup?)
  (interpret-markup layout props
    #{\markup \oldStyleNum { \override #'(baseline-skip . 2.5 ) \abs-fontsize #14  
                 \center-column { \line { #texta } \line { #textb } \vspace #1 } } #}))

#(define-markup-command (fmtDedication layout props text) (markup?)
  (interpret-markup layout props
    #{\markup \oldStyleNum { \override #'(baseline-skip . 2.5 ) \abs-fontsize #12 { #text }  } #}))

%Para títulos de obras en varios movimientos
#(define-markup-command (fmtSecciones layout props text) (markup?) 
  (interpret-markup layout props
    #{\markup \oldStyleNum { \abs-fontsize #18 \override #'(baseline-skip . 2.5 ) { #text }  } #} ))

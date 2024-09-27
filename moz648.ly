\version "2.25.16"

\include "./1.ly"
\include "./2.ly"
\include "./3.ly"
\include "./4.ly"
\include "./5.ly"
\include "./6.ly"
\include "./7.ly"

\include "./ily/estiloBiolinum.ily"

\book {
    \bookOutputSuffix "vl1"

    \score { \new Staff \with { \consists "Page_turn_engraver" } { << \glob_uno  \vla_uno >>}   } 
    \score { \new Staff \with { \consists "Page_turn_engraver" } { << \glob_dos  \vla_dos >>}   } 
    \score { \new Staff \with { \consists "Page_turn_engraver" } { << \glob_tres  \vla_tres >>}   } 
    \score { \new Staff \with { \consists "Page_turn_engraver" } { << \glob_cuatro  \vla_cuatro >>}   } 
    \score { \new Staff \with { \consists "Page_turn_engraver" } { << \glob_cinco  \vla_cinco >>}   } 
    \score { \new Staff \with { \consists "Page_turn_engraver" } { << \glob_seis  \vla_seis >>}   } 
    \score { \new Staff \with { \consists "Page_turn_engraver" } { << \glob_siete  \vla_siete >>}   } 

    \header {
    title = \markup \fmtTitle "Serenata, Ex C."
    composer = \markup \fmtComposer "Del Sigℓ:" "Wo[l]fgang Mozart"
    subtitle = \markup \fmtSubtitle "violino primo, violino secondo è basso"
    instrument = "Violino primo"
    tagline = ##f 
  }

    \paper { 
        first-page-number = 1
        ragged-last = ##f
        ragged-last-bottom = ##f 
        print-page-number = ##f 
        page-breaking = #ly:page-turn-breaking
  }
}

\book {
    \bookOutputSuffix "vl2"

    \score { \new Staff \with { \consists "Page_turn_engraver" } { << \glob_uno  \vlb_uno >>}   } 
    \score { \new Staff \with { \consists "Page_turn_engraver" } { << \glob_dos  \vlb_dos >>}   } 
    \score { \new Staff \with { \consists "Page_turn_engraver" } { << \glob_tres  \vlb_tres >>}   } 
    \score { \new Staff \with { \consists "Page_turn_engraver" } { << \glob_cuatro  \vlb_cuatro >>}   } 
    \score { \new Staff \with { \consists "Page_turn_engraver" } { << \glob_cinco  \vlb_cinco >>}   } 
    \score { \new Staff \with { \consists "Page_turn_engraver" } { << \glob_seis  \vlb_seis >>}   } 
    \score { \new Staff \with { \consists "Page_turn_engraver" } { << \glob_siete  \vlb_siete >>}   } 

    \header {
    title = \markup \fmtTitle "Serenata, Ex C."
    composer = \markup \fmtComposer "Del Sigℓ:" "Wo[l]fgang Mozart"
    subtitle = \markup \fmtSubtitle "violino primo, violino secondo è basso"
    instrument = "Violino secondo"
    tagline = ##f 
  }

    \paper { 
        first-page-number = 2
        ragged-last = ##f
        ragged-last-bottom = ##f 
        print-page-number = ##f 
        page-breaking = #ly:page-turn-breaking
  }
}

\book {
    \bookOutputSuffix "bc"

    \score { \new Staff \with { \consists "Page_turn_engraver" } { << \glob_uno  \bc_uno >>}   } 
    \score { \new Staff \with { \consists "Page_turn_engraver" } { << \glob_dos  \bc_dos >>}   } 
    \score { \new Staff \with { \consists "Page_turn_engraver" } { << \glob_tres  \bc_tres >>}   } 
    \score { \new Staff \with { \consists "Page_turn_engraver" } { << \glob_cuatro  \bc_cuatro >>}   } 
    \score { \new Staff \with { \consists "Page_turn_engraver" } { << \glob_cinco  \bc_cinco >>}   } 
    \score { \new Staff \with { \consists "Page_turn_engraver" } { << \glob_seis  \bc_seis >>}   } 
    \score { \new Staff \with { \consists "Page_turn_engraver" } { << \glob_siete  \bc_siete >>}   } 

    \header {
    title = \markup \fmtTitle "Serenata, Ex C."
    composer = \markup \fmtComposer "Del Sigℓ:" "Wo[l]fgang Mozart"
    subtitle = \markup \fmtSubtitle "violino primo, violino secondo è basso"
    instrument = "Basso [Violoncello]"
    tagline = ##f 
  }

    \paper { 
        first-page-number = 1
        ragged-last = ##f
        ragged-last-bottom = ##f 
        print-page-number = ##f 
        page-breaking = #ly:page-turn-breaking
  }
}



#(set-global-staff-size 16)

\book {
  \bookOutputSuffix "Score"
  
  \score { 
    \new StaffGroup {
      <<
        \new Staff \with { instrumentName = \markup \override #'(baseline-skip . 0.9 ) \center-column {"Violino" "primo"} } { << \glob_uno  \vla_uno >>} 
        \new Staff \with { instrumentName = \markup \override #'(baseline-skip . 0.9 ) \center-column {"Violino" "secondo"} } { << \glob_uno  \vlb_uno >>} 
        \new Staff \with { instrumentName = \markup \override #'(baseline-skip . 0.9 ) \center-column {"Violoncello" ""} } { << \glob_uno  \bc_uno >>} 
      >>
    }
    \midi { \tempo 4=120}
    \layout { }
  }

  \score { 
    \new StaffGroup {
      <<
        \new Staff  { << \glob_dos  \vla_dos >>} 
        \new Staff  { << \glob_dos  \vlb_dos >>} 
        \new Staff  { << \glob_dos  \bc_dos >>} 
      >>
    }
    \midi { \tempo 4=120}
    \layout { }
  }

  \score { 
    \new StaffGroup {
      <<
        \new Staff  { << \glob_tres  \vla_tres >>} 
        \new Staff  { << \glob_tres  \vlb_tres >>} 
        \new Staff  { << \glob_tres  \bc_tres >>} 
      >>
    }
    \midi { \tempo 4=120}
    \layout { }
  }

    \score { 
    \new StaffGroup {
      <<
        \new Staff  { << \glob_cuatro  \vla_cuatro >>} 
        \new Staff  { << \glob_cuatro  \vlb_cuatro >>} 
        \new Staff  { << \glob_cuatro  \bc_cuatro >>} 
      >>
    }
    \midi { \tempo 4=120}
    \layout { }
  }

  \score { 
    \new StaffGroup {
      <<
        \new Staff  { << \glob_cinco  \vla_cinco >>} 
        \new Staff  { << \glob_cinco  \vlb_cinco >>} 
        \new Staff  { << \glob_cinco  \bc_cinco >>} 
      >>
    }
    \midi { \tempo 4=120}
    \layout { }
  }

  \score { 
    \new StaffGroup {
      <<
        \new Staff  { << \glob_seis  \vla_seis >>} 
        \new Staff  { << \glob_seis  \vlb_seis >>} 
        \new Staff  { << \glob_seis  \bc_seis >>} 
      >>
    }
    \midi { \tempo 4=120}
    \layout { }
  }

  \score { 
    \new StaffGroup {
      <<
        \new Staff  { << \glob_siete  \vla_siete >>} 
        \new Staff  { << \glob_siete  \vlb_siete >>} 
        \new Staff  { << \glob_siete  \bc_siete >>} 
      >>
    }
    \midi { \tempo 4=120}
    \layout { }
  }

  \header {
    title = \markup \fmtTitle "Serenata, Ex C."
    composer = \markup \fmtComposer "Del Sigℓ:" "Wo[l]fgang Mozart"
    subtitle = \markup \fmtSubtitle "violino primo, violino secondo è basso"
    tagline = ##f 
  }
  
    \paper { 
    %  page-count = 7
    ragged-last-bottom = ##f
  }
  
}
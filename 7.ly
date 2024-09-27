
\include "./ily/funciones.ily"

glob_siete = { 
    \time 2/4 \sectionLabel "Finale" \tempo "Allegro"
    \set Timing.beamExceptions = \beamExceptions { 8 [ 8 8 8 ] | 16 [ 16 16 16] 16 [16 16 16]}
    \key c \major 
    \repeat volta 2 { \partial 8 s8 s2*7 s4.  }
    \repeat volta 2 { \partial 8 s8 s2*5 s4. \twoWayFermata \jump \markup \concat { \vcenter "Da capo al segno " \override #'(baseline-skip . 0.8) \center-column{ \musicglyph "scripts.ufermata" \musicglyph "scripts.dfermata" }}} 
}

vla_siete = \relative c''' { 
    g16 e 
    c4 \grace f8 e d16 c 
    g'8 g g4 
    c8 c c4 
    b16 a g8 r g 
    f16( g) d( g) f( g) d( g) 
    e( g) c, (g') e( g) c, (g') 
    d8 f16 d c b a b 
    <<{s4\fermata}\\{c\fermata}>>
    r8 

    g' 
    \grace g8 f e16 f d e f g
    e8 d16 e c8 c' 
    f,8 e16 f d e f g 
    e8 d16 e c8 c' 
    c b16 a g8 fis 
    g4 r8

}

vlb_siete = \relative c' { 
    r8 
    e4 g8 f16 e 
    d8 d' d4 
    e8 e fis fis 
    g g, <d d'>4 
    g,16 d' b' d, g, d' b' d, 
    g, e' c' e, g, e' c' e,  
    a8 a16 f d8 d 
    <<{c'4\fermata}\\{\stemUp e,\fermata}>> \bracketify r8

    r8
    <g, g'>16 q q q q q q q 
    q q q q q q q q 
    q q q q q q q q 
    q q q q q q q q 
    e''4 c 
    b4 ^\markup \defaultText { [ \teeny\note {4. } #UP ] } r8   
}

bc_siete = \relative c' { 
    \clef "bass"
    r8  
    c c c c 
    b b b b 
    a a a a 
    g g g g 
    r8 g, b g 
    r c e c 
    f f, g' g, 
    <<{c4\fermata}\\{s\fermata}>> r8 
    r8
    d' d b b 
    c c e e 
    d d b b 
    c c c, r  
    c'4 a 
    g r8 


}


%{

\score { 
    \new StaffGroup { 
    <<
    \new Staff { << \glob_siete \vla_siete >> }        
    \new Staff { << \glob_siete \vlb_siete>> }
    \new Staff { << \glob_siete \bc_siete >> }
    >>
    } 

    \layout{}
    \midi{}
}

%}
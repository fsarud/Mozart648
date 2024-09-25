
\include "./ily/funciones.ily"

glob_uno = { 
    \time 2/4 \sectionLabel "Marche"
    \set Timing.beamExceptions =  \beamExceptions { 8 [ 8 8 8 ] | 16 [ 16 16 16] 16 [ 16 16 16]}
    \repeat volta 2 { s2 * 17 }
    \repeat volta 2 { s2 * 20 s2 \twoWayFermata}
}


vla_uno = \relative c { 
    <g' e' c'>8[ r16 g'] c16. g32 c16. e32 
    \grace e8 d8[ r16 g,] d'16. g, 32 d'16. f32 
    \omit TupletBracket \tuplet 3/2 { e16 f g } g8 r16 c b a 
    a8 g r8 e16 g 
    g16 f f8 r16 d d f 
    f e e8 r8 c'
    \grace b8 a8. g16 f e d c 
    b8 <b g'> <g, d' b' g'>4

    e''8. \p d32 c b8 b 
    <<{c2:16\fz}\\{g:16}>>
    g'8. \p f32 e d8 d 
    <<{d2:16\fz}\\{\voiceThree d,:16}>>
    d'8 \tupletOff \tuplet 3/2 { e16 d c } b8 a
    <g, g'>8 b16. c32 d16. c32 d16. e32 
    c8 a16. b32 c16. b32 c16. d32 

    b8[ r16 <b d>] q8 q 
    q4 r 

    g'8[ r16 d] g16. d32 g16. b32 
    a8[ r16 d, ] a'16. d, 32 a'16. c32 
    \tuplet 3/2 8 { b16 [ c d]  e fis g  } g8 \tuplet 3/2 { g16 fis e  }
    e8 d r4 
    f8. e32 f f8. e32 f 
    f8-! e-! dis( d) 

    c8 f32 d c b a8 gis 
    \grace {\bracketAcc gis?8} a4 r 
    e'8 d16. e32 e8 d16. e32 
    e8-! d-! cis( c)
    b16 d8 f16 e g c e, 
    e8 d <d, b' g'>4
    \bracketDot a''8. \p g32 f e8 e 
    <<{d2:16}\\{f,:16}>>
    c'8. b32 a g8 f 
    <<{g2:16}\\{ \stemUp \correte #1  g,:16}>>

    <g g'>8 \grace g''8 \tuplet 3/2 { f16 e d  } c8 b 
    <e, c'>8 e16. f32 g16. f32 g16. a32 
    f8 d16. e32 f16. e32 f16. g32 
    e8[ r16 <e c'>] q8 q 
    q4 r 
}

vlb_uno = \relative c { 
    <e' c'>4 r  
    <g, g'> r  
    \tuplet 3/2 { c'16 d e  } e4 g8 
    f e 
    \repeat unfold 4 { \tuplet 3/2 8 { g,16 [ g g ] } } \tupletOff \repeat unfold 4 { \tuplet 3/2 8 { g16 [ g g ] } } \tuplet 3/2 8 { c[ c c ] c[ c c ] }
    c8. b16 a8 a 
    g <b g'> q\noBeam r  

    g'8.\p f32 e d8 d 
    <<{d2:16\fz}\\{\voiceThree d,:16}>>
    b'8.\p d32 c b8 b 
    <<{d2:16\fz}\\{a2:16}>>
    b8 \tuplet 3/2 { c16 b a  } g8 fis 
    g4 r8 g' 
    fis r r fis! 
    g r16 g, g8 g 
    <g, g'>4 r  

    q r 
    <d' a'> r 
    \tuplet 3/2 8 { g16 [ a b]  c [  d e]  } e8 \tuplet 3/2 { e16 d c  }
    c8 b r4 
    b2:8 
    b8 gis a b 
    e, a32 f e d c8 b 
    c8 e16. d32 c8 b 
    a a' a a 
    a fis g a 
    d,16 g g g g e'8 c16 
    c8 b <d, b' g'> \noBeam r  
    c'8. \p b32 a g8 g 

    <<{g2:16\fz}\\{g,:16}>> 
    \leftBracket e'8. g32 f32 \rightBracket  e8 e 
    <<{f2:16}\\{g,:16}>> 
    e'8 \tuplet 3/2 { a16 g f  } e8 d 
    e4 r8 a' 
    b r r b, 
    c r16 e,16 <g, e'>8 q 
    q4 r
}

bc_uno = \relative c { 
    \clef "bass"
    c4 r  
    b4 r 
    c8 c' c c 
    c,16 c' b c c,4 
    d4 b 
    c e 
    f f8 fis 
    g g, g4 
    g'2:8
    fis2:16 
    g8 g g g 
    fis2:16 
    g8 c, d d 

    g,8 g'16. a32 b16. a32 b16. c32 
    a8 fis16. g32 a16. g32 a16. b32 
    g8 [ r16 g] g8 g 
    g4 r 
    g4 r 
    fis r 
    g2:8 
    g16 g fis g g,4 
    gis'2:16 
    gis8 e fis gis 

    a8[ r16 d,] e8 e 
    a c16. b32 a8 g 
    fis2:8 
    \bracketAcc fis?8 d e fis 
    g b, c c 
    g' g, g r 
    c2:8 
    b:16 
    c:8 
    b:16 
    c8 f g g, 
    c8[ r16 d] e16. d32 e16. f32 
    d8 b16. c32 d16. c32 d16. e32 
    c8[ r16 c ] c8 c 
    c4 r 
}


%%{

\score { 
    \new StaffGroup { 
    <<
    \new Staff { << \glob_uno \vla_uno >> }        
    \new Staff { << \glob_uno \vlb_uno>> }
    \new Staff { << \glob_uno \bc_uno >> }
    >>
    } 

    \layout{}
    \midi{}
}

%}
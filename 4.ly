\include "./ily/funciones.ily"

glob_cuatro = { 
    \time 3/4 \sectionLabel "Polonese"
    \repeat volta 2 { s2. * 8 }
    \repeat volta 2 { s2. * 6 \twoWayFermata \jump \markup \concat { \vcenter "Da capo al " \override #'(baseline-skip . 0.8) \center-column{ \musicglyph "scripts.ufermata" \musicglyph "scripts.dfermata" }}} 
    
}


vla_cuatro = \relative c'' { 
  <e, c'>8 c'16 b c4 e
  <g, d'>8 <g d'>16 c d4 f
  e8 c'16 c a8 a16 g f8 f16 e
  d c b a g2
  
  <e c'>8 c'16 b c4 e
  <g, d'>8 <g d'>16 c d4 f
  e8 c'16 b a8 a16g f e d c
  b c d b c4 <<{c,4\fermata}\\{s\fermata}>>
  e'8 e16 d e8 c' e, c'
  
  d,8 d16 c d8 b' d, b'
  c,8 c16 b c8 a' c, a'
  b,8 b16 a b8 g' b, g'
  e8 e16 d c8 c16 b a8 a16 g
  fis g a fis g4 g,
}

vlb_cuatro = \relative c'' { 
  e,8 e16 d e4 c'
  <b d,>8 b16 a b4 d
  c2 a4
  g16 a b a b,2
  
  e8 e16 d e4 c'
  <d, b'>8 b'16 a b4 d
  <e, c'> c'4. a8
  d,16 e f d e4 <<{e4\fermata}\\{s\fermata}>>
  c'8 c16 b c8 e c e
  b b16 a b8 d b d
  a a16 g a8 c a c
  g g16 fis g8 b g b
  c c16 b a4 e
  a,16 b c a b2
  
}

bc_cuatro = \relative c {
  \clef "bass"
  c4 c c
  g' g g
  c,8 e f4. fis8
  g4 g,2
  
  c4 c c
  g' g g
  c,8 e f!4. fis8
  g4 c, <<{c4\fermata}\\{s\fermata}>>
  c' r8 c a fis
  
  b4 r8 b g e
  a4 r8 a fis d
  g!4 r8 g e c
  a4 c cis
  d g,2
}


%{

\score { 
    \new StaffGroup { 
    <<
    \new Staff { << \glob_cuatro \vla_cuatro >> }        
    \new Staff { << \glob_cuatro \vlb_cuatro>> }
    \new Staff { << \glob_cuatro \bc_cuatro >> }
    >>
    } 

    \layout{}
    \midi{}
}

%}
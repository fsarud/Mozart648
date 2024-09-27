\include "./ily/funciones.ily"

glob_seis = { 
    \time 3/4 \sectionLabel "Menuet"
    \repeat volta 2 { s2. * 8 }
    \repeat volta 2 { s2. * 8 \twoWayFermata }
    \sectionLabel "Trio" \key f \major
    \repeat volta 2 { s2. * 8 }
    \repeat volta 2 { s2. * 8 \twoWayFermata \jump "Menuet da capo" }
}


vla_seis = \relative c'' { 
  c4 g e'
  c2 e8 f
  g4 f8 e d c
  b a g4 r
  f2.
  f'2.
  e8 g
  c,4 b
  \grace b8 c2 r4
  g'8 e c4 c
  b8 c d b g4
  c8 b c a g fis
  g4 g, r
  \bracketAcc f'?2.
  f'2.
  e8 g c,4 b
  \grace b8 c2 r4
  f c a'
  f2 c4
  f c c'8. a16
  f2 c4
  bes'8 a g f e d
  c4 bes a
  g8 bes d bes a g
  f2 e4
  c'4 g'8 e d c
  c b! b2
  bes!4 bes'8 g e bes
  bes2 a4
  a'8 g f e d c
  c4. bes8 a4
  g8 bes d bes a g
  f2 r4
}

vlb_seis = \relative c'' { 
 c4 g e'
 c2 r4
 c a8 g \bracketify fis e
 \leftBracket d8 c b4 \rightBracket r4 
 r c c
 r b b
 c'8 e e,4 d
 \grace d8 e2 r4
 r g a
 d, b2
 c'8 b c a g fis
 g4 g, r
 r c c
 r b b
 c e d
 <<{c'2}\\{\voiceThree e,2}>> r4
 <<{a2. a a a}\\{f f f f}>>
 R2.
 <<{e4 g f}\\{s4 c2}>>
 r4 d c8. bes16
 a2 g4
 r e' e
 f f f
 g g g
 c, c c
 R2.
 a'4 g f
 r d bes
 \leftBracket bes4 a4 r4 \rightBracket
  
}

bc_seis = \relative c {
  \clef "bass"
  c'4 g e'
  c2 r4
  e, f fis
  g g, r
  r a' a
  r g g
  c, g' g,
  c2 r4
  
  r e fis
  g g,2
  c'8 b c a g fis
  g4 g, r
  r a' a
  r g g
  r g g,
  c2 r4
  
  f2.
  f2.
  f2.
  f2.
  R2.
  c4 e f
  r bes, bes
  c2.
  r4 c c
  d d d
  e e e
  f f f
  R2.
  r4 e f
  bes,2 c4
  <<{f2}\\{\voiceThree f,}>> r4
}


%{

\score { 
    \new StaffGroup { 
    <<
    \new Staff { << \glob_seis \vla_seis >> }        
    \new Staff { << \glob_seis \vlb_seis>> }
    \new Staff { << \glob_seis \bc_seis >> }
    >>
    } 

    \layout{}
    \midi{}
}

%}
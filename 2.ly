\include "./ily/funciones.ily"

glob_dos = { 
    \time 4/4 \tempo "Allegro"
    \repeat volta 2 { s2 * 40 }
    \repeat volta 2 { s2 * 46 \twoWayFermata}
}


vla_dos = \relative c'' { 
   c1
  g'
  a4 a4. c8 c a
  fis g g4 r2
  
  r8 f, f f r f' f f
  r g, e' g r g, g g
  a2 g8 f e d
  e16 d e f e8 e <e c'>4 r
  g'2 g4 fis8 e
  
  d c c4 r2
  a' a8 fis d c
  c b b4 r2
  e e16 [g fis g] a g fis g
  
  d2 d16 [g \bracketAcc fis g] a g fis g   %es fa#
  c,2 a'16 g \bracketAcc fis e d c b a   %es fa# 
  b8 g' g,, d'' c, e' e, c'
  d,2 a'\trill   %falta trino
  b8 g' g,, d'' c e e, c'
  
  b16 c d c d b a g
  a2\trill
  g4 <d b' g'> <d b' g'> r4
  d'1
  r8 b,-! a( b) d c b a  %ligadura y stacc
  r8 g'-! fis( g) b a g fis %ligadura y stacc
  
  <g, g'>4 q q q 
  g'1
  r8 e-! d( e) g f e d %ligadura y stacc
  r c'-! b( c) e d c b %ligadura y stacc
  c4 c <c a'> \leftBracket <d b'> \rightBracket
  
  c'2 c4 b8 a
  g f f4 r2
  d'2 d8 b g f
  f e e4 r2
  a, a16( c b c) d( c b c) %ligaduras
  
  g2 g16( c b c) d( c b c) %ligaduras
  f,2 d'16 (c b a) g (f e d)
  e2 g'16 (f e d) c (bes a g)
  a2 a'16 (g fis e) d (c b a)
  
  b2 d16 (c b a) g (f e d)
  e8 g' g, b a a' f, a'
  g,,2 d''\trill
  c8 g' g, b a a' f, a'
  g,,2 d''\trill
  c4 <c e,> <c e,> r
  
}

vlb_dos = \relative c'' { 
  e,2:8 e2:8
  e2:8 e2:8
  f2:8 f2:8
  e2:8 e2:8
  
  c'1 ^\markup \defaultText { \italic "solo" } %faltaba el «solo»
  c2 cis
  d16 cis d e f a g f e8 d c b
  c16 b c d c8 c c4 r
  
  r1
  a2 a4 g8 fis
  e d d4 r2
  d'2 d8 b a g
  
  g,16 g' fis g a g fis g g,2
  g16 g' fis g a g fis g g,2
  g16 g' fis g a g fis g fis2
  
  g8 g4 g g g8
  g2:8 fis2:8
  g8 g4 g g g8
  g2:8 fis2:8
  g4 b b r
  
  r8 b\bracketify-! \slurDashed a( b) d c b a   %sugerencia
  d,1 
  r8 b\bracketify-! a( b) d c b a %sugerencia
  b4 b' c f
  e8 c b c e d c b
  
  g,1
  r8 e'\bracketify-! d( e) g f e d %sugerencia
  \bracketify e4 e' f \bracketify b,
  <c e,> r4 r2
  d2 d4 c8 b
  
  a g g4 r2
  g'2 g8 e d c %notas
  
  c,16 c' b c d c b c c,2
  c16 c' b c d c b c c,2
  c16 c' b c d c b c <b, b'>2 ^\markup \defaultText \teeny { [ \note {4} #UP ] } 
  
  c16 c' b c d c b c c,2
  c16 c' b c d c b c d,2 %nota
  d16 d' c d e d c d g,,2 %confiado...
  g8 c4 c c c8
  c c c' c c c  b b
  c c,4 c c c8
  c c <e c'> <e c'> <<{b'2:16}\\{f:16}>>
  <<{c'4 c c}\\{e, e e}>> r
}

bc_dos = \relative c {
  \clef "bass"
  c8 c c c c c c c
  c c c c c c c c
  c c c c c c c c
  c c c c c c c c
  d d d d d d d d
  e e e e e e e e
  
  f f f f g g g, g
  c c' g e c4 r
  g'8 g g g g g g g
  a a a a a a a a
  fis fis fis fis fis fis fis fis
  g g g g g g g g
  
  c, c c c c c c c
  b b b b b b b b
  a2:8 d:8
  b:8 c:8
  d:8 d:8
  g8 g b, b c2:8
  d:8 d:8
  g8 g d b g4 r4
  r8 g'\bracketify-! \slurDashed fis( g) b a g fis %sugerencia
  r8 g\bracketify-! fis( g) b a g fis %sugerencia
  g2 d %nota
  g8 g f! f e e d d
  c e d e g f e d %notas
  r8 c\bracketify-! b( c) e d c b %sugerencia
  c2 g
  c:8 g:8
  c8 c' c c c2:8
  d:8 d:8
  b:8 b:8
  c:8 c:8
  f,:8 f:8
  e:8 e:8
  c:8 g':8
  c,:8 e:8
  f:8 fis:8
  g:8 b,:8
  c8 c e e f2:8
  g:8 g,:8
  c8 c e e f2:8
  g:8 g,:8
  c4 c c r4
}


%{

\score { 
    \new StaffGroup { 
    <<
    \new Staff { << \glob_dos \vla_dos >> }        
    \new Staff { << \glob_dos \vlb_dos>> }
    \new Staff { << \glob_dos \bc_dos >> }
    >>
    } 

    \layout{}
    \midi{\tempo 4=100}
}

%}
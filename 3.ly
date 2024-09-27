
\include "./ily/funciones.ily"

glob_tres = { 
    \time 3/4 \sectionLabel "Menuet"
    \repeat volta 2 { s2. * 8 }
    \repeat volta 2 { s2. * 8 \twoWayFermata \break }
    \section \sectionLabel "Trio" \key f \major
    \repeat volta 2 { s2. * 8 }
    \repeat volta 2 { s2. * 7 s2. \twoWayFermata \jump "M. da capo" }

}


vla_tres = \relative c'' { 
    c2 d8. \trill c32 d 
    c4 r r 
    e2 f8. \trill e32 f 
    e4 r r 
    c'8( b) b( a) a( g) 
    g4. f8 e4 
    d8 e f4 e 
    d2 r4 

    g2. 
    g 
    g
    e8 f g e c4 
    c'8 b b a a g 
    g2 g8 gis 
    a f e4 d 
    <<{c2}\\{\voiceThree e,}>> r4 

    f'8( e) e( d) d( c)
    c( bes) bes( a) a( g)
    g4. a8 bes4 
    a8( bes) c4 r 
    f8( e) e( d) d( c)
    c( bes) bes( a) a( c)
    c bes a4 g 
    f2 r4 

    \tuplet 3/2 { c'8 d c } c4 <c c'>
    c c' r 
    e,,8 f g a bes g 
    a c bes a g f 
    c' b b bes bes a 
    a f' e g f c 
    d bes a g f e 
    f2 \bracketify r4 
}

vlb_tres = \relative c'' { 
    R2. *2 
    c2 d8. \bracketify \trill c32 d 
    c4 r r 
    \slurDashed e8( d) d( f) f( e) \slurSolid
    e4. d8 c4 
    b8 c d4 c 
    b2 r4 

    r8 b c d c b 
    r8 c d e d \bracketify c 
    r8 d e f e d 
    c4 e e, 
    e'8 d d f f e 
    d4. f8 e4 
    f8 d c4 b 
    c2 r4 

    \slurDashed d8( c) c( bes) bes( a) 
    a( g) g( f) f( e) 
    e4. f8 g4 
    f8( g) a4 r  
    d8( c) c( bes) bes( a) 
    a( g) g( f) f( a) 
    a g f4 e 
    f2 r4 

    e8 f g a bes g 
    a c bes a g f 
    \tupletOff \tuplet 3/2 { c d c  } c4 c 
    c c' r 
    e,8 f f g g \bracketify f 
    c a' a bes c4 
    r8 d, c bes a g 
    a2 r4  
}

bc_tres = \relative c { 
    \clef "bass"
    c4 e g 
    c8 a g f e d 
    c4 e g 
    c8 a g f e d 
    c2. 
    c   4 g' c 
    g b c 
    g d g, 

    g'2 f4 
    e2 c4 
    b2 g4 
    c2. 
    c'
    b4 g c 
    f, g g, 
    c2 r4 

    f2. 
    f, 
    c'4 c c 
    f f, r 
    f'2. 
    f, 
    bes4 c c 
    f2 r4 

    c8 d e f g e 
    f a g f e d 
    c d e f g e 
    f a g f e d 
    c d d e e f 
    f4 g a 
    bes c c, 
    f2 r4 
}


%%{

\score { 
    \new StaffGroup { 
    <<
    \new Staff { << \glob_tres \vla_tres >> }        
    \new Staff { << \glob_tres \vlb_tres>> }
    \new Staff { << \glob_tres \bc_tres >> }
    >>
    } 

    \layout{}
    \midi{}
}

%}
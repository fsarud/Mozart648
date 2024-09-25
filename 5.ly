
\include "./ily/funciones.ily"

glob_cinco = { 
    \time 2/4 \tempo "Adagio"
    \set Timing.beamExceptions = \beamExceptions { 8 [ 8 8 8 ] | 16 [ 16 16 16] 16 [16 16 16]}
    \key f \major 
    \repeat volta 2 { s2 * 8 }
    \repeat volta 2 { s2 * 10 \twoWayFermata }
}

vla_cinco = \relative c'' { 
    f2 ^\markup \defaultText "con sordini" 
    e8 \tupletOff \tuplet 3/2 { e16 g b, } b8 c 
    \bracketAcc bes'?2
    a8 \tuplet 3/2 { a16 c e, } e8 f 
    a8 f16. e32 e8 d 
    g e16. d32 d8 c 
    a'8 g32( f e d) c8 e32( d c b)
    \bracketAcc b?4 c8 r 

    es2 
    \tuplet 3/2 8 { d16 [ d d] fis,[ fis fis]  } fis8 g 
    d'2 
    \tuplet 3/2 8 { c16 [ c c] e,![ e e]  } e8 f 
    f'8 e16 d c8 b 
    \bracketAcc b?4 c8 r  
    d8 bes!16. a32 a8 g 
    c8 a16. g32 g8 f 
    d'8-! c32( bes a g) f8-! a32( g f e)
    e4 f8 r 

}

vlb_cinco = \relative c'' { 
    \tupletOff \tuplet 3/2 8 { a16 ^\markup \defaultText "con sordini"  [ a a]  a [a a ] a [a a] a [a a] 
    g[ g g ] g[ g f ] } <g, f'>8 e' 
    \tuplet 3/2 8 { e16[ e e ] e[ e e ] e'[ e e ] e[ e e ] 
    f [ c c ] c[ c c ]} bes8 a 
    \tuplet 3/2 8 { a16[ a a] a[ a a] a[ a a ] a[ a a ]
    g [ g g] g[ g g ] g[ g g ] g[ g g] 
    c, [ a' a ] a[ a a ]} \leftBracket e16. \slurDashed a32( g f e d) \rightBracket \slurSolid
    d4 e8 r  

    \tuplet 3/2 8 { c'16[ c c ] c[ c c ] c[ c c] c[ c c ]
    bes[ bes, bes] a[ a a]  } a8 bes
    \tuplet 3/2 8 { bes'16[ bes bes ] bes[ bes bes ] bes[ bes bes]  bes[ bes bes]
    a[ a a ] bes,[ bes bes]   } bes8 a
    \tuplet 3/2 8 { f'16[ f f ] f[ f f] f[ f f ] f[ f f] }
    f4 e8 r  
    \tuplet 3/2 8 { d16[ d d ] d[ d d ] d[ d d ] d[ d d]
    c[ c c] c[ c c ] c[ c c] c[ c c]}
    r8 \leftBracket d8 bes bes \rightBracket
    bes4 a8 r 
}

bc_cinco = \relative c { 
    \clef "bass"
    r8 f _\markup \defaultText "pizzicato"  a f 
    r c c' c, 
    r c c' c, 
    r f f, f'
    r f f f 
    r e e e 
    r f g g, 
    c4 c8 r  

    r8 fis fis fis 
    g d g, r 
    r e' e e 
    f! c f,4 
    r8 d' d d 
    c4 c8 r  
    r bes' bes bes 
    r a a a 
    r c, c c 
    f4 f,8 r 

}


%%{

\score { 
    \new StaffGroup { 
    <<
    \new Staff { << \glob_cinco \vla_cinco >> }        
    \new Staff { << \glob_cinco \vlb_cinco>> }
    \new Staff { << \glob_cinco \bc_cinco >> }
    >>
    } 

    \layout{}
    \midi{}
}

%}
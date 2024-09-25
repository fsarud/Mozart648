%Definiciones de contextos ad-hoc para cuarteto de cuerdas


\layout {
  \context{
    \Staff
    \name TopStaff
    \alias Staff
  }
  \context{
    \Staff
    \name BottomStaff
    \alias Staff
  }
  \context{
    \Staff
    \name MidStaff
    \alias Staff
  }  
  \context { \Score      \accepts TopStaff \accepts BottomStaff \accepts MidStaff }
  \context { \StaffGroup \accepts TopStaff \accepts BottomStaff \accepts MidStaff }
}  
  
\midi {
  \context {
    \Staff
    \name TopStaff
    \alias Staff
  }
  \context{
    \Staff
    \name BottomStaff
    \alias Staff
  }  
  \context{
    \Staff
    \name MidStaff
    \alias Staff
  }    
  \context { \Score      \accepts TopStaff \accepts BottomStaff \accepts MidStaff }
  \context { \StaffGroup \accepts TopStaff \accepts BottomStaff \accepts MidStaff }
}  

TSScoreFull = { 
  \override TopStaff.TimeSignature.outside-staff-priority = #0
  \override TopStaff.TimeSignature.direction = #UP
  \override TopStaff.TimeSignature.break-align-symbol = #'staff-bar
  \override TopStaff.TimeSignature.font-size = #-2
  \override TopStaff.TimeSignature.break-visibility = ##(#f #t #t)
  \override BottomStaff.TimeSignature.outside-staff-priority = #0
  \override BottomStaff.TimeSignature.direction = #DOWN
  \override BottomStaff.TimeSignature.break-align-symbol = #'staff-bar
  \override BottomStaff.TimeSignature.font-size = #-2
  \override BottomStaff.TimeSignature.break-visibility = ##(#f #t #t)
  \omit MidStaff.TimeSignature
}

TSScoreTop = { 
  \override TopStaff.TimeSignature.outside-staff-priority = #0
  \override TopStaff.TimeSignature.direction = #UP
  \override TopStaff.TimeSignature.break-align-symbol = #'staff-bar
  \override TopStaff.TimeSignature.font-size = #-2
  \override TopStaff.TimeSignature.break-visibility = ##(#f #t #t)
 }

TSStaffFull = { 
  \revert TopStaff.TimeSignature.outside-staff-priority
  \revert TopStaff.TimeSignature.direction
  \revert TopStaff.TimeSignature.break-align-symbol
  \revert TopStaff.TimeSignature.font-size
  \revert TopStaff.TimeSignature.break-visibility
  \revert BottomStaff.TimeSignature.outside-staff-priority
  \revert BottomStaff.TimeSignature.direction
  \revert BottomStaff.TimeSignature.break-align-symbol
  \revert BottomStaff.TimeSignature.font-size
  \revert BottomStaff.TimeSignature.break-visibility
  \undo \omit MidStaff.TimeSignature  
}

TSStaffTop = { 
  \revert TopStaff.TimeSignature.outside-staff-priority
  \revert TopStaff.TimeSignature.direction
  \revert TopStaff.TimeSignature.break-align-symbol
  \revert TopStaff.TimeSignature.font-size
  \revert TopStaff.TimeSignature.break-visibility
}
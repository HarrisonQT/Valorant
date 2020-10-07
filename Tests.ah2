/*
    Tests
*/
Numpad1::{
    OutputDebug("Numpad1" . "`n")
    g.character.weapons.currentWeapon.customActions.directionalPeak(g.character.movements.leftMove)
}
Numpad2::{
    g.character.weapons.currentWeapon.customActions.directionalPeak(g.character.movements.rightMove)
}
Numpad3::{
    start := Now()
    OutputDebug(" start " . " shouldStrafe " . shouldStrafe . "`n")
    static timeTest := 190
    left := 1
    OutputDebug("timeTest " . timeTest . "`n")
    Click "left"
    OutputDebug("left " . left . "`n")
    left += 1
    Sleep 70
    Click "right"
    Sleep 10
    Click "left"
    OutputDebug("left " . left . "`n")
    left += 1
    ; Sleep timeTest
    ; Click "left"
    ; OutputDebug("left " . left . "`n")
    Sleep 180
    Click "right"
    Sleep 20
    Loop(10) {
        Click "left"
        Sleep timeTest
        OutputDebug("left " . left . "`n")
        left += 1
    }
    timeTest += 2
    end := Now()
    timeDiff := end - start
    OutputDebug(" end: " . timeDiff . "`n")
}
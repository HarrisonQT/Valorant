/*
    Test Utilities
*/

noOp() {
    if(isFullDebug) {
        OutputDebug("noOp" . "`n")
    }
    no := False
    OutputDebug(getIterations())
}
incrementTestNum() {
    if(isFullDebug) {
        OutputDebug("incrementTestNum" . "`n")
    }
    OutputDebug("incrementTestNum " . "testNum := " . testNum . "`n")
    testNum += testNumIncrementRate
}
testSleep() {
    if(isFullDebug) {
        OutputDebug("testSleep" . "`n")
    }
    OutputDebug("testNum := " . testNum . "`n")
    Sleep testNum
    incrementTestNum()
    if(isXIterations(10)) {
        noOp()
    }
    if(isXIterations(20)) {
        noOp()
    }
    if(isXIterations(30)) {
        noOp()
    }
    if(isXIterations(40)) {
        noOp()
    }
    if(isXIterations(50)) {
        noOp()
    }
    if(isXIterations(60)) {
        noOp()
    }
    if(isXIterations(70)) {
        noOp()
    }
    if(isXIterations(80)) {
        noOp()
    }
    if(isXIterations(90)) {
        noOp()
    }
    if(isXIterations(100)) {
        noOp()
    }
}
isXIterations(_iterations) {
    return testNum == calcTestNumIterations(_iterations)
}
calcTestNumIterations(_iterations) {
    return originalTestNum + testNumIncrementRate * _iterations
}
getIterations() {
    if(isFullDebug) {
        OutputDebug("getIterations" . "`n")
    }
    return (testNum - originalTestNum) / testNumIncrementRate
}
ShiftRun() {
    if(isFullDebug) {
        OutputDebug("ShiftRun" . "`n")
    }
    g.character.movements.forwardMove.action.pressAndHold()
    ; Sleep (CONSTANTS.TIME_TILL_RUN_SOUND - 0)
    Sleep 420
    Loop(5) {
        g.character.movements.lshift.pressAndHold()
        Sleep 500
        g.character.movements.lshift.release()
        Sleep 20
    }
    g.character.movements.forwardMove.action.release()
    incrementTestNum()
    ; }
}
qs() {
    if(isFullDebug) {
        OutputDebug("qs" . "`n")
    }
    g.character.weapons.currentWeapon.quickScope(g.character)
    testSleep()
    g.character.weapons.currentWeapon.quickScope(g.character)
}
StrafeClassic() {
    g.character.movements.leftPeak()
    Sleep CONSTANTS.MOVEMENT_DECELERATION
    g.character.weapons.currentWeapon.oneShot()
    Sleep 5
    g.character.movements.rightMove.action.pressAndHold()
    Sleep 148
    g.character.weapons.currentWeapon.oneRight()
    sleepCalc := CONSTANTS.PEAK_SHOOT_COUNTER_STRAFE_TIME - 99 - 49
    Sleep sleepCalc
    ; testSleep()
    g.character.movements.rightMove.action.release()
}
StrafePhantom() {
    g.character.weapons.currentWeapon.phantom4BulletLeftStrafe(g.character)
}
ShoulderPeak() {
    g.character.movements.leftShoulderPeak()
}
/*
    Test Functions
*/
; RunSoundTest() {
; if(isFullDebug) {
;     OutputDebug("; RunSoundTest" . "`n")
; }
;     g.character.movements.forwardMove.action.pressAndHold()
;     Sleep testNum
;     incrementTestNum()
;     g.character.movements.forwardMove.action.release()
; }
CrouchTest() {
    if(isFullDebug) {
        OutputDebug("CrouchTest" . "`n")
    }
    Click "Right"
    Sleep 50
    Click "Right"
    Sleep 100
    g.character.movements.lcrouch.press()
    testSleep()
    g.character.weapons.currentWeapon.oneShot()
    Sleep 100
    g.character.movements.lcrouch.press()
    Sleep 1450
    Click "Right"
    Sleep 50
    Click "Right"
    Sleep 100
}
SplitJump(){
    g.character.movements.forwardMove.action.pressAndHold()
    Sleep 180
    g.character.abilities.second.useRaw()
    Sleep 1800
    g.character.movements.forwardMove.action.release()

}
/*
    Hotkeys
        1. Weapons
        2. Shooting
        3. Abilities
        4. Movement
            4a. Directional
            4b. Jump
            4c. lcrouch
            4d. Walk
*/
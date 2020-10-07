
/*
    9. Character Movement
*/
Class CharacterMovement {

    forwardMove := Movement.new(Keys.w,"forward")
    backwardMove := Movement.new(Keys.s,"backward")
    leftMove := Movement.new(Keys.a,"left")
    rightMove := Movement.new(Keys.d,"right")
    lcrouch := Action.new(Keys.rctrl, True)
    lshift := Action.new(Keys.lshift, True)
    rshift := Action.new(Keys.rshift, True)
    period := Action.new(Keys.period, True)
    jump := JumpMovement.new(this.lshift)
    inspectWeapon := Action.new(Keys.p)
    currentStrafeDirection := False
    __New(ByRef _characterState) {
        this.characterState := _characterState
        this.DebugOutput := False
    }
    moveUntilFullSpeed(ByRef direction, _time := 400) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("moveUntilFullSpeed " . "`n")
        }
        direction.action.pressAndHold()
        this.characterState.movementDirection := direction
        Sleep _time
    }
    moveUntilMaxSound(ByRef direction) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("moveUntilMaxSound " . "`n")
        }
        direction.action.pressAndHold()
        this.characterState.movementDirection := direction
        Sleep (CONSTANTS.TIME_TILL_RUN_SOUND - 10)
    }
    releaseBHopMovement() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("releaseBHopMovement " . "`n")
        }
        if(this.characterState.movementDirection) {
            this.characterState.movementDirection.action.release()
        } 
        this.characterState.movementDirection := False
    }
    isAtFullSpeed(ByRef direction) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("isAtFullSpeed " . "`n")
        }
        elapse := direction.action.timeSinceStartOfHold()
        return (this.isAnyMovementKeyHeldDown() && direction.action.isHeldDown() && elapse > CONSTANTS.TIME_TILL_RUN_SOUND)
    }
    continousBHopping() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("continousBHopping " . "`n")
        }
        isMoving := this.isAnyMovementKeyHeldDown()
        direction := this.getDirectionToRun()
        instances := 0
        ; if (!this.isAtFullSpeed(direction)) {
        ;     elapse := direction.action.timeSinceStartOfHold()
        ;     moveTime := elapse < CONSTANTS.TIME_TILL_RUN_SOUND ? CONSTANTS.TIME_TILL_RUN_SOUND - elapse : CONSTANTS.TIME_TILL_RUN_SOUND
        ;     this.moveUntilFullSpeed(direction, moveTime)
        ; }

        ; moveTime := !isMoving ? CONSTANTS.TIME_TILL_RUN_SOUND : 200
        this.moveUntilFullSpeed(direction, CONSTANTS.TIME_TILL_RUN_SOUND)
        While (this.jump.movement.action.isHeldDown()) {
            ; Send "{LShift} down"
            this.jump.silentJump()
            ; Send "{LShift} up"
            instances += 1
            Sleep 10
        }
        this.releaseBHopMovement()
    }
    isAnyMovementKeyHeldDown() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("isAnyMovementKeyHeldDown " . "`n")
        }
        return this.forwardMove.action.isHeldDown() || this.leftMove.action.isHeldDown() || this.backwardMove.action.isHeldDown() || this.rightMove.action.isHeldDown() 
    }
    getDirectionToRun() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("getDirectionToRun " . "`n")
        }
        isMoving := this.isAnyMovementKeyHeldDown()
        direction := isMoving ? this.getHeldMovemenetKey() : this.forwardMove
        return direction
    }
    getHeldMovemenetKey() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("getHeldMovemenetKey " . "`n")
        }

        if(this.forwardMove.action.isPhysicallyHeldDown()) {
            returnMove := this.forwardMove
        } else if (this.leftMove.action.isPhysicallyHeldDown()) {
            returnMove := this.leftMove
        } else if (this.rightMove.action.isPhysicallyHeldDown()) {

            returnMove := this.rightMove
        } else if (this.backwardMove.action.isPhysicallyHeldDown()) {
            returnMove := this.backwardMove
        } 
        return returnMove
    }
    characterJump() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("characterJump " . "`n")
        }
        OutputDebug("characterJump " . "`n")

        this.jump.silentJump()
    }
    togglelcrouch() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("togglelcrouch " . "`n")
        }

        this.lcrouch.press()
    }
    silentlCrouchJump() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("silentlCrouchJump " . "`n")
        }

        If (!this.lcrouch.toggleState) {
            this.lcrouch.press()
            Sleep CONSTANTS.TIME_TO_REACH_CROUCH_SILENT_JUMP
        }
        this.jump.silentJump()
        Sleep 1
        this.lcrouch.press()
    }
    silentMaxRunHold() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("silentMaxRunHold " . "`n")
        }

        this.forwardMove.action.pressAndHold()
        Sleep CONSTANTS.TIME_TILL_RUN_SOUND
    }
    silentMaxRunRelease() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("silentMaxRunRelease " . "`n")
        }
        this.forwardMove.action.release()
    }
    silentMaxRunShiftlcrouchJump() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("silentMaxRunShiftlcrouchJump " . "`n")
        }

        this.silentMaxRunHold()
        this.jump.silentJump()
        this.silentMaxRunRelease()
    }
    maxSilentRun() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("maxSilentRun " . "`n")
        }

        direction := this.getDirectionToRun()
        this.moveUntilMaxSound(direction)
        this.lshift.pressAndHold()
        this.period.press()
        Sleep 500
        this.period.press()
        ; this.period.press()
        Sleep 1000
        this.lshift.release()
        direction.action.release()
    }
    stopAllMovement() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("stopAllMovement " . "`n")
        }

        this.forwardMove.action.releaseRaw()
        this.leftMove.action.releaseRaw()
        this.rightMove.action.releaseRaw()
        this.backwardMove.action.releaseRaw()
    }
    stopOtherMovement(ByRef direction) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("stopAllMovement " . "`n")
        }
        if(direction != this.forwardMove) {

        }
        if(direction != this.forwardMove){
            this.forwardMove.action.releaseRaw()
        }
        if(direction != this.leftMove){
            this.leftMove.action.releaseRaw()
        }
        if(direction != this.rightMove){
            this.rightMove.action.releaseRaw()
        }
        if(direction != this.backwardMove){
            this.backwardMove.action.releaseRaw()
        }
    }
    resumeMovement() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("resumeMovement " . "`n")
        }

        this.forwardMove.action.resumePhysical()
        this.leftMove.action.resumePhysical()
        this.rightMove.action.resumePhysical()
        this.backwardMove.action.resumePhysical()
    }
    getOppositeDirection(ByRef direction) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("getOppositeDirection " . "`n")
        }
        if(direction == this.leftMove) {
            oppositeDireciton := this.rightMove
        } else if (direction == this.rightMove) {
            oppositeDireciton := this.leftMove
        } else if (direction == this.forwardMove) {
            oppositeDireciton := this.backwardMove
        } else if (direction == this.backwardMove) {
            oppositeDireciton := this.forwardMove
        }
        Return oppositeDireciton
    }
    peakStrafe(ByRef direction, strafeTime := 260) {
        funcDebug := True
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("peakStrafe " . " strafeTime " . strafeTime . "`n")
        }
        this.lshift.releaseRaw()
        direction.action.pressAndHold()
        currentStrafeDirection := direction
        Sleep strafeTime
        direction.action.release()
        currentStrafeDirection := False
        this.lshift.resumePhysical()
    }
    scopePeakStrafe(ByRef direction, timeToScope, strafeTime := 260) {
        ; static timeTest := 255
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("peakStrafe " . "`n")
        }
        direction.action.pressAndHold()
        currentStrafeDirection := direction
        ; OutputDebug("timeTest " . timeTest . "`n")
        scopeDiff := strafeTime - timeToScope
        Sleep scopeDiff
        Click "Right"
        Sleep timeToScope
        direction.action.release()
        currentStrafeDirection := False
        ; timeTest += 5
    }
    peakCounterStrafe(ByRef direction , counterStrafeTime := 435) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("peakStrafe " . "`n")
        }
        direction.action.pressAndHold()
        currentStrafeDirection := direction
        Sleep counterStrafeTime
        ; testSleep()
        direction.action.release()
        currentStrafeDirection := False
    }
    peakShootCounterStrafe(ByRef direction, strafeTime := 325, shouldRelease := True) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("peakStrafe " . "`n")
        }
        direction.action.pressAndHold()
        currentStrafeDirection := direction
        if(shouldRelease) {
            Sleep strafeTime
            direction.action.release()
        }
        currentStrafeDirection := False
    }
    shoulderPeak(ByRef direction) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("peakStrafe " . "`n")
        }
        oppositeDireciton := this.getOppositeDirection(direction)
        this.peakStrafe(direction)
        this.peakCounterStrafe(oppositeDireciton)
    }
    leftShoulderPeak() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("leftShoulderPeak" . "`n")
        }
        this.shoulderPeak(this.leftMove)
    }
    rightShoulderPeak() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("rightShoulderPeak" . "`n")
        }
        this.shoulderPeak(this.rightMove)
    }
    forwardShoulderPeak() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("forwardShoulderPeak" . "`n")
        }
        this.shoulderPeak(this.forwardMove)
    }
    backwardShoulderPeak() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("backwardShoulderPeak" . "`n")
        }
        this.shoulderPeak(this.backwardMove)
    }
    leftPeakShootCounterStrage() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("leftPeakShootCounterStrage " . "`n")
        }
        this.peakShootCounterStrafe(this.rightMove)
    }
    rightPeakShootCounterStrage() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("rightPeakShootCounterStrage " . "`n")
        }
        this.peakShootCounterStrafe(this.leftMove)
    }
    jumpPeak(ByRef direction1, ByRef direction2) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("peakStrafe " . "`n")
        }
        direction1.action.pressAndHold()
        currentStrafeDirection := direction1
        Sleep CONSTANTS.TIME_TILL_RUN_SOUND
        this.characterJump()
        Sleep 1
        this.lcrouch.press()
        ; testSleep()
        ; Sleep CONSTANTS.TIME_TO_BHOP
        Sleep 200
        direction1.action.release()
        currentStrafeDirection := False
        Sleep 1
        currentStrafeDirection := direction2
        direction2.action.pressAndHold()
        Sleep 100
        this.lcrouch.press()
        Sleep 1175
        direction2.action.release()
        currentStrafeDirection := False
    }
    leftJumpPeak(){
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("leftJumpPeak " . "`n")
        }
        this.jumpPeak(this.leftMove,this.rightMove)
    }
    rightJumpPeak(){
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("rightJumpPeak " . "`n")
        }
        this.jumpPeak(this.rightMove,this.leftMove)
    }
    forwardJumpPeak(){
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("forwardJumpPeak " . "`n")
        }
        this.jumpPeak(this.forwardMove,this.backwardMove)
    }
    backwardJumpPeak(){
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("backwardJumpPeak " . "`n")
        }
        this.jumpPeak(this.backwardMove,this.forwardMove)
    }
    midAirDoubleCrouch() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("midAirDoubleCrouch " . "`n")
        }
        this.characterJump()
        Sleep 1
        this.lcrouch.press()
        Sleep 300
        this.lcrouch.press()
    }
}

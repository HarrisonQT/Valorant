#Include "Constants.ah2"
#Include "Movement.ah2"

/*
    3a. JumpMovement  --------------------------------------------------------------
*/
Class JumpMovement {
    __New(_lshift) {
        this.DebugOutput := False
        this.key := Keys.space
        this.movement := Movement.new(this.key,"jump")
        this.lshift := _lshift
    }

    oneJump() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("oneJump " . "`n")
        }
        this.movement.action.press()
    }
    silentJump() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("silentJump " . "`n")
        }
        isHeldDown := this.lshift.isPhysicallyHeldDown()
        if(!isHeldDown)
            this.lshift.pressAndHold()
        this.oneJump()
        Sleep 1
        this.lshift.release()
    }
    silentJumpAndHold() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("silentJumpAndHold " . "`n")
        }
        isHeldDown := this.lshift.isPhysicallyHeldDown()
        if(!isHeldDown)
            this.lshift.pressAndHold()
        this.jumpAndHold()
        Sleep 1
        this.lshift.release()
    }
    silentJumpWaitTilAppex() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("silentJumpWaitTilAppex " . "`n")
        }
        this.silentJump()
        Sleep CONSTANTS.TIME_TO_REACH_JUMP_APPEX
    }
    jumpAndHold() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("jumpAndHold " . "`n")
        }
        this.movement.action.pressAndHold()
    }
    jumpRelease() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("jumpRelease " . "`n")
        }
        this.movement.action.release()
    }
}

#Include "Constants.ah2"
/*
    2. Action  ----------------------------------------------------------------
*/
Class Action {
    __New(ByRef kn, _isToggle := False) {
        this.DebugOutput := False
        this.key := kn
        this.lastUsed := Now()
        this.lastRelease := -1
        this.count := 0
        this.history := [0]
        this.isToggle := _isToggle
        this.toggleState := False
        this.isScriptHeldDown := False
        this.isStartOfHold := False
        this.startOfCurrentHold := Now()
    }
    press() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("press " . "`n")
        }

        Send "{Blind}" . this.key.name
        this.isScriptHeldDown := False
        this.setPressMetaData()
    }
    pressAndHold() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("pressAndHold " . "`n")
        }

        this.isStartOfHold := True
        this.isScriptHeldDown := True
        Send "{Blind}" . this.key.down
        this.setPressMetaData()
    }
    jumpWaitTilAppexPress(ByRef character) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("jumpWaitTilAppexPress " . "`n")
        }
        character.movements.jump.silentJump()
        Sleep CONSTANTS.TIME_TO_REACH_JUMP_APPEX
        this.press()
    }
    runWaitWaitMaxSpeedUse(ByRef character){
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("runWaitWaitMaxSpeedUse " . "`n")
        }
    }
    release() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("release " . "`n")
        }

        if (!(this.isPhysicallyHeldDown()) && this.isScriptHeldDown) {
            Send this.key.up
        }
        this.isScriptHeldDown := False
        this.setLastRelease()
        this.isStartOfHold := False
    }
    releaseRaw() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("releaseRaw " . "`n")
        }

        Send "{Blind}" . this.key.up
        this.isScriptHeldDown := False
        this.isStartOfHold := False
        this.setLastRelease()
    }
    setPressMetaData() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("setPressMetaData " . "`n")
        }

        this.setCurrentHoldMetaData()
        this.incrementCount()
        this.setToggleState()
    }
    setCurrentHoldMetaData() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("setCurrentHoldMetaData " . "`n")
        }

        if(!this.isStartOfHold) {
            this.isStartOfHold := True
            this.startOfCurrentHold := Now()
        }
    }
    setToggleState() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("setToggleState " . "`n")
        }

        if(this.isToggle) {
            this.toggleState := !this.toggleState
        }
    }
    setReleaseMetaData() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("setReleaseMetaData " . "`n")
        }

        if(!(this.isPhysicallyHeldDown())) {
            this.releaseRaw()
        }
        this.setLastRelease()
        this.isStartOfHold := False
    }
    timeSinceStartOfHold() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("timeSinceStartOfHold " . "`n")
        }

        return Now() - this.startOfCurrentHold 
    }
    setLastRelease() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("setLastRelease " . "`n")
        }

        this.lastRelease := Now()
    }
    setLastUsed() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("setLastUsed " . "`n")
        }

        this.lastUsed := Now()
    }
    incrementCount() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("incrementCount " . "`n")
        }

        this.count += 1
        timeDiff := Now() - this.lastUsed
        this.history.Push(timeDiff)
    }
    isHeldDown() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("isHeldDown " . "`n")
        }

        return this.isScriptHeldDown || GetKeyState(this.key.triggerKey, "p")
    }
    isPhysicallyHeldDown() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("isPhysicallyHeldDown " . "`n")
        }

        return GetKeyState(this.key.triggerKey, "p")
    }
    timeSinceLastUsed() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("timeSinceLastUsed " . "`n")
        }

        return this.lastUsed == 0 ? -1 : Now() - this.lastUsed
    }
    resetToggle() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("resetToggle " . "`n")
        }

        this.toggleState := False
    }
    resumePhysical() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("resumePhysical " . "`n")
        }

        if(this.isPhysicallyHeldDown()) {
            this.pressAndHold()
        }
    }
}

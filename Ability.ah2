/*
    5. Ability
*/
class Ability {
    __New(ByRef kn, _charges, _maxCharges) {
        this.DebugOutput := False
        this.action := Action.new(kn)
        this.charges := _charges
        this.maxCharges := _maxCharges
    }
    use() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("use " . "`n")
        }

        if(this.charges > 0) {
            this.decrementCharges()
            this.action.press()
        }
    }
    useRaw() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("useRaw " . "`n")
        }

        this.decrementCharges()
        this.action.press()
    }
    useAndHoldRaw(){
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("useAndHoldRaw " . "`n")
        }
        this.decrementCharges()
        this.action.pressAndHold()
    }
    release() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("release " . "`n")
        }

        this.action.release()
    }
    jumpWaitTillAppexUse(ByRef character) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("jumpWaitTillAppexUse " . "`n")
        }
        this.decrementCharges()
        this.action.jumpWaitTilAppexPress(character)
    }
    decrementCharges() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("decrementCharges " . "`n")
        }

        if(this.hasChargesLeft()) {
            this.charges -= 1
        }
    }
    incrementCharges() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("incrementCharges " . "`n")
        }

        if(this.hasLessThanMaxCharges()) {
            this.charges += 1
        }
    }
    hasLessThanMaxCharges() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("hasLessThanMaxCharges " . "`n")
        }

        return this.charges < this.maxCharges
    }
    hasChargesLeft() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("hasChargesLeft " . "`n")
        }

        return this.charges > 0
    }
    resetToMaxCharges() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("resetToMaxCharges " . "`n")
        }

        this.charges := this.maxCharges
    }
}
#Include "Constants.ah2"
#Include "Action.ah2"
/*
    3. Movement  --------------------------------------------------------------
*/
Class Movement {
    __New(ByRef kn, _name, _isToggle := False) {
        this.DebugOutput := False
        this.action := Action.new(kn, _isToggle)
        this.name := _name
    }
    DirectionalDash(ByRef character) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("DirectionalDash " . "`n")
        }
        if(character.weapons.currentWeapon.getLeftShouldShoot(character)) {
            Sleep 40
        }
        If (this.action.isPhysicallyHeldDown()) {
            character.abilities.signature.useRaw()
        } 
        Else {
            character.movements.stopOtherMovement(this)
            this.action.pressAndHold()
            character.isLoopInterrupt := True
            Sleep 1
            character.isLoopInterrupt := False
            character.abilities.signature.useRaw()
            this.action.release()
            character.movements.resumeMovement()
        } 
    }
    Dodge(ByRef character) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("Dodge " . "`n")
        }
        If (character.state.isJett && character.abilities.signature.hasChargesLeft()) {
            this.DirectionalDash(character)
        } else {
            this.KnifeStrafeDodge(character)
        }
    }
    StrafeDodge(ByRef character) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("StrafeDodge " . "`n")
        }
        If (!this.action.isPhysicallyHeldDown()) {
            this.action.pressAndHold()
        } 
        Sleep 450
        character.movements.jump.silentJump()
        Send "{2} {1}"
        Sleep 175
        this.action.release()
    }
    KnifeStrafeDodge(ByRef character) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("KnifeStrafeDodge " . "`n")
        }
        Send "{3}"
        this.StrafeDodge(character)
    }
    ShootStrafeDodge(ByRef character) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("ShootStrafeDodge " . "`n")
        }
        Click "Left"
        this.KnifeStrafeDodge(character)
    }
}

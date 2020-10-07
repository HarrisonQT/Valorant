
class GameCharacter {
    __New() {
        this.DebugOutput := False
        this.state := CharacterState.new()
        this.movements := CharacterMovement.new(this.state)
        this.weapons := CharacterWeaponState.new(this, this.movements)
        this.abilities := CharacterAbilities.new()
        this.dashTimer := ObjBindMethod(this, "dash")
        this.updraftTimer := ObjBindMethod(this, "updraft")
        this.isLoopInterrupt := False
        this.isKnifeStrafeQueued := False
        this.knifeStrafeQueuedDirection := False
        this.lastKnifeDireciton := False
        this.lastKnifeQueue := False
        this.lastDisplay := Now()
        this.strafeDuration := 400
    }
    resetCharacterState() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("resetCharacterState" . "`n")
        }
        this.movements.lcrouch.resetToggle()
        this.abilities.signature.resetToMaxCharges()
    }

    smokeDelayDashFullJump() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("smokeDelayDashFullJump" . "`n")
        }
        If (this.state.isJett) {
            this.abilities.first.useRaw()
            SetTimer(this.dashTimer, -200)
            SetTimer(this.updraftTimer, -400)

        }
    }
    dash() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("dash" . "`n")
        }
        this.abilities.signature.useRaw()
    }
    updraft() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("updraft" . "`n")
        }
        this.abilities.second.useRaw()
    }
    updraftDash() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("updraftDash" . "`n")
        }
        If (this.state.isJett) {
            this.abilities.second.useRaw()
            Sleep 1
            this.abilities.signature.useRaw()
        }
    }
    silentJumpUseAbility(ByRef _ability) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("silentJumpUseAbility" . "`n")
        }
        this.movements.jump.silentJump()
        _ability.useRaw()
    }
    silentJumpWaitTillAppexUseAbility(ByRef _ability) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("silentJumpUseAbility" . "`n")
        }
        this.movements.jump.silentJumpWaitTilAppex()
        _ability.useRaw()
    }
    silentCrouchJumpWaitTillAppexUseAbility(ByRef _ability) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("silentJumpUseAbility" . "`n")
        }
        this.movements.silentlCrouchJump()
        Sleep CONSTANTS.TIME_TO_REACH_CROUCH_SILENT_JUMP_APPEX
        _ability.useRaw()
    }
    displayGameState(overRide := false) {
        timeSinceLastDisplay := Now() - this.lastDisplay
        if(overRide || timeSinceLastDisplay > 1000 || this.weapons.lastWeapon != this.weapons.currentWeapon || this.lastKnifeDireciton != this.knifeStrafeQueuedDirection || this.lastKnifeQueue != this.isKnifeStrafeQueued) {
            this.lastDisplay := Now()
            this.lastWeapon := this.weapons
            this.weapons.displayWeapons(overRide)
            this.displayKnifeQueue(overRide)
            OutputDebug("`n")
        }
    }
    displayKnifeQueue(overRide := false) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("displayKnifeQueue " . "`n")
        }
        timeSinceLastDisplay := Now() - this.lastDisplay
        if(overRide || this.lastKnifeDireciton != this.knifeStrafeQueuedDirection || this.lastKnifeQueue != this.isKnifeStrafeQueued) {
            this.lastKnifeDirection := this.knifeStrafeQueuedDirection
            if(this.knifeStrafeQueuedDirection) {
                OutputDebug("- Queued " . "`n")
                OutputDebug("`t " . this.knifeStrafeQueuedDirection.name)
                OutputDebug("`n")
            }
            ; OutputDebug("------------------------`n")
        }
    }
    queueKnifeStrafe(ByRef direction) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("queueKnifeStrafe" . " isKnifeStrafeQueued " . this.isKnifeStrafeQueued . "`n")
            if (this.knifeStrafeQueuedDirection) {
                OutputDebug("queueKnifeStrafe" . " knifeStrafeQueuedDirection " . this.knifeStrafeQueuedDirection.name . "`n")
            }

        }
        if(this.isKnifeStrafeQueued && direction == this.knifeStrafeQueuedDirection) {
            this.isKnifeStrafeQueued := False
            this.knifeStrafeQueuedDirection := False
        } else {
            this.isKnifeStrafeQueued := True
            this.knifeStrafeQueuedDirection := direction
        }
        this.displayGameState(true)
        this.setLastQueueMetaData()
    }
    triggerKnifeStrafe() {
        static timeTest := 350
        if (this.isKnifeStrafeQueued) {
            this.isKnifeStrafeQueued := False
            OutputDebug("timeTest " . timeTest . "`n")
            timeTest -= 5
            if(isFullDebug || this.DebugOutput || funcDebug) {
                OutputDebug("silentJumpUseAbility" . "`n")
            }
            if(g.character.weapons.currentWeapon.name == "operator") {
                t := 340
            } else if(g.character.weapons.currentWeapon.name == "marshal") {
                t := 360
            } else {
                t := CONSTANTS.KNIFE_STRAFE_DODGE_TIME
            }
            this.weapons.currentWeapon.customActions.knifeStrafe(this.knifeStrafeQueuedDirection, t)
            this.knifeStrafeQueuedDirection := False
            this.displayGameState()
        }
    }
    setLastQueueMetaData() {
        this.lastKnifeDirection := this.knifeStrafeQueuedDirection
        this.lastKnifeQueue := this.isKnifeStrafeQueued
    }
}
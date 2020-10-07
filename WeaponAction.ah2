

/*
    WeaponAction  -------------------------------------------------------------------
*/
Class WeaponAction {
    __New(ByRef _character, ByRef kn, name, _rateOfFire, _magazineSize, _hasContinousLeftShoot := False, _hasContinousRightShoot := False, _altRateOfFire := 100) {
        this.DebugOutput := False
        this.character := _character
        this.weapon := Weapon.new(kn)
        this.name := name
        this.hasContinousLeftShoot := _hasContinousLeftShoot
        this.hasContinousRightShoot := _hasContinousRightShoot
        this.rateOfFire := (1000 / _rateOfFire) 
        this.altRateOfFire := (1000 / _altRateOfFire) 
        this.magazineSize := _magazineSize
        this.lastShot := Now()
        this.startOfSpray := Now()
        this.endOfSpray := Now()
        this.lastStrafeShot := Now()
        this.isQuickScoping := False
        this.isQuickScopeCoolingDown := False
        this.isStrafeQuickScopeCoolingDown := False
        this.isUnstrafe := False
        this.shouldUnstrafe := True
        this.customActions := WeaponCustomActions.new(this,_character)
    }

    altShot() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("altShot " . "`n")
        }
        this.customActions.doAltShots()
    }

    strafeShot(ByRef direction) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("strafeShot " . "`n")
        }
        this.customActions.doStrafeShot(direction)
    }

    knifePeak(ByRef direction) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("knifePeak " . "`n")
        }
        this.customActions.knifePeak(direction)
    }

    oneShot() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("oneShot " . "`n")
        }
        Click "Left"
        this.setLastShotMetaData()
    }

    oneRight() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("oneRight " . "`n")
        }
        Click "Right"
    }

    sprayHold() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("sprayHold " . "`n")
        }
        Click "down"
        this.startOfSpray := Now()
    }

    sprayRelease() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("sprayRelease " . "`n")
        }
        Click "up"
        this.endOfSpray := Now()
        this.setLastShotMetaData()
    }

    setLastShotMetaData() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("setLastShotMetaData " . "`n")
        }
        this.lastShot := Now()
    }

    continousLeftShoot() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("continousLeftShoot " . " name " . this.name . this.name == "guardian" . "`n")
        }
        if (this.name == "guardian") {
            this.continousLeftGuardianShoot()
        } else {
            While (this.getLeftShouldShoot(this.character)) {
                If (this.getLeftShouldShoot(this.character)) {
                    this.oneShot()
                    Sleep this.rateOfFire
                }
                if( !(GetKeyState("LButton","P")) || ! (this.getLeftShouldShoot(this.character))) {
                    this.disableContinousLeftShoot(this.character)
                } 
            }
        }
    }
    continousLeftGuardianShoot() {
        funcDebug := True
        isScoped := False
        start := Now()
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("continousLeftGuardianShoot start " . " shouldStrafe " . shouldStrafe . "`n")
        }

        this.oneShot()
        if(isFullDebug || DebugOutput || funcDebug) {
            shotDiff := NowDiff(start)
            lastShot := Now()
            OutputDebug("shotDiff " . shotDiff . "`n")
        }
        Sleep 70
        this.oneRight()
        isScoped := !isScoped
        Sleep 10
        this.oneShot()
        if(isFullDebug || DebugOutput || funcDebug) {
            shotDiff := NowDiff(lastShot)
            lastShot := Now()
            OutputDebug("shotDiff " . shotDiff . "`n")
        }
        If (this.getLeftShouldShoot(this.character)) {
            Sleep 180
            this.oneRight()
            isScoped := !isScoped
        }
        If (this.getLeftShouldShoot(this.character)) {
            Sleep 20
        }

        While (this.getLeftShouldShoot(this.character)) {
            If (this.getLeftShouldShoot(this.character)) {
                this.oneShot()
                Sleep 19
                if(isFullDebug || DebugOutput || funcDebug) {
                    shotDiff := NowDiff(lastShot)
                    lastShot := Now()
                    OutputDebug("shotDiff " . shotDiff . "`n")
                }
            }
            if( !(GetKeyState("LButton","P")) || ! (this.getLeftShouldShoot(this.character))) {
                this.disableContinousLeftShoot(this.character)
            } 
        }
        end := Now()
        timeDiff := end - start
        OutputDebug(" end: " . timeDiff . "`n")
    }
    continousRightShoot(ByRef character) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("continousRightShoot " . "`n")
        }
        While (this.getRightShouldShoot(character)) {
            If (this.getRightShouldShoot(character)) {
                this.classicLRShot()
                Sleep 49
                If (this.getRightShouldShoot(character)) {
                    Sleep 400
                }
            }
            if( !(GetKeyState("RButton","P")) || !(this.getRightShouldShoot(character))) {
                this.disableContinousRightShoot(character)
            } 
        }
    }

    classicLRShot() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("classicLRShot " . "`n")
        }
        this.oneShot()
        Sleep this.rateOfFire
        this.oneRight()
    }
    gaudianDoubleShot(unscope := True) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("gaudianDoubleShot " . "`n")
        }
        this.oneShot()
        Sleep 70
        this.oneRight()
        isScoped := !isScoped
        Sleep 10
        this.oneShot()
        if(unscope) {
            Sleep 180
            this.oneRight()
            isScoped := !isScoped
        }
    }

    getLeftShouldShoot(ByRef character) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("getLeftShouldShoot " . "`n")
        }
        ; OutputDebug(GetKeyState("LButton", "P"))
        return GetKeyState("LButton","P") && !(character.isLoopInterrupt) && character.weapons.isContinousLeftShooting
    }

    getRightShouldShoot(ByRef character) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("getRightShouldShoot " . "`n")
        }
        ; OutputDebug(GetKeyState("RButton", "P"))
        return GetKeyState("RButton","P") && !(character.isLoopInterrupt) && character.weapons.isContinousRightShooting
    }

    disableContinousLeftShoot(ByRef character) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("disableContinousLeftShoot " . "`n")
        }
        character.weapons.isContinousLeftShooting := False 
        Click "Left Up"
    }

    disableContinousRightShoot(ByRef character) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("disableContinousRightShoot " . "`n")
        }
        character.weapons.isContinousRightShooting := False 
        Click "Right Up"
    }
}
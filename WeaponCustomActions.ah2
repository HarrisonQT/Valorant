
#Include "Constants.ah2"
#Include "WeaponAction.ah2"
/*
    WeaponCustomActions  -------------------------------------------------------------------
*/

Class WeaponCustomActions {
    __New(ByRef _weaponAction, ByRef _character) {
        this.DebugOutput := False
        this.weaponAction := _weaponAction
        this.character := _character
        this.isStrafing := False
        this.isQuickScoping := False
        this.isQuickScopeCoolingDown := False
        this.isStrafeCoolingDown := False
        this.lastStrafeShot := Now()
        this.isSpraying := False
        this.sprayStart := Now()
    }
    crouch() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("crouch " . "`n")
        }
        this.character.movements.lcrouch.pressAndHold()
    }
    uncrouch() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("uncrouch " . "`n")
        }
        this.character.movements.lcrouch.release()
    }
    scope(scopeDelay := 0) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("scope " . " scopeDelay " . scopeDelay . "`n")
        }
        Click "Right"
        Sleep scopeDelay
    }
    unScope(unscopeTime := -2) {
        if(unscopeTime == -2 ) {
            unscopeTime := CONSTANTS.SCOPE_UNSCOPE_TIME
        }
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("unScope " . "`n")
        }
        Sleep unscopeTime
        Click "Right"
    }
    doAltShots(shouldStrafe := False, ByRef direction := False) {
        static timeTest := 200
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("doAltShots " . "`n")
        }
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("doAltShots start " . " shouldStrafe " . shouldStrafe . "`n")
            OutputDebug(" direction " . direciton . "`n")
        }
        if (this.weaponAction.name == "stinger") {
            if(!shouldStrafe) {
                this.sprayScopeBurstFire(6, -2, 1, 2, True, False, False, -2, False, -2, -2, False, -2, 155)
            } else {
                this.sprayScopeBurstFire(6, -2, 1, 2, True, shouldStrafe, direction, 0, True, 225, 130, True, -2)
            }
        } else if (this.weaponAction.name == "spectre") {
            if(!shouldStrafe) {
                this.spray(5, -2, 1, 3, True, False, direction, 0, False, -2, -2, False, 2)
            } else {
                this.spray(5, -2, 1, 2, True, shouldStrafe, direction, 0, True, 265, 130, True, 2)
            }
        } else if (this.weaponAction.name == "bucky") {
            if(!shouldStrafe) {
                this.nShots(1, 0, -2, -2, False, shouldStrafe, direction)
            } else {
                this.nShots(1, -2, -2, -2, False, shouldStrafe, direction, , False, 275, 285, False, -2)
            }
        } else if (this.weaponAction.name == "judge") {
            if(!shouldStrafe) {
                this.spray(2, -2, -2, -2, True, False, direction, 0, False, -2, -2, False, 2)
            } else {
                this.spray(2, -2, -2, -2, True, shouldStrafe, direction, 0, True, 265, 35, True, 1)
            }
        } else if (this.weaponAction.name == "bulldog") {
            if(!shouldStrafe) {
                this.sprayScopeBurstFire(3, -2, 1, 2, True, False, False, -2, False, -2, -2, False, -2, 205)
            } else {
                OutputDebug("timeTest " . timeTest . "`n")
                timeTest += 20
                this.sprayScopeBurstFire(1, -2, 1, 2, True, shouldStrafe, direction, -2, True, 1, 260, False, -2)
            }
        } else if (this.weaponAction.name == "guardian") {
            if(!shouldStrafe) {
                this.weaponAction.gaudianDoubleShot()
            } else {
                this.weaponAction.gaudianDoubleShot(False)
                Sleep 100
                this.knifeCounterStrafe(direction,270)
            }
        } else if (this.weaponAction.name == "phantom") {
            if(!shouldStrafe) {
                this.spray(5, -2, 1, 2, True, False, direction, 0, False, -2, -2, False, 2)
            } else {
                this.spray(5, -2, 1, 2, True, shouldStrafe, direction, 0, True, 265, 60, True, 2)
            }
        } else if (this.weaponAction.name == "vandal") {
            if(!shouldStrafe) {
                this.spray(5, -2, 1, 2, True, False, direction, 0, False, -2, -2, False, 2)
            } else {
                this.spray(4, -2, 1, 2, True, shouldStrafe, direction, 0, True, 265, 180, True, 2)
            }
        } else if (this.weaponAction.name == "marshal") {
            this.quickScope(CONSTANTS.TIME_TO_MARSHAL_QUICK_SCOPE, CONSTANTS.TIME_BETWEEN_MARSHAL_QUICK_SCOPES)
        } else if (this.weaponAction.name == "operator") {
            OutputDebug("timeTest " . timeTest . "`n")
            this.quickScope(CONSTANTS.TIME_TO_OPERATOR_QUICK_SCOPE, timeTest)
            ; timeTest += 25
        } else if (this.weaponAction.name == "aries") {
            if(!shouldStrafe) {
                this.scopeNSpray(8, -2, 1, 6, True, False, direction, 0, False, -2, -2, False, 2, True)
            } else {
                this.scopeNSpray(8, -2, 1, 4, True, shouldStrafe, direction, 0, True, 265, 110, True, 2, True)
            }
        } else if (this.weaponAction.name == "odin") {
            if(!shouldStrafe) {
                this.scopeNSpray(10, -2, 1, 4, True, False, direction, 0, False, -2, -2, False, 4, True, 265)
            } else {
                this.scopeNSpray(10, -2, 1, 4, True, shouldStrafe, direction, 0, True, 265, 80, True, 2, True, 265)
            }
        } else if (this.weaponAction.name == "sheriff") {
            if(!shouldStrafe) {
                this.nShots(2, -2,-2, -2, True, shouldStrafe, direction)
            } else {
                this.nShots(2, 10,-2, -2, True, shouldStrafe, direction, , False, 272, 250)
            }
        } else if (this.weaponAction.name == "ghost") {
            if(!shouldStrafe) {
                this.nShots(3, 0,-2, -2, True, shouldStrafe, direction)
            } else {
                OutputDebug("timeTest " . timeTest . "`n")
                this.nShots(1, -2,-2, -2, True, shouldStrafe, direction, , , 235, 235)
                timeTest += 10
            }
        } else if (this.weaponAction.name == "frenzy") {
            if(!shouldStrafe) {
                this.spray(5, -2, 1, 2, True, False, direction, 0, False, -2, -2, False, 2)
            } else {
                this.spray(5, -2, 1, 2, True, shouldStrafe, direction, 0, True, 265, 120, True, 2)
            }
        } else if (this.weaponAction.name == "shorty") {
            if(!shouldStrafe) {
                this.nShots(2, -2,-2, -2, True, shouldStrafe, direction)
            } else {
                OutputDebug("timeTest " . timeTest . "`n")
                this.nShots(2, -2,-2, -2, True, shouldStrafe, direction, -2, True, 345, -2, False, 1)
                timeTest += 5
            }
        } else if (this.weaponAction.name == "classic") {
            if(!shouldStrafe) {
                this.nShotsNRight(1, -2, -2, -2,1, shouldStrafe, direction)
            } else {
                this.nShotsNRight(1, -2, -2, -2,1, shouldStrafe, direction, 25, True, 178, 285)
            }
        }
        if(isFullDebug || this.DebugOutput || funcDebug) {
            end := Now()
            timeDiff := end - start
            OutputDebug("doAltShots end: " . timeDiff . "`n")
        }
        this.DebugOutput := False
    }

    doStrafeShot(ByRef direction) {
        this.DebugOutput := False
        funcDebug := true
        start := Now()
        static timeTest := 1600
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("doStrafeShot " . " direction: " . direction.name "`n")
        }
        if (this.weaponAction.name == "marshal") {
            this.strafeQuickScope(direction, CONSTANTS.TIME_TO_MARSHAL_QUICK_SCOPE, CONSTANTS.TIME_BETWEEN_MARSHAL_QUICK_SCOPES, CONSTANTS.MOVEMENT_DECELERATION, true, 276 , 226)
        } else if (this.weaponAction.name == "operator") {
            this.strafeQuickScope(direction, CONSTANTS.TIME_TO_OPERATOR_QUICK_SCOPE, CONSTANTS.TIME_BETWEEN_STRAFE_OPERATOR_QUICK_SCOPES, CONSTANTS.MOVEMENT_DECELERATION_OPERATOR, true, 290, 195)
        } else {
            this.strafeAltFire(direction, true)
        }
        if(isFullDebug || this.DebugOutput || funcDebug) {
            end := Now()
            timeDiff := end - start
            OutputDebug("doStrafeShot end: " . timeDiff . "`n")
        }

        this.DebugOutput := False
    }

    knifePeak(ByRef direction) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("knifePeak " . "`n")
        }
        start := Now()
        oppositeDirection := this.character.movements.getOppositeDirection(direction)
        this.knifeStrafe(direction, 290, false)
        this.knifeCounterStrafe(direction, 395, true)
        end := Now()
        timeDiff := end - start
        if(isFullDebug || DebugOutput || funcDebug) {
            OutputDebug("knifePeak end: " . timeDiff . "`n")
        }
    }

    directionalPeak(ByRef direction) {
        funcDebug := True
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("directionalPeak " . "`n")
        }
        this.character.movements.peakStrafe(direction)
    }

    ; directionalScopePeak(ByRef direction, timeToScope) {
    ;     if(isFullDebug || this.DebugOutput || funcDebug) {
    ;         OutputDebug("directionalScopePeak " . "`n")
    ;     }
    ;     if(direction == this.character.movements.leftMove) {
    ;         this.character.movements.leftScopePeak(timeToScope)
    ;     } else {
    ;         this.character.movements.rightScopePeak(timeToScope)
    ;     }
    ; }

    directionalCounterStrafe(ByRef direction, strafeTime := 150, shouldRelease := False){
        funcDebug := True
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("directionalCounterStrafe " . "`n")
        }

        if(isFullDebug || this.DebugOutput || funcDebug) {
            start := Now()
            OutputDebug("directionalCounterStrafe" . " strafeTime " . strafeTime . " shouldRelease " . shouldRelease . "`n")
            OutputDebug("directionalCounterStrafe start " . " shouldStrafe " . shouldStrafe . "`n")
        }
        oppositeDirection := this.character.movements.getOppositeDirection(direction)
        this.character.movements.peakShootCounterStrafe(oppositeDirection, strafeTime, shouldRelease )
        if(isFullDebug || this.DebugOutput || funcDebug) {
            end := Now()
            timeDiff := end - start
            OutputDebug("directionalCounterStrafe end: " . timeDiff . "`n")
        }
    }

    knifeStrafe(ByRef direction, strafeTime := 325, reequip := True, reequipTime := 0) {
        funcDebug := True 
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("knifeStrafe " . " strafeTime " . strafeTime . "`n")
        }
        Send "{3}"
        Sleep 10
        this.character.movements.currentStrafeDirection := direction
        direction.action.pressAndHold()
        strafeTimeBeforeReEquip := strafeTime - reequipTime
        remainingStrafeTime := strafeTime - strafeTimeBeforeReEquip 
        Sleep strafeTimeBeforeReEquip
        if(reequip) {
            this.weaponAction.weapon.action.press()
        }
        Sleep remainingStrafeTime
        direction.action.release()
    }

    knifeCounterStrafe(ByRef direction, strafeTime := 250, reequip := True, reequipTime := 0) {
        funcDebug := True
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("knifeCounterStrafe " . "`n")
        }
        if(isFullDebug || this.DebugOutput || funcDebug) {
            start := Now()
            OutputDebug("knifeCounterStrafe strafeTime " . strafeTime . " reequip " . reequip . "`n")
            OutputDebug("knifeCounterStrafe start " . " shouldStrafe = " . shouldStrafe . "`n")
        }
        oppositeDirection := this.character.movements.getOppositeDirection(direction)
        this.knifeStrafe(oppositeDirection,strafeTime, reequip, reequipTime)
    }
    ; knifeCounterStrafe(ByRef direction,strafeTime := 250, reequip := True) {
    ;     funcDebug := True
    ;     if(isFullDebug || this.DebugOutput || funcDebug) {
    ;         OutputDebug("knifeCounterStrafe " . "`n")
    ;     }
    ;     if(isFullDebug || this.DebugOutput || funcDebug) {
    ;         start := Now()
    ;         OutputDebug("knifeCounterStrafe strafeTime " . strafeTime . " reequip " . reequip . "`n")
    ;         OutputDebug("knifeCounterStrafe start " . " shouldStrafe = " . shouldStrafe . "`n")
    ;     }
    ;     Send "{3}"
    ;     oppositeDirection := this.character.movements.getOppositeDirection(direction)
    ;     If (!(oppositeDirection.action.isPhysicallyHeldDown())) {
    ;         oppositeDirection.action.pressAndHold()
    ;     } 
    ;     Sleep strafeTime
    ;     if(reequip) {
    ;         this.weaponAction.weapon.action.press()
    ;     }
    ;     oppositeDirection.action.release()
    ;     if(isFullDebug || this.DebugOutput || funcDebug) {
    ;         end := Now()
    ;         timeDiff := end - start
    ;         OutputDebug("knifeCounterStrafe end: " . timeDiff . "`n")
    ;     }
    ; }
    strafeCooldown(cooldownTime) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("strafeCooldown " . "`n")
        }
        timeDiff := Now() - this.lastStrafeShot
        if(timeDiff < cooldownTime) {
            sleepTime := cooldownTime - timeDiff
            if(isFullDebug || this.DebugOutput || funcDebug) {
                OutputDebug("strafeCooldown " . sleepTime . " ")
            }
            this.isStrafeCoolingDown := True
            Sleep sleepTime
        }
    }
    strafeQuickScope(ByRef direction, scopeTime, cooldownTime, movementDecelerationTime := 80, shouldKnifeStrafe := False, strafeDuration := 150, counterStrafeDuration := 150) {
        funcDebug := True
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("strafeQuickScope " . "`n")
        }
        start := Now()
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("strafeQuickScope start " . " shouldStrafe " . shouldStrafe . " strafeDuration " . strafeDuration . " counterStrafeDuration " . counterStrafeDuration . "`n")
        }
        if(!this.isStrafeCoolingDown) {
            this.strafeCooldown(cooldownTime)
            if(isFullDebug || this.DebugOutput || funcDebug) {
                OutputDebug("strafeQuickScope" . "`n")
            }
            this.isStrafeCoolingDown := False
            this.character.movements.scopePeakStrafe(direction,scopeTime, strafeDuration)
            Sleep movementDecelerationTime
            this.character.weapons.currentWeapon.oneShot()
            this.weaponAction.setLastShotMetaData()
            Sleep 1
            this.character.weapons.currentWeapon.oneRight()
            timeBeforeKnifeCounterStrafe := Now()
            diffBeforeKnifeCounterStrafe := timeBeforeKnifeCounterStrafe - start
            if(isFullDebug || this.DebugOutput || funcDebug) {
                OutputDebug("diffBeforeKnifeCounterStrafe " . diffBeforeKnifeCounterStrafe . "`n")
            }
            this.knifeCounterStrafe(direction, counterStrafeDuration)
            this.lastStrafeShot := Now()
        }
        if(isFullDebug || this.DebugOutput || funcDebug) {
            end := Now()
            timeDiff := end - start
            OutputDebug("strafeQuickScope end: " . timeDiff . "`n")
        }
    }
    strafeAltFire(ByRef direction, shouldKnifeStrafe := False, strafeCooldown := 500, strafeTime := 300) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("strafeAltFire " . "`n")
        }
        if(!this.isStrafeCoolingDown) {
            this.strafeCooldown(strafeCooldown)
            if(isFullDebug || this.DebugOutput || funcDebug) {
                OutputDebug("strafeAltFire" . "`n")
            }
            this.isStrafeCoolingDown := False
            this.directionalPeak(direction)
            Sleep CONSTANTS.MOVEMENT_DECELERATION
        }
        this.doAltShots(shouldKnifeStrafe, direction)
    }

    nShots(bullets, 
    addedDelay := -2, 
    crouchNumber := -2, 
    unCrouchNumber := -2, 
    isLeft := True, 
    shouldStrafe := False, 
    ByRef direction := False, 
    strafeDelay := 0, 
    shouldEarlyStrafe := False, 
    strafeDuration := 265,
    knifeDuration := 150,
    shouldRelease := True,
    earlyRelaseBullet := -2
    ) {
        funcDebug := True
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("nShots " . bullets . " addedDelay " . addedDelay . " crouchNumber " . crouchNumber . " unCrouchNumber " . unCrouchNumber . " isLeft " . isLeft . " shouldStrafe " . shouldStrafe . " strafeDelay " . strafeDelay . " shouldEarlyStrafe " . shouldEarlyStrafe . "`n")
            OutputDebug("strafeDuration " . strafeDuration . " knifeDuration " . knifeDuration . " earlyRelaseBullet " . earlyRelaseBullet . "`n")
        }
        startedEarlyStrafe := False
        start := Now()
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("nShots start " . " shouldStrafe " . shouldStrafe . "`n")
        }
        if(crouchNumber == - 1) {
            this.crouch()
        }
        Loop(bullets) {
            if(isFullDebug || this.DebugOutput || funcDebug) {
                OutputDebug("A_Index " . A_Index . " bullets " . bullets . " crouchNumber " . crouchNumber . " unCrouchNumber " . unCrouchNumber . "`n")
            }
            if(isLeft) {
                this.weaponAction.oneShot()
            } else {
                this.weaponAction.oneRight()
            }
            if(A_Index == crouchNumber) {
                if(isFullDebug || this.DebugOutput || funcDebug) {
                    OutputDebug("crouch " . A_Index . " crouchNumber " . crouchNumber . "`n")
                }
                this.crouch()
            }

            if(A_Index == unCrouchNumber) {
                if(isFullDebug || this.DebugOutput || funcDebug) {
                    OutputDebug("crouch " . A_Index . " unCrouchNumber " . unCrouchNumber . "`n")
                }
                this.crouch()
            }
            if(!shouldEarlyStrafe || (bullets > 1 && A_Index != bullets )) {
                if(A_Index != bullets) {
                    Sleep this.weaponAction.rateOfFire
                    if( addedDelay > 0 ) {
                        Sleep addedDelay 
                    }
                }
            }
            if(shouldStrafe) {
                if(strafeDelay > 0) {
                    Sleep strafeDelay
                }
                if(!shouldEarlyStrafe ) {
                    if (A_Index == bullets ) {
                        if(knifeDuration > 0) {
                            this.knifeCounterStrafe(direction, knifeDuration)
                        }
                    } 
                } else {
                    if(startedEarlyStrafe) {
                        if(knifeDuration > 0) {
                            this.knifeCounterStrafe(direction, knifeDuration)
                        } else {
                            oppositeDirection := this.character.movements.getOppositeDirection(direction)
                            oppositeDirection.action.release()
                        }
                    }
                    if(A_Index == earlyRelaseBullet || bullets == 1) {
                        if(!startedEarlyStrafe) {
                            this.directionalCounterStrafe(direction, strafeDuration, shouldRelease)
                            Sleep (this.weaponAction.rateOfFire - strafeDelay)
                            startedEarlyStrafe := True
                        } 
                        if(startedEarlyStrafe && bullets == 1) {
                            this.knifeCounterStrafe(direction, knifeDuration)
                        }
                    }
                }
            }
        }
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("crouch " . bullets . " unCrouchNumber " . unCrouchNumber . "`n")
        }
        if(bullets < unCrouchNumber && bullets == unCrouchNumber - 1) {
            if(isFullDebug || this.DebugOutput || funcDebug) {
                OutputDebug("crouch " . bullets . " unCrouchNumber " . unCrouchNumber . "`n")
            }
            this.crouch()
        }
        if(isFullDebug || this.DebugOutput || funcDebug) {
            end := Now()
            timeDiff := end - start
            OutputDebug("nShots end: " . timeDiff . "`n")
        }
    }

    nShotsNRight(bullets,
    addedDelay := -2,
    crouchNumber := -2,
    unCrouchNumber := -2,
    rShots := 1,
    shouldStrafe := False,
    ByRef direction := False,
    strafeDelay := 0,
    shouldEarlyStrafe := False,
    strafeDuration := 265,
    knifeDuration := 150
    ) {
        funcDebug := True
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("nShotsNRight" . "`n")
            OutputDebug("bullets " . bullets . " addedDelay " . addedDelay . " crouchNumber " . crouchNumber . " unCrouchNumber " . unCrouchNumber . " shouldStrafe " . shouldStrafe . " rShots " . rShots . "`n")
            OutputDebug("shouldEarlyStrafe " . shouldEarlyStrafe . " strafeDuration " . strafeDuration . " knifeDuration " . knifeDuration . "`n")
        }
        OutputDebug("timeTest " . timeTest . "`n")
        this.nShots(bullets, addedDelay, crouchNumber, unCrouchNumber, True, shouldStrafe, direction, , False,strafeDuration , -2 , False )
        Sleep (this.weaponAction.rateOfFire)
        this.nShots(rShots, addedDelay, crouchNumber, unCrouchNumber, False, shouldStrafe, direction, strafeDelay, False, knifeDuration, knifeDuration)

    }
    getAriesSprayTimes(bullets) {
        return CONSTANTS.ARIES_SPRAY_TIMES[bullets]
    }
    getSprayTimeFromBullets(bullets, isAltFire := False) {
        funcDebug := True
        if(isFullDebug || DebugOutput || funcDebug) {
            OutputDebug("getSprayTimeFromBullets " . " bullets " . bullets . " isAltFire " . isAltFire . "`n")
            if(isAltFire) {
                OutputDebug("altRateOfFire " . this.weaponAction.altRateOfFire . "`n")
            }
        }
        if(this.weaponAction.name == "aries") {
            sprayTime := this.getAriesSprayTimes(bullets)
        } else {
            sprayTime := -1
            if(bullets > -2) {
                if(bullets == -1) {
                    sprayTime := 0
                }
                fireRate := (!isAltFire) ? this.weaponAction.rateOfFire : this.weaponAction.altRateOfFire
                sprayTime := (bullets-1 > 0 ? bullets - 1 : 1) * fireRate
            }
        }
        return sprayTime
    }
    spray(bullets, 
    addedDelay := -2, 
    crouchNumber := -2, 
    unCrouchNumber := -2, 
    isLeft := True, 
    shouldStrafe := False, 
    ByRef direction := False, 
    strafeDelay := 0, 
    shouldEarlyStrafe := False, 
    strafeDuration := 265,
    knifeDuration := 150,
    shouldRelease := True,
    earlyRelaseBullet := -2,
    isAltFire := False
    ) {
        funcDebug := True
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("spray " . bullets . " addedDelay " . addedDelay . " crouchNumber " . crouchNumber . " unCrouchNumber " . unCrouchNumber . " isLeft " . isLeft . " shouldStrafe " . shouldStrafe . " strafeDelay " . strafeDelay . " shouldEarlyStrafe " . shouldEarlyStrafe . "`n")
            OutputDebug("strafeDuration " . strafeDuration . " knifeDuration " . knifeDuration . "`n")
        }
        bulletTime := this.getSprayTimeFromBullets(bullets, isAltFire)
        uncrouchTime := crouchNumber > -2 ? this.getSprayTimeFromBullets(unCrouchNumber, isAltFire) : 0
        timeTilCrouch := crouchNumber > -2 ? this.getSprayTimeFromBullets(crouchNumber, isAltFire) : 0
        earlyStrafeTime := earlyRelaseBullet > -2 ? this.getSprayTimeFromBullets(earlyRelaseBullet + 1, isAltFire) - timeTilCrouch - uncrouchTime: 0

        sprayTime := bulletTime - timeTilCrouch - uncrouchTime

        timeTilUncrouch := sprayTime - uncrouchTime

        this.isSpraying := True
        this.weaponAction.sprayHold()
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("bulletTime " . bulletTime . " timeTilCrouch " . timeTilCrouch . "`n")
            OutputDebug("earlyStrafeTime " . earlyStrafeTime . " sprayTime " . sprayTime . " uncrouchTime " . uncrouchTime . "`n")
        }
        Sleep timeTilCrouch
        if(crouchNumber > -1) {
            this.crouch()
        }
        Sleep uncrouchTime
        if(unCrouchNumber > -1) {
            this.uncrouch()
        }
        Sleep earlyStrafeTime
        if(shouldEarlyStrafe) {
            this.directionalCounterStrafe(direction, this.weaponAction.rateOfFire, False)
        }
        Sleep sprayTime
        if(shouldRelease) {
            this.weaponAction.sprayRelease()
        }
        if(shouldStrafe && knifeDuration > 0) {
            this.knifeCounterStrafe(direction, knifeDuration)
        }
        this.isSpraying := False
        this.weaponAction.sprayRelease()
    }
    resumeSpray() {
        ; funcDebug := True
        if(isFullDebug || DebugOutput || funcDebug) {
            OutputDebug("resumeSpray " . "`n")
        }
        if(this.isSpraying) {
            this.weaponAction.sprayHold()
        }
    }

    scopeNSpray(bullets, 
    addedDelay := -2, 
    crouchNumber := -2, 
    unCrouchNumber := -2, 
    isLeft := True, 
    shouldStrafe := False, 
    ByRef direction := False, 
    strafeDelay := 0, 
    shouldEarlyStrafe := False, 
    strafeDuration := 265,
    knifeDuration := 150,
    shouldRelease := True,
    earlyRelaseBullet := -2,
    isAltFire := False,
    scopeDelay := 0) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("scopeNSpray" . "`n")
        }
        this.scope(scopeDelay)
        this.spray(bullets,addedDelay,crouchNumber,unCrouchNumber,isLeft,shouldStrafe,direction,strafeDelay,shouldEarlyStrafe,strafeDuration,knifeDuration,shouldRelease,earlyRelaseBullet,isAltFire )
        this.unScope()
    }

    scopeBurstFire(shouldStrafe := False, 
    ByRef direction := False, 
    strafeDelay := 0, 
    shouldEarlyStrafe := false,
    strafeDuration := 265,
    knifeDuration := 150,
    scopeTime := 155
    ) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("scopeBurstFire" . " strafeDuration " . strafeDuration . direction.name . " direction " . shouldStrafe . " strafeDelay " . strafeDelay . " shouldEarlyStrafe " . shouldEarlyStrafe . "`n" )
        }
        this.scope()
        this.nShots(1, -2, -2, -2, True, shouldStrafe, direction, strafeDelay, shouldEarlyStrafe, strafeDuration, knifeDuration, ,-2)
        this.unScope(scopeTime)
    }

    sprayScopeBurstFire(
    bullets, 
    addedDelay := -2, 
    crouchNumber := -2, 
    unCrouchNumber := -2, 
    isLeft := True, 
    shouldStrafe := False, 
    ByRef direction := False, 
    strafeDelay := 0, 
    shouldEarlyStrafe := False, 
    strafeDuration := 265,
    knifeDuration := 150,
    shouldRelease := True,
    earlyRelaseBullet := -2,
    scopeTime := 155
    ) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("sprayScopeBurstFire" . " bullets " . bullets . " crouch1 " . crouch1 . " uncrouch1 " . uncrouch1 . " crouch2 " . crouch2 . " uncrouch2 " . uncrouch2 . "`n" . " direction " . direction.name . " strafeDelay " . strafeDelay . " shouldEarlyStrafe " . shouldEarlyStrafe . "`n" )
        }
        this.spray(bullets,addedDelay,crouchNumber,unCrouchNumber,isLeft,False,direction,0,False,strafeDuration,-2,True,-2)
        if(shouldStrafe) {
            Sleep strafeDelay
        }
        this.scopeBurstFire(shouldStrafe, direction, strafeDelay, shouldEarlyStrafe,strafeDuration, knifeDuration, scopeTime)
    }

    quickScopeCooldown(cooldownTime) {
        timeDiff := Now() - this.weaponAction.lastShot
        if(isFullDebug || this.DebugOutput || funcDebug) {
            t := testNum
            OutputDebug("timeDiff " . timeDiff . " t " . t . "`n")
        }
        if(timeDiff < cooldownTime) {
            sleepTime := cooldownTime - timeDiff
            if(isFullDebug || this.DebugOutput || funcDebug) {
                OutputDebug("quickScopeCooldown " . sleepTime . " ")
            }
            this.isQuickScopeCoolingDown := True
            Sleep sleepTime
        }
    }

    quickScope(scopeTime, cooldownTime) { 
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("quickScope" . "`n")
        }
        if(!this.isQuickScopeCoolingDown) {
            this.quickScopeCooldown(cooldownTime)
            this.isQuickScopeCoolingDown := False
            this.character.movements.stopAllMovement()
            Click "Right"
            Sleep scopeTime
            this.weaponAction.oneShot()
            this.character.movements.resumeMovement()
        }
    }
}
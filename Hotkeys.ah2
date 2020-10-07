~1:: {
    g.character.weapons.setCurrentWeaponAsPrimary()
    g.character.weapons.inspectWeaponIfContinous()
}
>+1::{
    g.character.weapons.toggleContinousLeftShoot()
    g.character.weapons.inspectWeaponIfContinous()
}
~2:: {
    g.character.weapons.setCurrentWeaponAsSideArm()
    g.character.weapons.inspectWeaponIfContinous()
}
>+2:: {
    g.character.weapons.toggleContinousLeftShoot()
    g.character.weapons.toggleContinousRightShoot()
    g.character.weapons.inspectWeaponIfContinous()
}
~g:: {
    g.character.weapons.setCurrentWeaponAsJettKnives()
}
~WheelUp::{
    g.character.weapons.setCurrentWeaponAsKnife()
}
~WheelDown:: {
    g.character.weapons.setCurrentWeaponAsPrimary()
    g.character.weapons.inspectWeaponIfContinous()
}

/*
    2. Shooting ---------------------------------------------------------------
*/

; LShift & LButton::{
;     g.character.weapons.currentWeapon.unstrafeShot(g.character)
; }

LCtrl & LButton::{
    g.character.weapons.currentWeapon.strafeShot(g.character.movements.leftMove)
}
LCtrl & RButton::{
    g.character.weapons.currentWeapon.strafeShot(g.character.movements.rightMove)
}
RShift & LButton::{
    g.character.weapons.altShot(g.character)
}
RShift & LButton up::{
    g.character.weapons.currentWeapon.customActions.resumeSpray()
}
~LButton:: {
    if(g.character.weapons.isCurrentWeaponPrimary() || g.character.weapons.isCurrentWeaponSidearm()){
        g.character.weapons.currentWeapon.setLastShotMetaData()
    }
    if(g.character.weapons.currentWeapon.name == "operator" && g.character.isKnifeStrafeQueued) {
        g.character.triggerKnifeStrafe()
    }
    if(g.character.weapons.isCurrentWeaponPrimary()) {
        g.character.weapons.currentWeapon.setLastShotMetaData()
    }
    if(g.character.weapons.hasContinousLeftShoot && !(g.character.isLoopInterrupt)) {
        g.character.weapons.isContinousLeftShooting := True
        g.character.weapons.currentWeapon.continousLeftShoot()
    }
}
~LButton up:: {
    g.character.weapons.isContinousLeftShooting := False
    if(g.character.weapons.currentWeapon.customActions.isSpraying) {
        g.character.weapons.currentWeapon.customActions.resumeSpray()
    }
    if(g.character.isKnifeStrafeQueued) {
        g.character.triggerKnifeStrafe()
    }
}
#HotIf (g.character.weapons.isCurrentWeaponSidearm())
RButton:: {
    if(g.character.weapons.hasContinousRightShoot && !(g.character.isLoopInterrupt) && g.character.weapons.isCurrentWeaponSidearm()) {
        g.character.weapons.isContinousRightShooting := True
        g.character.weapons.currentWeapon.continousRightShoot(g.character)
    }
}
RButton up:: {
    g.character.weapons.isContinousRightShooting := False
}
#HotIf

#HotIf (WinActive("VALORANT") && hotKeysActive)

/*
    3. Abilities --------------------------------------------------------------
*/
; 
5:: {
    g.character.silentCrouchJumpWaitTillAppexUseAbility(g.character.abilities.first)
}
6:: {
    g.character.silentJumpWaitTillAppexUseAbility(g.character.abilities.first)
}
; <+v::{
;     g.character.silentJumpWaitTillAppexUseAbility(g.character.abilities.first)
; }
; v::{
;     g.character.abilities.first.useRaw()
; }
; !v::{
;     g.character.abilities.first.incrementCharges()
; }
; +q::
; q::{
;     g.character.abilities.second.useRaw()
; }
; !q::{
;     ; g.character.abilities.second.incrementCharges()
; }
; +g::
;     g::{
;         g.character.abilities.ultimate.useRaw()
;     }
;     !g::{
;         g.character.abilities.ultimate.incrementCharges()
;     }
+e:: {
    g.character.abilities.signature.useRaw()
}
e:: {
    g.character.abilities.signature.useRaw()
}
!e:: {
    g.character.abilities.signature.incrementCharges()
}

/*
    4. Movement ---------------------------------------------------------------
        4a. Directional -------------------------------------------------------
*/

<^a::{
    g.character.weapons.currentWeapon.knifePeak(g.character.movements.leftMove)
    ; g.character.movements.leftShoulderPeak()
}
<^a up::{
    if(g.character.movements.currentStrafeDirection) {
        g.character.movements.currentStrafeDirection.action.pressAndHold()
    }
}
<^d::{
    ; g.character.movements.rightShoulderPeak()
    g.character.weapons.currentWeapon.knifePeak(g.character.movements.rightMove)
}
<^d up::{
    if(g.character.movements.currentStrafeDirection) {
        g.character.movements.currentStrafeDirection.action.pressAndHold()
    }
}
<^w::{
    ; g.character.movements.forwardShoulderPeak()
    g.character.weapons.currentWeapon.customActions.knifePeak(g.character.movements.forwardMove)
}
<^w up::{
    if(g.character.movements.currentStrafeDirection) {
        g.character.movements.currentStrafeDirection.action.pressAndHold()
    }
}
<^s::{
    ; g.character.movements.backwardShoulderPeak()
    g.character.weapons.currentWeapon.customActions.knifePeak(g.character.movements.backwardMove)
}
<^s up::{
    if(g.character.movements.currentStrafeDirection) {
        g.character.movements.currentStrafeDirection.action.pressAndHold()
    }
}
~w:: {
    g.character.movements.forwardMove.action.setPressMetaData()
}
~w up:: {
    g.character.movements.forwardMove.action.setReleaseMetaData()
}

~a:: {
    g.character.movements.leftMove.action.setPressMetaData()
}
~a up:: {
    g.character.movements.leftMove.action.setReleaseMetaData()
}
~s:: {
    g.character.movements.backwardMove.action.setPressMetaData()
}
~s up:: {
    g.character.movements.backwardMove.action.setReleaseMetaData()
}
~d:: {
    g.character.movements.rightMove.action.setPressMetaData()
}
~d up:: {
    g.character.movements.rightMove.action.setReleaseMetaData()
}

z:: {
    g.character.movements.leftMove.DirectionalDash(g.character)
}
x:: {
    g.character.movements.backwardMove.DirectionalDash(g.character)
}
c:: {
    g.character.movements.rightMove.DirectionalDash(g.character)
}

+3:: {
    g.character.weapons.currentWeapon.customActions.knifeStrafe(g.character.movements.leftMove, CONSTANTS.KNIFE_STRAFE_DODGE_TIME, (CONSTANTS.KNIFE_STRAFE_DODGE_TIME - CONSTANTS.KNIFE_STRAFE_REEQUIP_TIME))
}
3:: {
    g.character.weapons.currentWeapon.customActions.knifeStrafe(g.character.movements.rightMove, CONSTANTS.KNIFE_STRAFE_DODGE_TIME, (CONSTANTS.KNIFE_STRAFE_DODGE_TIME - CONSTANTS.KNIFE_STRAFE_REEQUIP_TIME))
}
t:: {
    g.character.smokeDelayDashFullJump()
}
+t:: {
    g.character.updraftDash()
}
y:: {
    g.character.updraftDash()
}
~+9:: {
    g.character.queueKnifeStrafe(g.character.movements.leftMove)
}
~+0:: {
    g.character.queueKnifeStrafe(g.character.movements.rightMove)
}
RShift & Z:: {
    g.character.queueKnifeStrafe(g.character.movements.leftMove)
}
RShift & C:: {
    g.character.queueKnifeStrafe(g.character.movements.rightMove)
}

<^c::{
    g.character.weapons.currentWeapon.customActions.directionalPeak(g.character.movements.rightMove)
}

<^z::{
    g.character.weapons.currentWeapon.customActions.directionalPeak(g.character.movements.leftMove)
}

/*
    4. Movement ---------------------------------------------------------------
        4a. Jump --------------------------------------------------------------
*/
XButton1:: {
    g.character.movements.continousBHopping()
}

XButton1 up:: {
    g.character.movements.releaseBHopMovement()
}
+space:: {
    g.character.movements.jump.silentJumpAndHold()
}
space:: {
    g.character.movements.jump.silentJumpAndHold()
}
+space up:: {
    g.character.movements.jump.jumpRelease()
}
space up:: {
    g.character.movements.jump.jumpRelease()
}
/*
    4. Movement ---------------------------------------------------------------
        4a. Croch -------------------------------------------------------------
*/
~RCtrl:: {
    g.character.movements.lcrouch.setPressMetaData()
}

+7:: {
    g.character.movements.silentlCrouchJump()
}

/*
    Inventory
*/
F1::{
    g.character.weapons.weaponInventory.equipStinger()
}
F2::{
    g.character.weapons.weaponInventory.equipSpectre()
}
F3::{
    g.character.weapons.weaponInventory.equipBucky()
}
F4::{
    g.character.weapons.weaponInventory.equipJudge()
}
F5::{
    g.character.weapons.weaponInventory.equipBulldog()
}
F6::{
    g.character.weapons.weaponInventory.equipGuardian()
}
F7::{
    g.character.weapons.weaponInventory.equipPhantom()
}
F8::{
    g.character.weapons.weaponInventory.equipVandal()
}
F9::{
    g.character.weapons.weaponInventory.equipMarshal()
}
F10::{
    g.character.weapons.weaponInventory.equipOperator()
}
F11::{
    g.character.weapons.weaponInventory.equipAries()
}
F12::{
    g.character.weapons.weaponInventory.equipOdin()
}
LShift & F1::{
    Send "{F1}"
}
LShift & F2::{
    Send "{F2}"
}
LShift & F3::{
    Send "{F3}"
}
LShift & F4::{
    Send "{F4}"
}
LShift & F5::{
    Send "{F5}"
}
LShift & F6::{
    Send "{F6}"
}
LShift & F7::{
    Send "{F7}"
}
LShift & F8::{
    Send "{F8}"
}
LShift & F9::{
    Send "{F9}"
}
LShift & F10::{
    Send "{F1}"
}
LShift & F11::{
    Send "{F1}"
}
LShift & F12::{
    Send "{F1}"
}

RShift & F1::{
    g.character.weapons.weaponInventory.equipClassic()
}
RShift & F2::{
    g.character.weapons.weaponInventory.equipShorty()
}
RShift & F3::{
    g.character.weapons.weaponInventory.equipFrenzy()
}
RShift & F4::{
    g.character.weapons.weaponInventory.equipGhost()
}
RShift & F5::{
    g.character.weapons.weaponInventory.equipSheriff()
}
; RShift & F6::{
; }
; RShift & F7::{
; }
; RShift & F8::{
; }
; RShift & F9::{
; }
; RShift & F10::{
; }
; RShift & F11::{
; }
; RShift & F12::{
; }

; Numpad5::{
; }
; Numpad6::{

; }
; Numpad7::{

; }
; Numpad8::{

; }
; Numpad9::{

; }
RShift & Numpad4::{
    g.character.movements.leftJumpPeak()
}
RShift & Numpad5::{
    g.character.movements.rightJumpPeak()
}
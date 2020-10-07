#Warn All, Off 
#MaxHotkeysPerInterval 2000

#Include "Ability.ah2"
#Include "Action.ah2"
#Include "CharacterAbilities.ah2"
#Include "CharacterMovement.ah2"
#Include "CharacterState.ah2" 
#Include "CharacterWeaponInventory.ah2"
#Include "CharacterWeaponState.ah2"
#Include "Constants.ah2"
#Include "Game.ah2"
#Include "GameCharacter.ah2"
#Include "GameState.ah2"
#Include "JumpMovement.ah2"
#Include "Key.ah2"
#Include "Keys.ah2"
#Include "Movement.ah2"
#Include "Tests.ah2"
; #Include "TestsFunctions.ah2"
; #Include "TestsGeneric.ah2"
#Include "vc.ah2"
#Include "Weapon.ah2"
#Include "WeaponAction.ah2"
#Include "WeaponCustomActions.ah2"
; #Include "Weapons.ah2"

global isFullDebug := Falsea
global isThisDebug := True

timeInMilli() {
    millis := (A_hour*3600 + A_min*60 + A_sec)*1000 + A_msec
    Return millis
}

Now() {
    return timeInMilli()
}
NowDiff(time) {
    return Now() - time
}

global g := Game.new()

global hotKeysActive := True
toggleHotKeysState() {
    if(isFullDebug) {
        OutputDebug("toggleHotKeysState" . "`n")
    }
    hotKeysActive := !hotKeysActive
}
#HotIf (WinActive("VALORANT") && hotKeysActive)
SetKeyDelay(-1)
#Include "Hotkeys.ah2"
#HotIf

End:: {
    toggleHotKeysState()
}

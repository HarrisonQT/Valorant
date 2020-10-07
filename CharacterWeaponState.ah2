/*
    8. Character Weapon State
*/
Class CharacterWeaponState {
    __New(ByRef _character, ByRef _movements) {
        this.DebugOutput := False
        this.character := _character
        this.weaponInventory := CharacterWeaponInventory.new(_character,this)
        this.currentWeapon := this.weaponInventory.sidearm
        this.hasContinousLeftShoot := False
        this.isContinousLeftShooting := False
        this.hasContinousRightShoot := False
        this.isContinousRightShooting := False
        this.movements := _movements
        this.lastDisplay := Now()
        this.lastWeapon := this.currentWeapon
    }

    displayWeapons(overRide := False) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("displayWeapons " . "`n")
        }
        timeSinceLastDisplay := Now() - this.lastDisplay
        if(overRide || timeSinceLastDisplay > 1000 ||this.lastWeapon != this.currentWeapon ) {
            this.lastDisplay := Now()
            this.lastWeapon := this.currentWeapon
            ; OutputDebug("timeSinceLastDisplay " . timeSinceLastDisplay . "`n")
            OutputDebug("Weapon State -----" . "`n")
            ; OutputDebug(" - Inventory " . "`n")
            OutputDebug(" - Inventory (" . this.weaponInventory.getPrimary().name . " / " . this.weaponInventory.getSidearm().name . ")" . "`n")
            ; OutputDebug("`t " . this.weaponInventory.getPrimary().name . "`n")
            ; OutputDebug("`t " . this.weaponInventory.getSidearm().name . "`n")
            OutputDebug(" - Current " . "`n")
            OutputDebug("`t " . this.currentWeapon.name . "`n")
            ; OutputDebug("------------------------`n")
        }
    }
    activateContinousRightShoot() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("activateContinousRightShoot" . "`n")
        }
        this.hasContinousRightShoot := True
    }
    deactivateContinousRightShoot() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("deactivateContinousRightShoot" . "`n")
        }
        this.hasContinousRightShoot := False
    }
    toggleContinousRightShoot(){
        this.hasContinousRightShoot := !this.hasContinousRightShoot
    }
    activateContinousLeftShoot() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("activateContinousLeftShoot" . "`n")
        }
        this.hasContinousLeftShoot := True
    }
    deactivateContinousLeftShoot() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("deactivateContinousLeftShoot" . "`n")
        }
        this.hasContinousLeftShoot := False
    }
    toggleContinousLeftShoot(){
        this.hasContinousLeftShoot := !this.hasContinousLeftShoot
    }
    inspectWeaponIfContinous() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("inspectWeaponIfContinous" . "`n")
        }
        if(this.hasContinousLeftShoot) {
            this.movements.inspectWeapon.press()
        }
    }
    setCurrentWeapon(ByRef weapon, contLShoot := False, contRShoot := False) { 
        if(weapon.hasContinousLeftShoot) {
            this.activateContinousLeftShoot()
        } else {
            this.deactivateContinousLeftShoot()
        }
        if(weapon.hasContinousRightShoot) {
            this.activateContinousRightShoot()
        } else {
            this.deactivateContinousRightShoot()
        }
        this.currentWeapon :=weapon
        this.character.displayGameState()
    }
    setCurrentWeaponAsSideArm() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("setCurrentWeaponAsSideArm" . "`n")
        }
        this.setCurrentWeapon(this.weaponInventory.getSidearm())
    }
    setCurrentWeaponAsPrimary() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("setCurrentWeaponAsPrimary" . "`n")
        }
        this.setCurrentWeapon(this.weaponInventory.getPrimary())
    }
    setCurrentWeaponAsKnife() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("setCurrentWeaponAsKnife" . "`n")
        }
        this.setCurrentWeapon(this.weaponInventory.getKnife())
    }
    setCurrentWeaponAsJettKnives() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("setCurrentWeaponAsKnife" . "`n")
        }
        this.setCurrentWeapon(this.weaponInventory.getJettKnifes())
    }
    isCurrentWeaponPrimary() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("isCurrentWeaponPrimary" . "`n")
        }
        return this.currentWeapon == this.weaponInventory.getPrimary()
    }
    isCurrentWeaponSidearm() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("isCurrentWeaponSidearm" . "`n")
        }
        return this.currentWeapon == this.weaponInventory.getSidearm()
    }
    isCurrentWeaponKnife() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("isCurrentWeaponKnife" . "`n")
        }
        return this.currentWeapon == this.weaponInventory.getKnife()
    }
    decrementCurrentWeapon() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("decrementCurrentWeapon" . "`n")
        }
        if(this.isCurrentWeaponPrimary()) {
            this.setCurrentWeaponAsSideArm()
        } else if (this.isCurrentWeaponSidearm()) {
            this.setCurrentWeaponAsKnife()
        } else {
            this.setCurrentWeaponAsKnife()
        }
    }
    incrementCurrentWeapon() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("incrementCurrentWeapon" . "`n")
        }
        if(this.isCurrentWeaponKnife()) {
            this.setCurrentWeaponAsSideArm()
        } else if (this.isCurrentWeaponSidearm()) {
            this.setCurrentWeaponAsPrimary()
        } else {
            this.setCurrentWeaponAsPrimary()
        }
    }
    altShot(ByRef character) {
        this.currentWeapon.altShot()
    }
}
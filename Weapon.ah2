#Include "Action.ah2"

/*
    4. Weapon
*/
Class Weapon {
    __New(ByRef kn) {
        this.DebugOutput := False
        this.action := Action.new(kn)
        switch kn.keyName {
        case "1":
            this.weaponType := "primary"
        case "2":
            this.weaponType := "sidearm"
        case "3":
            this.weaponType := "knife"
        default: 
            this.weaponType := "primary"
        }
        if (False) {
        doNothing := "0" "}"
    }
}
}

Class WeaponStats {
    __New(_fireRate, _runSpeed, _equipSpeed, _firstShotSpread, _reloadSpeed, _magazineSize, ByRef _damages) {
        this.fireRate := _fireRate
        this.runSpeed := _runSpeed
        this.equipSpeed := _equipSpeed
        this.firstShotSpread := _firstShotSpread
        this.reloadSpeed := _reloadSpeed
        this.magazineSize := _magazineSize
        this.damages := _damages
    }
}

Class WeaponsData {
}
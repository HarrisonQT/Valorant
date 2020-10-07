
/*
    7. Character Weapon Inventory
*/
Class CharacterWeaponInventory {
    __New(ByRef _character, ByRef _weaponState) {
        this.DebugOutput := False
        this.character := __character
        this.weaponState := _weaponState
        this.stinger := WeaponAction.new( _character, Keys.one, "stinger", 18, 20, False, False, 8.471) 
        this.spectre := WeaponAction.new( _character, Keys.one, "spectre", 13.33, 30, False, False, 12) 
        this.bucky := WeaponAction.new( _character, Keys.one, "bucky", 1.1, 5, False, False) 
        this.judge := WeaponAction.new( _character, Keys.one, "judge", 3.5, 7, False, False) 
        this.bulldog := WeaponAction.new( _character, Keys.one, "bulldog", 9.14, 24, False, False, 6.316) 
        this.guardian := WeaponAction.new( _character, Keys.one, "guardian", 5.25, 12, True, False, 4.275) 
        this.phantom := WeaponAction.new( _character, Keys.one, "phantom", 11 , 30 , False, False, 9.9) 
        this.vandal := WeaponAction.new( _character, Keys.one, "vandal", 9.75 , 25 , False, False, 8.775) 
        this.marshal := WeaponAction.new( _character, Keys.one, "marshal", 1.5, 5, False, False, 1.2) 
        this.operator := WeaponAction.new( _character, Keys.one, "operator", .75, 5, False, False) 
        this.aries := WeaponAction.new( _character, Keys.one, "aries", 10, 50, False, False, 13) 
        this.odin := WeaponAction.new( _character, Keys.one, "odin", 12, 50, False, False, 15.6) 
        this.sheriff := WeaponAction.new( _character, Keys.two, "sheriff", 4 , 6 , True, False) 
        this.ghost := WeaponAction.new( _character, Keys.two, "ghost", 6.75 , 15, True, False) 
        this.frenzy := WeaponAction.new( _character, Keys.two, "frenzy", 10 , 13, True, False) 
        this.shorty := WeaponAction.new( _character, Keys.two, "shorty", 3.33, 2, True, False) 
        this.classic := WeaponAction.new( _character, Keys.two, "classic", 6.75, 12, True, True, 2.22) 
        this.jettKnifes := WeaponAction.new( _character, Keys.g, "Jett Knives", 5, 5, True, True, 2.22) 
        this.primary := this.phantom
        this.sidearm := this.classic
        this.knife := WeaponAction.new( _character, Keys.three, "knife", 5, 100) 
    }
    getPrimary(){
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("getPrimary " . "`n")
        }
        return this.primary
    }
    getSidearm(){
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("getSidearm " . "`n")
        }
        return this.sidearm
    }
    getKnife(){
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("getKnife " . "`n")
        }
        return this.knife
    }

    getJettKnifes(){
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("getKnife " . "`n")
        }
        return this.jettKnifes
    }
    equipPrimary(ByRef weapon) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("equipPrimary " . "`n")
        }
        this.primary := weapon
        if(this.weaponState.isCurrentWeaponPrimary()) {
            this.weaponState.currentWeapon := weapon
        }
        this.currentPrimary := weapon
        this.weaponState.setCurrentWeaponAsPrimary()
        this.weaponState.displayWeapons()
    }
    equipSideArm(ByRef weapon) {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("equipSideArm " . "`n")
        }
        this.sideArm := weapon
        if(this.weaponState.isCurrentWeaponSidearm()) {
            this.weaponState.currentWeapon := weapon
        }
        this.currentSidearm := weapon
        this.weaponState.setCurrentWeaponAsSideArm()
        this.weaponState.displayWeapons()
    }
    equipStinger(){
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("equipStinger " . "`n")
        }
        this.equipPrimary(this.stinger)
    }
    equipSpectre(){
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("equipSpectre " . "`n")
        }
        this.equipPrimary(this.spectre)
    }
    equipJudge(){
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("equipJudge " . "`n")
        }
        this.equipPrimary(this.judge)
    }
    equipBucky(){
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("equipBucky " . "`n")
        }
        this.equipPrimary(this.bucky)
    }
    equipBulldog(){
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("equipBulldog " . "`n")
        }
        this.equipPrimary(this.bulldog)
    }
    equipGuardian(){
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("equipGuardian " . "`n")
        }
        this.equipPrimary(this.guardian)
    }
    equipPhantom(){
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("equipPhantom " . "`n")
        }
        this.equipPrimary(this.phantom)
    }
    equipVandal(){
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("equipVandal " . "`n")
        }
        this.equipPrimary(this.vandal)
    }
    equipMarshal(){
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("equipMarshal " . "`n")
        }
        this.equipPrimary(this.marshal)
    }
    equipOperator(){
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("equipOperator " . "`n")
        }
        this.equipPrimary(this.operator)
    }
    equipAries(){
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("equipAries " . "`n")
        }
        this.equipPrimary(this.aries)
    }
    equipOdin(){
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("equipOdin " . "`n")
        }
        this.equipPrimary(this.odin)
    }
    equipSheriff(){
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("equipSheriff " . "`n")
        }
        this.equipSideArm(this.sheriff)
    }
    equipGhost(){
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("equipGhost " . "`n")
        }
        this.equipSideArm(this.ghost)
    }
    equipFrenzy(){
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("equipFrenzy " . "`n")
        }
        this.equipSideArm(this.frenzy)
    }
    equipShorty(){
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("equipShorty " . "`n")
        }
        this.equipSideArm(this.shorty)
    }
    equipClassic(){
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("equipClassic " . "`n")
        }
        this.equipSideArm(this.classic)
    }
}
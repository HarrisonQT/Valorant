/*
    6. Character States
*/
Class CharacterState {
    static DebugOutput := False
    isJett := True
    isJumping := False
    isBHopping := False
    movementDirection := False
    isDead := False
    hasDash := True
    resetCharacterState() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("resetCharacterState " . "`n")
        }
        this.isJumping := 0
        this.isBHopping := False
        this.isDead := False
        this.hasDash := True
        this.movementDirection := False
    }
}
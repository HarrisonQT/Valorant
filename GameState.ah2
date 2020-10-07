/*
    12. Game States
*/

Class GameState {
    static DebugOutput := False
    isInRound := True
    isInGame := True
    __New(ByRef _character) {
        this.character := _character
    }
    toggleInRound() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("toggleInRound" . "`n")
        }
        this.isInRound := !this.isInRound
    }
    startRound() {
        if(isFullDebug || this.DebugOutput || funcDebug) {
            OutputDebug("startRound" . "`n")
        }
        isInRound := True
        this.cha
    }
}
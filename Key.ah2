/*
    1. Key  -------------------------------------------------------------------
*/

Class Key {
    __New(kn,tk) {
        this.DebugOutput := False
        this.name := Chr(123) . kn . Chr(125)
        this.keyName := kn 
        this.triggerKey := tk
        this.down := Chr(123) . kn . " down" . Chr(125)
        this.up := Chr(123) . kn . " up" . Chr(125)
    }
}

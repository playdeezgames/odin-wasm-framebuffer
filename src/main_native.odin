#+build !js
#+build !wasm32
#+build !wasm64p32
#+build !freestanding
package metaphor

import sdl "vendor:sdl2"

main :: proc() {
    buffer_init()
    defer buffer_destroy()
    event: sdl.Event = {}
    for sdl.WaitEvent(&event){
        if event.type == .QUIT {
            break
        }
        update()
        buffer_present()
    }
}
#+build !js
#+build !wasm32
#+build !wasm64p32
#+build !freestanding
package metaphor

import sdl "vendor:sdl2"

main :: proc() {
    buffer_init()
    defer buffer_destroy()
    sym_table := make(map[sdl.Keycode]string)
    sym_table[.UP] = UP_COMMAND
    sym_table[.DOWN] = DOWN_COMMAND
    sym_table[.LEFT] = LEFT_COMMAND
    sym_table[.RIGHT] = RIGHT_COMMAND
    sym_table[.SPACE] = GREEN_COMMAND
    sym_table[.ESCAPE] = RED_COMMAND
    sym_table[.RETURN] = BLUE_COMMAND
    sym_table[.TAB] = YELLOW_COMMAND
    event: sdl.Event = {}
    for sdl.WaitEvent(&event){
        if event.type == .QUIT {
            break
        } if event.type == .KEYDOWN {
            if command, ok := sym_table[event.key.keysym.sym]; ok {
                input_handle(command)
            }
        }
        update()
        buffer_present()
    }
}
#+build !js
#+build !wasm32
#+build !wasm64p32
#+build !freestanding
package metaphor

import sdl "vendor:sdl2"

window : ^sdl.Window = nil
renderer : ^sdl.Renderer = nil

buffer_init :: proc(){
    sdl.Init({.VIDEO})
    sdl.CreateWindowAndRenderer(SCREEN_WIDTH * 2, SCREEN_HEIGHT * 2, {.SHOWN}, &window, &renderer)
    sdl.RenderSetLogicalSize(renderer, SCREEN_WIDTH, SCREEN_HEIGHT)
}

buffer_present :: proc() {
    sdl.RenderPresent(renderer)
}

buffer_set_pixel :: proc(x,y:int, r,g,b,a:u8) {
    if x<0 || y<0 || x>SCREEN_WIDTH-1 || y>SCREEN_HEIGHT-1 {
        return
    }
    sdl.SetRenderDrawColor(renderer, r, g, b, a)
    rect: sdl.Rect = {x=i32(x),y=i32(y),w=1,h=1}
    sdl.RenderFillRect(renderer, &rect)
}

buffer_destroy :: proc() {
    if renderer != nil {
        sdl.DestroyRenderer(renderer)
        renderer = nil
    }
    if window != nil {
        sdl.DestroyWindow(window)
        window = nil
    }
    sdl.Quit()
}
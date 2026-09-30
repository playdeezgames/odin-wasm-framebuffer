#+build js, wasm32, wasm64p32
package metaphor

import "core:mem"

buffer : ^u8 

buffer_init :: proc() {
    data, _:= mem.alloc(SCREEN_WIDTH * SCREEN_HEIGHT * BYTES_PER_PIXEL)
    buffer = cast(^u8)data
    pixels := mem.slice_ptr(buffer, SCREEN_WIDTH * SCREEN_HEIGHT * BYTES_PER_PIXEL)
    buffer_fill_rect(0,0,SCREEN_WIDTH,SCREEN_HEIGHT,0,0,0,255)
}

buffer_set_pixel :: proc(x,y:int, r,g,b,a:u8) {
    if x<0 || y<0 || x>SCREEN_WIDTH-1 || y>SCREEN_HEIGHT-1 {
        return
    }
    pixels := mem.slice_ptr(buffer, SCREEN_WIDTH * SCREEN_HEIGHT * BYTES_PER_PIXEL)
    offset:= x * BYTES_PER_PIXEL + y * SCREEN_WIDTH * BYTES_PER_PIXEL
    pixels[offset] = r
    pixels[offset+1] = g
    pixels[offset+2] = b
    pixels[offset+3] = a
}

buffer_fill_rect :: proc(x,y,width,height:int, r,g,b,a:u8) {
    for h in x..<x+width {
        for v in y..<y+height {
            buffer_set_pixel(h,v,r,g,b,a)
        }
    }
}

buffer_present :: proc()
{
    js_frame(buffer, SCREEN_WIDTH, SCREEN_HEIGHT)
}

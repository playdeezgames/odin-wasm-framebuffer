package metaphor

import "core:mem"

WIDTH :: 320
HEIGHT :: 240
BPP :: 4

buffer : ^u8 

buffer_init :: proc() {
    data, _:= mem.alloc(WIDTH * HEIGHT * BPP)
    buffer = cast(^u8)data
    pixels := mem.slice_ptr(buffer, WIDTH * HEIGHT * BPP)
    for x in 0..<WIDTH {
        for y in 0..<HEIGHT {
            buffer_set_pixel(x,y,0,0,0,255)
        }
    }
}

buffer_set_pixel :: proc(x,y:int, r,g,b,a:u8) {
    if x<0 || y<0 || x>WIDTH-1 || y>HEIGHT-1 {
        return
    }
    pixels := mem.slice_ptr(buffer, WIDTH * HEIGHT * BPP)
    offset:= x * BPP + y * WIDTH * BPP
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
package metaphor

SCREEN_WIDTH :: 320
SCREEN_HEIGHT :: 240
BYTES_PER_PIXEL :: 4

buffer_draw_pattern :: proc(x,y:int, pattern:^[]string, r,g,b,a:u8) {
    v:=0
    for data in pattern {
        for c,h in data {
            if c=='#' {
                buffer_set_pixel(x+h,y+v,r,g,b,a)
            }
        }
        v+=1
    }
}

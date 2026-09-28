package metaphor

player_x:= 100
player_y:= 100

update :: proc() {
    buffer_fill_rect(player_x,player_y,10,10,255,255,255,255)
    js_frame(buffer, WIDTH, HEIGHT)
    buffer_fill_rect(player_x,player_y,10,10,0,0,0,255)
}


main :: proc() {
    buffer_init()
    update()
}
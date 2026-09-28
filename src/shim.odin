package metaphor

import "core:fmt"

@(export)
step :: proc(dt: f32) -> bool {
    if js_can_read() {
        buf: [256]byte
        command := read_input(buf[:])
        fmt.println(command)
        if command == "ArrowUp" {
            player_y -= 10
            update()
        }
    }
    return true
}

read_input :: proc(buf: []byte) -> string {
    n := int(js_read(raw_data(buf), i32(len(buf))))
    n = min(n, len(buf))
    return string(buf[:n])
}

foreign import "shim"

@(default_calling_convention="contextless")
foreign shim {
    js_frame :: proc(ptr:^u8, width, height: int) ---
    js_can_read :: proc() -> bool ---
    js_read :: proc(buf: [^]byte, cap: i32) -> i32 ---
}

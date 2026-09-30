#+build js, wasm32, wasm64p32
package metaphor

@(export)
step :: proc(dt: f32) -> bool {
    if js_can_read() {
        buf: [256]byte
        command := read_input(buf[:])
        if command == "ArrowUp" {
            input_handle(UP_COMMAND)
        } else if command == "ArrowDown" {
            input_handle(DOWN_COMMAND)
        } else if command == "ArrowLeft" {
            input_handle(LEFT_COMMAND)
        } else if command == "ArrowRight" {
            input_handle(RIGHT_COMMAND)
        } else if command == " " {
            input_handle(GREEN_COMMAND)
        } else if command == "Tab" {
            input_handle(RED_COMMAND)
        } else if command == "Enter" {
            input_handle(BLUE_COMMAND)
        } else if command == "Escape" {
            input_handle(YELLOW_COMMAND)
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

package metaphor

import "core:fmt"

UP_COMMAND :: "UP"
DOWN_COMMAND :: "DOWN"
LEFT_COMMAND :: "LEFT"
RIGHT_COMMAND :: "RIGHT"
GREEN_COMMAND :: "GREEN"
RED_COMMAND :: "RED"
BLUE_COMMAND :: "BLUE"
YELLOW_COMMAND :: "YELLOW"

input_handle :: proc(command:string) {
    fmt.println(command)
}
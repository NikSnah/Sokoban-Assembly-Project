.data
character:  .byte 0,0
box:        .byte 0,0
target:     .byte 0,0

.globl main
.text

main:
    # TODO: Before we deal with the LEDs, generate random locations for
    # the character, box, and target. static locations have been provided
    # for the (x,y) coordinates for each of these elements within the 8x8
    # grid. 
    # There is a rand function, but note that it isn't very good! You 
    # should at least make sure that none of the items are on top of each
    # other.
   
    # TODO: Now, light up the playing field. Add walls around the edges
    # and light up the character, box, and target with the colors you have
    # chosen. (Yes, you choose, and you should document your choice.)
    # Hint: the LEDs are an array, so you should be able to calculate 
    # offsets from the (0, 0) LED.

    # TODO: Enter a loop and wait for user input. Whenever user input is
    # received, update the grid with the new location of the player (and
    # if applicable, box and target). You will also need to restart the
    # game if the user requests it and indicate when the box is located
    # in the same position as the target.

    # TODO: That's the base game! Now, pick a pair of enhancements and
    # consider how to implement them.
 
exit:
    li a7, 10
    ecall
    
    
# --- HELPER FUNCTIONS ---
# Feel free to use (or modify) them however you see fit
     
# Takes in a number in a0, and returns a (sort of) (okay no really) random 
# number from 0 to this number (exclusive)
rand:
    mv t0, a0
    li a7, 30
    ecall
    remu a0, a0, t0
    jr ra
    
# Takes in an RGB color in a0, an x-coordinate in a1, and a y-coordinate
# in a2. Then it sets the led at (x, y) to the given color.
setLED:
    li t1, LED_MATRIX_0_WIDTH
    mul t0, a2, t1
    add t0, t0, a1
    li t1, 4
    mul t0, t0, t1
    li t1, LED_MATRIX_0_BASE
    add t0, t1, t0
    sw a0, (0)t0
    jr ra
    
# Polls the d-pad input until a button is pressed, then returns a number
# representing the button that was pressed in a0.
# The possible return values are:
# 0: UP
# 1: DOWN
# 2: LEFT
# 3: RIGHT
pollDpad:
    mv a0, zero
    li t1, 4
pollLoop:
    bge a0, t1, pollLoopEnd
    li t2, D_PAD_0_BASE
    slli t3, a0, 2
    add t2, t2, t3
    lw t3, (0)t2
    bnez t3, pollRelease
    addi a0, a0, 1
    j pollLoop
pollLoopEnd:
    j pollDpad
pollRelease:
    lw t3, (0)t2
    bnez t3, pollRelease
pollExit:
    jr ra

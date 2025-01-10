.data
LCG_m: .word 429496729 
LCG_a: .word 1664525
LCG_c: .word 1013904223

character:  .byte 0,0
box:        .byte 0,0
target:     .byte 0,0
stop:      .byte 3,0
orgin_character: .byte 0,0
orgin_box: .byte 0,0
question: .string "Do You Want to play again? enter 1 for yes, 0 for no"
restart_string: .string "To restart enter 1, to continue enter 0, to exit enter 2"
win: .string "You Won!!"
newline: .string "\n"
wall_hit: .string "You hit a wall"
gamemode: .string "What gamemode do you wanna play?"
game1: .string "Press 1 for Single Player."
game2: .string "Press 0 for Multi Player."
multi: .string "How many players?(must be bigger than 1)" 
player: .string "Player " 
turn: .string " turn!"
scored: .string " scored: "
steps: .string " steps!!"
score_board: .string "Game Done, here are the scores for round "




.globl main
.text

li s1, 1
li s11, 1
main:
   li s3, 0
   li s5, 0
   li s6, 0
   li s7, 0
   li s9, 0
   li s2, 0
   li s0, 0
   li s9, 0
    


        li a7, 4
	    la a0, gamemode
	    ecall

        li a7, 4
	    la a0, newline
	    ecall

        li a7, 4
	    la a0, game1
	    ecall

        li a7, 4
	    la a0, newline
	    ecall

        li a7, 4
	    la a0, game2
	    ecall

        li a7, 4
	    la a0, newline
	    ecall
        
        call readInt
        mv s9, a0

        li t0, 0
        li t1, 1 
        beq s9, t1, skip4
        beq s9, t0, multi_start
        beq zero, zero, main
         
        multi_start: 
        
        li a7, 4
	    la a0, multi
	    ecall

        li a7, 4
	    la a0, newline
	    ecall

        call readInt
        mv s9, a0
        
        li t0, 2
        bge s9, t0, go
        beq zero, zero, skip4
        go:
        mv s10, s9  
        
        skip4:
    
    
 # target black
 resetgrid:
    li s2, 8
    li s3, 0
    li s0, 0
    beq zero, zero, insideloop
    cleargrid: 
        addi s3, s3, 1 
        bge s3, s2, breakout
        
        li s0, 0
        insideloop: 
            li t0, 0x000000
            mv a0, t0
            mv a1, s3
            mv a2, s0
            jal setLED 
            
            addi s0, s0, 1 
            bge s0, s2, cleargrid
            
            j insideloop
            
        
    breakout:
        li s0, 0
        li s3, 0
        li s2, 0
        
    li t1,1
    beq s11, t1, gen_xy
    beq zero, zero, light_up
        
    # TODO: Before we deal with the LEDs, generate random locations for
    # the character, box, and target. static locations have been provided
    # for the (x,y) coordinates for each of these elements within the 8x8
    # grid. 
    # There is a rand function, but note that it isn't very good! You 
    # should at least make sure that none of the items are on top of each
    # other.
    
    #detect x and y
    gen_xy:
    li t3, 0
    
    
    XYGEN: 
        li a0, 6
        jal rand 
        mv t4, a0 
        
        LOOP1: 
            li a0, 4
            jal rand 
            mv t5, a0
            beq t4, t5, LOOP1
        
        LOOP2:  
            li a0, 6
            jal rand 
            mv t6, a0
            beq t4, t6, LOOP2
            beq t5, t6, LOOP2
        
        j continue 
        
    continue: 
    
    li t1, 0
    li t2, 1
    
    addi t4, t4, 1 
    addi t5, t5, 2 
    addi t6, t6, 1 
    
    beq t3, t1, x
    beq t3, t2, y 
    
    x:
       la a1, character
       sb t4, 0(a1)
       
       la a1, orgin_character
       sb t4, 0(a1)
       
       la a1, box
       sb t5, 0(a1)
       
       la a1, orgin_box
       sb t5, 0(a1)
       
       la a1, target
       sb t6, 0(a1)
       
       li t3, 1 
       j XYGEN
    y: 
       la a1, orgin_character
       sb t4, 1(a1)
       
       la a1, character
       sb t4, 1(a1)
       
       la a1, box
       sb t5, 1(a1)
       
       la a1, orgin_box
       sb t5, 1(a1)
       
       la a1, target
       sb t6, 1(a1)
         
    # TODO: Now, light up the playing field. Add walls around the edges
    # and light up the character, box, and target with the colors you have
    # chosen. (Yes, you choose, and you should document your choice.)
    # Hint: the LEDs are an array, so you should be able to calculate 
    # offsets from the (0, 0) LED.
    
    light_up: 
    #edge cordinates 
    li s6, 0
    li s7, 7
    #counter 
    li s8, 0
 
    wall:
        li t0, 0xFFFFFF
        mv a0, t0
        mv a1, s8
        mv a2, s6
        jal setLED
        
        li t0, 0xFFFFFF
        mv a0, t0
        mv a1, s8
        mv a2, s7
        jal setLED
        
        li t0, 0xFFFFFF
        mv a0, t0
        mv a1, s6
        mv a2, s8
        jal setLED
        
        li t0, 0xFFFFFF
        mv a0, t0
        mv a1, s7
        mv a2, s8
        jal setLED
        
        addi s8, s8, 1 
        li t1, 8
        bge s8, t1, endwall
        
        j wall 
    endwall:
    
    la a1, character
    lb t1, 0(a1)
    lb t2, 1(a1)
    
     li t0, 0x800080
     mv a0, t0
     mv a1, t1
     mv a2, t2
     jal setLED
     
     la a1, box
     lb t1, 0(a1)
     lb t2, 1(a1)
      
     li t0, 0x964B00
     mv a0, t0
     mv a1, t1
     mv a2, t2
     jal setLED

     la a1, target
     lb t1, 0(a1)
     lb t2, 1(a1)
     
     li t0, 0x00FF00
     mv a0, t0 
     mv a1, t1
     mv a2, t2
     jal setLED
 
     la a1, stop
     lb t1, 0(a1)
     lb t2, 1(a1)
    
     li t0, 0xFF0000
     mv a0, t0
     mv a1, t1
     mv a2, t2
     jal setLED
     
     #multiplayer set up     
     beq zero, s10, mainloop
 
     
     #Store box and player original xy
     
     go_over:
     li s8, 0
        
     li a7, 4
	  la a0, player
	  ecall

     li a7, 1
	  mv a0, s11
	  ecall

     li a7, 4
	  la a0, turn
	  ecall  

     li a7, 4
	  la a0, newline
	  ecall
     


    # TODO: Enter a loop and wait for user input. Whenever user input is received, update the grid with the new location of the player (and if applicable, box and target). You will also need to restart the
    # game if the user requests it and indicate when the box is located
    # in the same position as the target.
        
    mainloop:
        
    
        li s2, 0
        li s3, 0
        li s4, 0
        li s9, 0
        li s5, 0
        li s6, 0
        li s7, 0
    
        jal pollDpad
        
        
        mv s9, a0
        
        #player moving 
        
            la a1, character
            lb s2, 0(a1)
            lb s3, 1(a1)
               
            beq zero, s10, skip9
            addi s8, s8, 1
            skip9:
                
            li t0, 0
            beq s9, t0, up
            li t1, 1
            beq s9, t1, down
            li t2, 2
            beq s9, t2, left 
            li t3, 3
            beq s9, t3, right
        
            # change position
            up:
                li t0, 1
                sub s3, s3, t0
                beq zero, zero, check
            down:
                addi s3, s3, 1 
                beq zero, zero, check
            left:
                li t0, 1
                sub s2, s2, t0
                beq zero, zero, check
            right: 
                addi s2, s2, 1 
                beq zero, zero, check
            
            check:
            #check for exit door 
            li t0, 3
            li t1, 0 
            
            beq s2, t0, p3
            beq zero, zero, skip2 
            p3:
            beq s3, t1, restart
            
            skip2:
            #check for walls 
            li t0, 0 
            li t1, 7
            beq s2, t0, wall_error
            beq s2, t1, wall_error
            beq s3, t0, wall_error
            beq s3, t1, wall_error
            
            #check for box 
            la a1, box
            lb s4, 0(a1)
            lb s5, 1(a1)
            
            beq s2, s4, p1
            beq zero, zero, skip1
            p1:
            beq s3, s5, box_hit
            beq zero, zero, skip1
            
            box_hit:
                
            li t0, 0
            beq s9, t0, box_up 
            li t1, 1
            beq s9, t1, box_down
            li t2, 2
            beq s9, t2, box_left 
            li t3, 3
            beq s9, t3, box_right
            
             # change box position
            box_up:
                li t0, 1
                sub s5, s5, t0
                beq zero, zero, check_box
            box_down:
                addi s5, s5, 1 
                beq zero, zero, check_box
            box_left:
                li t0, 1
                sub s4, s4, t0
                beq zero, zero, check_box
            box_right: 
                addi s4, s4, 1 
                beq zero, zero, check_box
                
            check_box:
            #check for walls 
            li t0, 0 
            li t1, 7
            beq s4, t0, wall_error
            beq s4, t1, wall_error
            beq s5, t0, wall_error
            beq s5, t1, wall_error
            
            #check if box on target 
            la a2, target
            lb t1, 0(a2)
            lb t2, 1(a2) 
            
            beq t1, s4, p2
            beq zero, zero, skip1
            p2:
            beq t2, s5, winner 
            beq zero, zero, skip1
            
            winner: 
            li s7, 1         
        
            skip1:
            
            #delete old box point      
            la a1, box
            lb t1, 0(a1)
            lb t2, 1(a1)
            
            li t0, 0x000000 
            mv a0, t0
            mv a1, t1
            mv a2, t2
            jal setLED
            
            #delete old point      
            la a1, character
            lb t1, 0(a1)
            lb t2, 1(a1)
            
            li t0, 0x000000 
            mv a0, t0
            mv a1, t1
            mv a2, t2
            jal setLED
            
            #keep the target
            la a2, target
            lb t1, 0(a2)
            lb t2, 1(a2) 
            
            li t0, 0x00FF00
            mv a0, t0
            mv a1, t1
            mv a2, t2
            jal setLED
            
            #add new point
            li t0, 0x800080
            mv a0, t0
            mv a1, s2
            mv a2, s3
            jal setLED
            
            #add new box point
            li t0, 0x964B00
            mv a0, t0
            mv a1, s4
            mv a2, s5
            jal setLED
                        
            
            la a1, character
            sb s2, 0(a1)
            sb s3, 1(a1)
            
            la a1,box
            sb s4, 0(a1)
            sb s5, 1(a1)
            

            beq zero, zero, next
            
            
        wall_error: 
        li a7, 4
	    la a0, newline
	    ecall

        li a7, 4
	    la a0, wall_hit
	    ecall

        li a7, 4
	    la a0, newline
	    ecall

        beq zero, zero, next
        
        next: 
        
        li t1, 1
        beq t1, s7, player_won
        j mainloop
        
        player_won: 
        

        li a7, 4
	    la a0, win
	    ecall

        li a7, 4
	    la a0, newline
	    ecall
        
        beq zero, s10, skip10
        
       li a7, 4
	    la a0, player
	    ecall

        li a7, 1
	    mv a0, s11
	    ecall

        li a7, 4
	    la a0, scored 
	    ecall
        
        li a7, 1
	    mv a0, s8
	    ecall

       li a7, 4
	    la a0, steps
	    ecall
    
         li a7, 4
	    la a0, newline
	    ecall

        #store points 
        #put into stack
        addi sp, sp, -8 # move stack pointer to make space
        sw s8, 0(sp) # push a word onto the stack
        sw s11, 4(sp)
        
        #check if final player
        beq s11, s10, multi_final
           
        #update player 
        addi s11, s11, 1 
       
         
        #revert the player and box to original xy
        
        la a1, orgin_box
        lb t1, 0(a1)
        lb t2, 1(a1)
        
        la a1, box
        sb t1, 0(a1)
        sb t2, 1(a1)
        
        la a1, orgin_character
        lb t3, 0(a1)
        lb t4, 1(a1)
        
        la a1, character
        sb t3, 0(a1)
        sb t4, 1(a1)
        
        #Ask if the player wants to restart
        li a7, 4
	    la a0, restart_string
	    ecall

        li a7, 4
	    la a0, newline
	    ecall 

        call readInt
        mv s9, a0
            
        #reset the grid for the next player
        beq s9, zero, resetgrid
        
        li t0, 2
        beq s9, t0, exit 
        
        li t1, 1
        beq s9, t1, main
        
        beq zero, zero, player_won
       
       skip10:

        li a7, 4
	    la a0, question
	    ecall

        li a7, 4
	    la a0, newline
	    ecall
        
        call readInt
        mv s9, a0
        li t1, 1 
	    beq s9, t1, main
        li t0, 0
        beq s9, t0, exit
        beq zero, zero, player_won
        
        restart: 
        
        li a7, 4
	    la a0, newline
	    ecall

        li a7, 4
	    la a0, restart_string
	    ecall

        li a7, 4
	    la a0, newline
	    ecall
        
        call readInt
        mv s9, a0
        
        li t0, 2
        beq s9, t0, exit
        
        li t1, 1
        beq s9, t1, main
        
        li t2, 0
        beq s9, t2, next
        
        beq zero, zero, restart
        
        
     multi_final:
          li a7, 4
	    la a0, newline
	    ecall

        li a7, 4
	    la a0,  score_board
	    ecall

        li a7, 1
	    mv a0, s1
	    ecall

         li a7, 4
	    la a0, newline
	    ecall
        
        #return result scores
       # mv a0, s10
        #jal ra, bubble_sort
        
        li t0, 0
        
        for_loop: 
         li a7, 4
	    la a0,  player
	    ecall
        
        lw t5, 0(sp)
        addi sp, sp, 4
        lw t6, 0(sp)
        addi sp, sp, 4
        
      li a7, 1
	    mv a0, t6
	    ecall

        li a7, 4
	    la a0,  scored
	    ecall
        
        li a7, 1
	    mv a0, t5
	    ecall

         li a7, 4
	    la a0, newline
	    ecall 
        
        addi t0, t0, 1
        
        bge t0, s10, leave
        j for_loop
        leave:

        

                        
         #Ask if the player wants to restart
         skip11:
        li a7, 4
	    la a0, restart_string 
        ecall
        
        li a7, 4
	    la a0, newline
	    ecall 
        call readInt
        mv s9, a0
            
        #reset the grid for the next player
        
        beq s9, zero, set
        beq zero, zero, skip111
        set:
        li s11, 1
        addi s1, s1, 1
        beq zero, zero, main
        skip111:
        
        li t0, 2
        beq s9, t0, exit 
        
        li t1, 1
        beq s9, t1, set2
        beq zero, zero, skip112
        set2:
        li s11, 1
        li s1, 1 
        beq zero, zero, main
        skip112:
        beq zero, zero, skip11
       
        
      
           

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
    
    mv s3, a0
    
    li a7, 30
    ecall
   
   mv s2, a0 

    li s5, 1664525 # val for a
    li s4, 1013904223 #val for c
    
    mul s2, s2, s5 # t2 = a * X_n
    add s2, s2, s6  # t2 = a * X_n + c
    remu a0, s2, s3 # a0 = (a * X_n + c) % m
    
    li s2, 0
    li s3, 0 
     li s4, 0 
      li s5, 0 
    
    
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

     
readInt:
    addi sp, sp, -12
    li a0, 0
    mv a1, sp
    li a2, 12
    li a7, 63
    ecall
    li a1, 1
    add a2, sp, a0
    addi a2, a2, -2
    mv a0, zero
parse:
    blt a2, sp, parseEnd
    lb a7, 0(a2)
    addi a7, a7, -48
    li a3, 9
    bltu a3, a7, error
    mul a7, a7, a1
    add a0, a0, a7
    li a3, 10
    mul a1, a1, a3
    addi a2, a2, -1
    j parse
parseEnd:
    addi sp, sp, 12
    ret

error:
    li a7, 93
    li a0, 1
    ecall
    

        

# Bubble Sort function
bubble_sort:
    # a0 = number of players
    sort_loop:
        li t0, 0               # Reset swap flag for each pass
        li t1, 0              # Initialize index

        element_loop:
            lw t4, 0(sp)        # Load current score
            lw t2, 4(sp)
            lw t5, 8(sp)        # Load next score
            lw t3, 12(sp)
            

            # Compare current and next scores
            bge t3, t2, no_swap

            # Swap the scores
            sw t3, 0(sp)
            sw t5, 4(sp)
            sw t2, 8(sp) 
            sw t4, 12(sp)
            li t0, 1             # Set swap flag

            no_swap:
            addi t6, a0, -2 
            li t2, 2
            bge t6, t2, do
            beq t6, zero, skipper
            addi sp, sp, 4     # Move to the next pair of elements
            addi t1, t1, 1
            beq zero, zero, skipper
            do:
            addi sp, sp, 8       # Move to the next pair of elements
            addi t1, t1, 2
            skipper:

            # Continue loop if not at the end of the stack
            bne t1, a0, element_loop
          li t6, 4
          mul t6, a0, t6
          sub sp, sp, t6

        # Continue sorting if a swap occurred in the previous pass
        bnez t0, sort_loop

    ret
    
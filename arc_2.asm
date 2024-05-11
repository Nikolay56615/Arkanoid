asect 0
main: ext               # Declare labels
default_handler: ext    # as external

# Interrupt vector table (IVT)
# Place a vector to program start and
# map all internal exceptions to default_handler
dc main, 0              # Startup/Reset vector
dc default_handler, 0   # Unaligned SP
dc default_handler, 0   # Unaligned PC
dc default_handler, 0   # Invalid instruction
dc default_handler, 0   # Double fault
align 0x80              # Reserve space for the rest 
                        # of IVT

# Exception handlers section
rsect exc_handlers

# This handler halts processor
default_handler>
    halt

# Main program section
rsect main

main>
#we use:
#r0 -  x-coordinate
#r1 -  x-velocity
#r2 -  y-coordinate
#r3 -  y-velocity
#r4,r5,r6 - for temporary calculations
ei
ldi r0,128 #x-coordinate
ldi r1,0xa000 #random x-velocity
ldb r1,r1
ldi r2,224 #y-coordinate
ldi r3,0xa001 #random y-velocity
ldb r3,r3
neg r3
while
    ldi r6,248  #comparing y-coordinate
    cmp r2,r6
stays lt
    ldi r5,0xa002
    ldb r5,r5
    if
        cmp r5,1   #checking for reset
    is eq
        ldi r6,0xcccc
        ldi r5,0
        st r6,r5
        jsr restart # if reset signal is 1, jump to restart subroutine
    fi
    ldi r6,0xcccc
    ld r6,r6
    if
        cmp r6,24   #checking for new levels
    is eq,and
        ldi r5,0xb001
        ldb r5,r5       
        cmp r5,0
    is eq
    then
        jsr restart # if level has ended, jump to restart subroutine
    fi

    if
        ldi r5,48
        cmp r6,r5
    is eq,and
        ldi r5,0xb002
        ldb r5,r5
        cmp r5,0
    is eq
    then
        jsr restart
    fi

    if
        ldi r5,72
        cmp r6,r5 #end of game
    is eq
        halt
    fi
    add r1,r0,r4 #we use r4 register to pre-calculate x-coordinate for correct display of the ball
    #checking wall collisions by x-coordinate
    if 
        ldi r6, 255
        cmp r4,r6
    is gt
        neg r1
        add r1,r4,r4
        ldi r6,0xa000 # loading random Vx
        ldb r6,r6
        if
            cmp r1,0
        is lt
            neg r6
            move r6,r1
        else
            move r6,r1
        fi
    fi
    if
        cmp r4,0
    is lt
        neg r1
        add r1,r4,r4
        ldi r6,0xa000
        ldb r6,r6
        if
            cmp r1,0
        is lt
            neg r6
            move r6,r1
        else
            move r6,r1
        fi
    fi
    move r4,r0 #moving value to actual x-coordinate register

    
    ###checking block collision sideways section
    if
        ldi r6,88
        cmp r2,r6 #checking for sideways collisions for every row
    is ge, and
        ldi r6,95
        cmp r2,r6
    is le
    then

        ldi r5, bricks11 #loading adress of necessary array
        move r0,r4 #copying x-coordinate
        shr r4 #taking 5 most significant bits from 8-bit value of x-coordinate
        shr r4
        shr r4
        add r5,r4,r5 #adding x-coordinate to the adress of array
        add r5,r4,r5
        push r1
        ld r5,r1
        if
            cmp r1, 1 #checking whether a collision occured
        is eq # we need to know if this left or right pixel
            push r5
            ldi r6,0xcccc #updating the score, which is stored at 0xcccc adress
            ld r6,r5
            inc r5
            stb r6,r5
            pop r5
            add r5,2    # if we increase adress by 1 x-coordinate, and value by that adress equals 1
                        # we are adding 2 to r5 because we are working with 16-bit values
                        #it is left pixel, else it is right pixel

            ld r5,r1
            if
                cmp r1,1
            is eq # left pixel
                dec r1      # updating values in current row
                sub r5,2
                st r5,r1
                add r5,2
                st r5,r1
                add r5,2
                st r5,r1
                ldi r5, bricks10 # updating values in adjacent row
                add r5,r4,r5
                add r5,r4,r5
                st r5,r1
                add r5,2
                st r5,r1
                add r5,2
                st r5,r1
                pop r1
                neg r1
                ldi r6,0xa000 #loading random Vx
                ldb r6,r6
                if
                    cmp r1,0
                is lt
                    neg r6
                    move r6,r1
                else
                    move r6,r1
                fi
            else #right pixel

                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                ldi r5, bricks10
                add r5,r4,r5
                add r5,r4,r5
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                pop r1
                neg r1
                ldi r6,0xa000
                ldb r6,r6
                if
                    cmp r1,0
                is lt
                    neg r6
                    move r6,r1
                else
                    move r6,r1
                fi
            fi
        else
            pop r1
        fi
    fi
    # we apply the algorithm above for the remaining rows

    if
        ldi r6,80
        cmp r2,r6 
    is ge, and
        ldi r6,87
        cmp r2,r6
    is le
    then

        ldi r5, bricks10
        move r0,r4
        shr r4
        shr r4
        shr r4
        add r5,r4,r5
        add r5,r4,r5
        push r1
        ld r5,r1
        if
            cmp r1, 1
        is eq # we need to know if this left or right pixel
            push r5
            ldi r6,0xcccc
            ld r6,r5
            inc r5
            stb r6,r5
            pop r5
            add r5,2
            ld r5,r1
            if
                cmp r1,1
            is eq # left pixel
                dec r1
                sub r5,2
                st r5,r1
                add r5,2
                st r5,r1
                add r5,2
                st r5,r1
                ldi r5, bricks11
                add r5,r4,r5
                add r5,r4,r5
                st r5,r1
                add r5,2
                st r5,r1
                add r5,2
                st r5,r1
                pop r1
                neg r1
                ldi r6,0xa000
                ldb r6,r6
                if
                    cmp r1,0
                is lt
                    neg r6
                    move r6,r1
                else
                    move r6,r1
                fi

            else #right pixel

                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                ldi r5, bricks11
                add r5,r4,r5
                add r5,r4,r5
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                pop r1
                neg r1
                ldi r6,0xa000
                ldb r6,r6
                if
                    cmp r1,0
                is lt
                    neg r6
                    move r6,r1
                else
                    move r6,r1
                fi
            fi
        else
            pop r1
        fi
    fi






    if
        ldi r6,64
        cmp r2,r6 
    is ge, and
        ldi r6,71
        cmp r2,r6
    is le
    then

        ldi r5, bricks8
        move r0,r4
        shr r4
        shr r4
        shr r4
        add r5,r4,r5
        add r5,r4,r5
        push r1
        ld r5,r1
        if
            cmp r1, 1
        is eq # we need to know if this left or right pixel
            push r5
            ldi r6,0xcccc
            ld r6,r5
            inc r5
            stb r6,r5
            pop r5
            add r5,2
            ld r5,r1
            if
                cmp r1,1
            is eq # left pixel
                dec r1
                sub r5,2
                st r5,r1
                add r5,2
                st r5,r1
                add r5,2
                st r5,r1
                ldi r5, bricks7
                add r5,r4,r5
                add r5,r4,r5
                st r5,r1
                add r5,2
                st r5,r1
                add r5,2
                st r5,r1
                pop r1
                neg r1
                ldi r6,0xa000
                ldb r6,r6
                if
                    cmp r1,0
                is lt
                    neg r6
                    move r6,r1
                else
                    move r6,r1
                fi
            else #right pixel

                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                ldi r5, bricks7
                add r5,r4,r5
                add r5,r4,r5
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                pop r1
                neg r1
                ldi r6,0xa000
                ldb r6,r6
                if
                    cmp r1,0
                is lt
                    neg r6
                    move r6,r1
                else
                    move r6,r1
                fi
            fi
        else
            pop r1
        fi
    fi

    if
        ldi r6,56
        cmp r2,r6 
    is ge, and
        ldi r6,63
        cmp r2,r6
    is le
    then

        ldi r5, bricks7
        move r0,r4
        shr r4
        shr r4
        shr r4
        add r5,r4,r5
        add r5,r4,r5
        push r1
        ld r5,r1
        if
            cmp r1, 1
        is eq # we need to know if this left or right pixel
            push r5
            ldi r6,0xcccc
            ld r6,r5
            inc r5
            stb r6,r5
            pop r5
            add r5,2
            ld r5,r1
            if
                cmp r1,1
            is eq # left pixel
                dec r1
                sub r5,2
                st r5,r1
                add r5,2
                st r5,r1
                add r5,2
                st r5,r1
                ldi r5, bricks8
                add r5,r4,r5
                add r5,r4,r5
                st r5,r1
                add r5,2
                st r5,r1
                add r5,2
                st r5,r1
                pop r1
                neg r1
                ldi r6,0xa000
                ldb r6,r6
                if
                    cmp r1,0
                is lt
                    neg r6
                    move r6,r1
                else
                    move r6,r1
                fi

            else #right pixel

                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                ldi r5, bricks8
                add r5,r4,r5
                add r5,r4,r5
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                pop r1
                neg r1
                ldi r6,0xa000
                ldb r6,r6
                if
                    cmp r1,0
                is lt
                    neg r6
                    move r6,r1
                else
                    move r6,r1
                fi
            fi
        else
            pop r1
        fi
    fi


    if
        ldi r6,40
        cmp r2,r6 
    is ge, and
        ldi r6,47
        cmp r2,r6
    is le
    then

        ldi r5, bricks5
        move r0,r4
        shr r4
        shr r4
        shr r4
        add r5,r4,r5
        add r5,r4,r5
        push r1
        ld r5,r1
        if
            cmp r1, 1
        is eq # we need to know if this left or right pixel
            push r5
            ldi r6,0xcccc
            ld r6,r5
            inc r5
            stb r6,r5
            pop r5
            add r5,2
            ld r5,r1
            if
                cmp r1,1
            is eq # left pixel
                dec r1
                sub r5,2
                st r5,r1
                add r5,2
                st r5,r1
                add r5,2
                st r5,r1
                ldi r5, bricks4
                add r5,r4,r5
                add r5,r4,r5
                st r5,r1
                add r5,2
                st r5,r1
                add r5,2
                st r5,r1
                pop r1
                neg r1
                ldi r6,0xa000
                ldb r6,r6
                if
                    cmp r1,0
                is lt
                    neg r6
                    move r6,r1
                else
                    move r6,r1
                fi

            else #right pixel

                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                ldi r5, bricks4
                add r5,r4,r5
                add r5,r4,r5
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                pop r1
                neg r1
                ldi r6,0xa000
                ldb r6,r6
                if
                    cmp r1,0
                is lt
                    neg r6
                    move r6,r1
                else
                    move r6,r1
                fi
            fi
        else
            pop r1
        fi
    fi

    if
        ldi r6,32
        cmp r2,r6 
    is ge, and
        ldi r6,39
        cmp r2,r6
    is le
    then

        ldi r5, bricks4
        move r0,r4
        shr r4
        shr r4
        shr r4
        add r5,r4,r5
        add r5,r4,r5
        push r1
        ld r5,r1
        if
            cmp r1, 1
        is eq # we need to know if this left or right pixel
            push r5
            ldi r6,0xcccc
            ld r6,r5
            inc r5
            stb r6,r5
            pop r5
            add r5,2
            ld r5,r1
            if
                cmp r1,1
            is eq # left pixel
                dec r1
                sub r5,2
                st r5,r1
                add r5,2
                st r5,r1
                add r5,2
                st r5,r1
                ldi r5, bricks5
                add r5,r4,r5
                add r5,r4,r5
                st r5,r1
                add r5,2
                st r5,r1
                add r5,2
                st r5,r1
                pop r1
                neg r1
                ldi r6,0xa000
                ldb r6,r6
                if
                    cmp r1,0
                is lt
                    neg r6
                    move r6,r1
                else
                    move r6,r1
                fi

            else #right pixel

                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                ldi r5, bricks5
                add r5,r4,r5
                add r5,r4,r5
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                pop r1
                neg r1
                ldi r6,0xa000
                ldb r6,r6
                if
                    cmp r1,0
                is lt
                    neg r6
                    move r6,r1
                else
                    move r6,r1
                fi
            fi
        else
            pop r1
        fi
    fi


    

    ###checking block collision sideways section ended--------------------------------------------------------------------

    ### checking collisions with upper wall
    add r2,r3,r4 #we use r4 register to pre-calculate y-coordinate for correct display of the ball
    if
        cmp r4,0
    is lt
        neg r3
        add r3,r4
        ldi r6,0xa001 #loading random Vy
        ldb r6,r6
        if
            cmp r3,0
        is lt
            neg r6
            move r6,r3
        else
            move r6,r3
        fi
    fi
    move r4,r2 #moving value to actual y-coordinate register

    if
        ldi r6,232  #checking collisions with a bat
        cmp r2,r6
    is ge, and
        ldi r6,239
        cmp r2,r6
    is le
    then
        ldi r5,0xbeef
        ld r5,r4 #now it has coordinate of bat
        move r0,r6
        shr r6
        shr r6
        shr r6 #taking 5 most significant bits of 8-bit x-coordinate
        if
            cmp r6,r4   #checking whether a collision occurred with right pixel of the bat
        is eq
            neg r3  # if ball hits edge pixels of bat, vx and vy velocities are being negated, 
                    # if ball hits central pixel - only vy
            neg r1
            ldi r6,0xa001 #loading random Vy
            ldb r6,r6
            if
                cmp r3,0
            is lt
                neg r6
                move r6,r3
            else
                move r6,r3
            fi
            
        else
            dec r4 #checking whether a collision occurred with middle pixel of the bat
            if
                cmp r6,r4
            is eq
                neg r3
                ldi r6,0xa001   #loading random Vy
                ldb r6,r6
                if
                    cmp r3,0
                is lt
                    neg r6
                    move r6,r3
                else
                    move r6,r3
                fi
                
            else
                dec r4 #checking whether a collision occurred with left pixel of the bat
                if
                    cmp r6,r4
                is eq
                    neg r3
                    neg r1
                    ldi r6,0xa001   #loading random Vy
                    ldb r6,r6
                    if
                        cmp r3,0
                    is lt
                        neg r6
                        move r6,r3
                    else
                        move r6,r3
                    fi
                    
                else

                fi
            fi
        fi
    fi



    ### checking collisions with blocks  - above or below -------------------------------------------------------
    #the algorithm is the same as in the case of the x coordinate, but we have additional check for middle pixel of block
    if
        ldi r6,88
        cmp r2,r6
    is ge, and
        ldi r6,95
        cmp r2,r6
    is le
    then
        move r0,r4
        shr r4
        shr r4
        shr r4
        ldi r5, bricks11
        add r5,r4,r5
        add r5,r4,r5
        push r1
        ld r5,r1
        if
            cmp r1,1 #checking for collision
        is eq
            push r5
            ldi r6,0xcccc #updating score
            ld r6,r5
            inc r5
            stb r6,r5
            pop r5
            add r5,2 #moving one pixel forward, if it is zero, it means that ball hit the right pixel
            ld r5,r1
            if 
                cmp r1,1
            is eq
                sub r5,2    #moving back two pixels, if it is zero - it means that ball hit the left pixel
                            # else - middle pixel
                sub r5,2
                ld r5,r1
                if
                    cmp r1,1
                is eq #check for middle pixel
                    dec r1  #updating values in current row
                    st r5,r1
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    ldi r5,bricks10 #updating values in adjacent row
                    add r5,r4,r5
                    add r5,r4,r5
                    st r5,r1
                    add r5,2
                    st r5,r1
                    sub r5,2
                    sub r5,2
                    st r5,r1
                    pop r1
                    neg r3
                    ldi r6,0xa001
                    ldb r6,r6
                    if
                        cmp r3,0
                    is lt
                        neg r6
                        move r6,r3
                    else
                        move r6,r3
                    fi
                else #left pixel 
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    ldi r5,bricks10
                    add r5,r4,r5
                    add r5,r4,r5
                    st r5,r1
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    pop r1
                    neg r3
                    ldi r6,0xa001
                    ldb r6,r6
                    if
                        cmp r3,0
                    is lt
                        neg r6
                        move r6,r3
                    else
                        move r6,r3
                    fi
                fi

            else #right pixel 
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                ldi r5,bricks10
                add r5,r4,r5
                add r5,r4,r5
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                pop r1
                neg r3
                ldi r6,0xa001
                ldb r6,r6
                if
                    cmp r3,0
                is lt
                    neg r6
                    move r6,r3
                else
                    move r6,r3
                fi
               
            fi
        else
            pop r1
        fi
    fi
    # we apply the algorithm above for the remaining rows
    if
        ldi r6,80
        cmp r2,r6
    is ge, and
        ldi r6,87
        cmp r2,r6
    is le
    then
        move r0,r4
        shr r4
        shr r4
        shr r4
        
        ldi r5, bricks10
        add r5,r4,r5
        add r5,r4,r5
        push r1
        ld r5,r1
        if
            cmp r1,1
        is eq
            push r5
            ldi r6,0xcccc
            ld r6,r5
            inc r5
            stb r6,r5
            pop r5
            add r5,2
            ld r5,r1
            if 
                cmp r1,1
            is eq
                sub r5,2
                sub r5,2
                ld r5,r1
                if
                    cmp r1,1
                is eq #check for middle pixel 
                    dec r1
                    st r5,r1
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    ldi r5,bricks11
                    add r5,r4,r5
                    add r5,r4,r5
                    st r5,r1
                    add r5,2
                    st r5,r1
                    sub r5,2
                    sub r5,2
                    st r5,r1
                    pop r1
                    neg r3
                    ldi r6,0xa001
                    ldb r6,r6
                    if
                        cmp r3,0
                    is lt
                        neg r6
                        move r6,r3
                    else
                        move r6,r3
                    fi

                else #lwft pixel
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    ldi r5,bricks11
                    add r5,r4,r5
                    add r5,r4,r5
                    st r5,r1
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    pop r1
                    neg r3
                    ldi r6,0xa001
                    ldb r6,r6
                    if
                        cmp r3,0
                    is lt
                        neg r6
                        move r6,r3
                    else
                        move r6,r3
                    fi

                fi

            else #right pixel 
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                ldi r5,bricks11
                add r5,r4,r5
                add r5,r4,r5
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                pop r1
                neg r3
                ldi r6,0xa001
                ldb r6,r6
                if
                    cmp r3,0
                is lt
                    neg r6
                    move r6,r3
                else
                    move r6,r3
                fi
            fi
        else
            pop r1
        fi
    fi
    
    
    
    
    if
        ldi r6,64
        cmp r2,r6
    is ge, and
        ldi r6,71
        cmp r2,r6
    is le
    then
        move r0,r4
        shr r4
        shr r4
        shr r4
        ldi r5, bricks8
        add r5,r4,r5
        add r5,r4,r5
        push r1
        ld r5,r1
        if
            cmp r1,1
        is eq
            push r5
            ldi r6,0xcccc
            ld r6,r5
            inc r5
            stb r6,r5
            pop r5
            add r5,2
            ld r5,r1
            if 
                cmp r1,1
            is eq
                sub r5,2
                sub r5,2
                ld r5,r1
                if
                    cmp r1,1
                is eq #check for middle pixel 
                    dec r1
                    st r5,r1
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    ldi r5,bricks7
                    add r5,r4,r5
                    add r5,r4,r5
                    st r5,r1
                    add r5,2
                    st r5,r1
                    sub r5,2
                    sub r5,2
                    st r5,r1
                    pop r1
                    neg r3
                    ldi r6,0xa001
                    ldb r6,r6
                    if
                        cmp r3,0
                    is lt
                        neg r6
                        move r6,r3
                    else
                        move r6,r3
                    fi
                else #left pixel
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    ldi r5,bricks7
                    add r5,r4,r5
                    add r5,r4,r5
                    st r5,r1
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    pop r1
                    neg r3
                    ldi r6,0xa001
                    ldb r6,r6
                    if
                        cmp r3,0
                    is lt
                        neg r6
                        move r6,r3
                    else
                        move r6,r3
                    fi
                fi

            else #right pixel
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                ldi r5,bricks7
                add r5,r4,r5
                add r5,r4,r5
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                pop r1
                neg r3
                ldi r6,0xa001
                ldb r6,r6
                if
                    cmp r3,0
                is lt
                    neg r6
                    move r6,r3
                else
                    move r6,r3
                fi
            fi
        else
            pop r1
        fi
    fi




    if
        ldi r6,56
        cmp r2,r6
    is ge, and
        ldi r6,63
        cmp r2,r6
    is le
    then
        move r0,r4
        shr r4
        shr r4
        shr r4
        ldi r5, bricks7
        add r5,r4,r5
        add r5,r4,r5
        push r1
        ld r5,r1
        if
            cmp r1,1
        is eq
            push r5
            ldi r6,0xcccc
            ld r6,r5
            inc r5
            stb r6,r5
            pop r5
            add r5,2
            ld r5,r1
            if 
                cmp r1,1
            is eq
                sub r5,2
                sub r5,2
                ld r5,r1
                if
                    cmp r1,1
                is eq #check for middle pixel 
                    dec r1
                    st r5,r1
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    ldi r5,bricks8
                    add r5,r4,r5
                    add r5,r4,r5
                    st r5,r1
                    add r5,2
                    st r5,r1
                    sub r5,2
                    sub r5,2
                    st r5,r1
                    pop r1
                    neg r3
                    ldi r6,0xa001
                    ldb r6,r6
                    if
                        cmp r3,0
                    is lt
                        neg r6
                        move r6,r3
                    else
                        move r6,r3
                    fi

                else #left pixel 
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    ldi r5,bricks8
                    add r5,r4,r5
                    add r5,r4,r5
                    st r5,r1
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    pop r1
                    neg r3
                    ldi r6,0xa001
                    ldb r6,r6
                    if
                        cmp r3,0
                    is lt
                        neg r6
                        move r6,r3
                    else
                        move r6,r3
                    fi

                fi

            else #right pixel 
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                ldi r5,bricks8
                add r5,r4,r5
                add r5,r4,r5
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                pop r1
                neg r3
                ldi r6,0xa001
                ldb r6,r6
                if
                    cmp r3,0
                is lt
                    neg r6
                    move r6,r3
                else
                    move r6,r3
                fi
            fi
        else
            pop r1
        fi
    fi

    if
        ldi r6,40
        cmp r2,r6
    is ge, and
        ldi r6,47
        cmp r2,r6
    is le
    then
        move r0,r4
        shr r4
        shr r4
        shr r4
        ldi r5, bricks5
        add r5,r4,r5
        add r5,r4,r5
        push r1
        ld r5,r1
        if
            cmp r1,1
        is eq
            push r5
            ldi r6,0xcccc
            ld r6,r5
            inc r5
            stb r6,r5
            pop r5
            add r5,2
            ld r5,r1
            if 
                cmp r1,1
            is eq
                sub r5,2
                sub r5,2
                ld r5,r1
                if
                    cmp r1,1
                is eq #check for middle pixel 
                    dec r1
                    st r5,r1
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    ldi r5,bricks4
                    add r5,r4,r5
                    add r5,r4,r5
                    st r5,r1
                    add r5,2
                    st r5,r1
                    sub r5,2
                    sub r5,2
                    st r5,r1
                    pop r1
                    neg r3
                    ldi r6,0xa001
                    ldb r6,r6
                    if
                        cmp r3,0
                    is lt
                        neg r6
                        move r6,r3
                    else
                        move r6,r3
                    fi

                else #left pixel
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    ldi r5,bricks4
                    add r5,r4,r5
                    add r5,r4,r5
                    st r5,r1
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    pop r1
                    neg r3
                    ldi r6,0xa001
                    ldb r6,r6
                    if
                        cmp r3,0
                    is lt
                        neg r6
                        move r6,r3
                    else
                        move r6,r3
                    fi

                fi

            else #right pixel 
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                ldi r5,bricks4
                add r5,r4,r5
                add r5,r4,r5
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                pop r1
                neg r3
                ldi r6,0xa001
                ldb r6,r6
                if
                    cmp r3,0
                is lt
                    neg r6
                    move r6,r3
                else
                    move r6,r3
                fi
            fi
        else
            pop r1
        fi
    fi

    if
        ldi r6,32
        cmp r2,r6
    is ge, and
        ldi r6,39
        cmp r2,r6
    is le
    then
        move r0,r4
        shr r4
        shr r4
        shr r4
        ldi r5, bricks4
        add r5,r4,r5
        add r5,r4,r5
        push r1
        ld r5,r1
        if
            cmp r1,1
        is eq
            push r5
            ldi r6,0xcccc
            ld r6,r5
            inc r5
            stb r6,r5
            pop r5
            add r5,2
            ld r5,r1
            if 
                cmp r1,1
            is eq
                sub r5,2
                sub r5,2
                ld r5,r1
                if
                    cmp r1,1
                is eq #check for middle pixel 
                    dec r1
                    st r5,r1
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    ldi r5,bricks5
                    add r5,r4,r5
                    add r5,r4,r5
                    st r5,r1
                    add r5,2
                    st r5,r1
                    sub r5,2
                    sub r5,2
                    st r5,r1
                    pop r1
                    neg r3
                    ldi r6,0xa001
                    ldb r6,r6
                    if
                        cmp r3,0
                    is lt
                        neg r6
                        move r6,r3
                    else
                        move r6,r3
                    fi
                else #left pixel 
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    ldi r5,bricks5
                    add r5,r4,r5
                    add r5,r4,r5
                    st r5,r1
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    pop r1
                    neg r3
                    ldi r6,0xa001
                    ldb r6,r6
                    if
                        cmp r3,0
                    is lt
                        neg r6
                        move r6,r3
                    else
                        move r6,r3
                    fi

                fi

            else #right pixel
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                ldi r5,bricks5
                add r5,r4,r5
                add r5,r4,r5
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                pop r1
                neg r3
                ldi r6,0xa001
                ldb r6,r6
                if
                    cmp r3,0
                is lt
                    neg r6
                    move r6,r3
                else
                    move r6,r3
                fi

            fi
        else
            pop r1
        fi
    fi
   
wend
ldi r6,2
while
    cmp r6,2 #starting infinite loop
stays eq
    ldi r5,0xa002
    ldb r5,r5
    if
        cmp r5,1
    is eq
        ldi r6,0xcccc # if reset signal equals 1 - jump to restart subroutine
        ldi r5,0
        st r6,r5
        jsr restart
    fi
wend
halt

restart: #subroutine that called if reset or level ends
    ldi r6,0xcccc
    ld r6,r6
    if
        ldi r5,24
        cmp r6,r5
    is eq
        ldi r5,0xb001 #setting the flag, that means that restart procedure happened to this score value
        ld r5,r4
        inc r4
        stb r5,r4
    fi
    if
        ldi r5,48
        cmp r6,r5
    is eq
        ldi r5,0xb002
        ld r5,r4
        inc r4
        stb r5,r4
    fi
    if
        ldi r5,72
        cmp r6,r5 #end of game
    is eq
        halt
    fi

    ldi r6,0
    ldi r5,bricks4
    ldi r4, bricks5 #rewriting the arrays of blocks
    while
        cmp r6,8
    stays lt
        ldi r3,0
        stb r5,r3
        stb r4,r3
        ldi r3,1
        add r5,2
        add r4,2
        stb r5,r3
        stb r4,r3
        add r5,2
        add r4,2
        stb r5,r3
        stb r4,r3
        add r5,2
        add r4,2
        stb r5,r3
        stb r4,r3
        add r5,2
        add r4,2
        inc r6
    wend

    ldi r6,0
    ldi r5,bricks7
    ldi r4, bricks8
    while
        cmp r6,8
    stays lt
        ldi r3,0
        stb r5,r3
        stb r4,r3
        ldi r3,1
        add r5,2
        add r4,2
        stb r5,r3
        stb r4,r3
        add r5,2
        add r4,2
        stb r5,r3
        stb r4,r3
        add r5,2
        add r4,2
        stb r5,r3
        stb r4,r3
        add r5,2
        add r4,2
        inc r6
    wend
  
    ldi r6,0
    ldi r5,bricks10
    ldi r4, bricks11
    while
        cmp r6,8
    stays lt
        ldi r3,0
        stb r5,r3
        stb r4,r3
        ldi r3,1
        add r5,2
        add r4,2
        stb r5,r3
        stb r4,r3
        add r5,2
        add r4,2
        stb r5,r3
        stb r4,r3
        add r5,2
        add r4,2
        stb r5,r3
        stb r4,r3
        add r5,2
        add r4,2
        inc r6
    wend
    reset #reseting the programm
    rts

# arrays of blocks, every array corresponds to logisim display string
bricks4: dc 0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0
bricks5: dc 0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0

bricks7: dc 0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0
bricks8: dc 0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0

bricks10: dc 0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0
bricks11: dc 0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0


end.


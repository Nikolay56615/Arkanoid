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
#r4 - temporary register for x/y coordinate to pre-calculate
#r5 - has an adress of brick
#r6 - score
ldi r0,16 #x-coordinate
ldi r1,1 #x-velocity
ldi r2,28 #y-coordinate
ldi r3,-1 # y-velocity
while
    cmp r2,31
stays ne
    add r1,r0,r4

    ###checking block collision sideways section
    if
        cmp r2,8 #checking for every row, if corner pixel has been beaten sboku or snizu - If because of adding x - sboku----------------------------------------
    is eq
        ldi r5, bricks8
        add r5,r4,r5
        push r1
        ld r5,r1
        if
            cmp r1, 1
        is eq # we need to know if this left or right pixel
            inc r6
            inc r5
            ld r5,r1
            if
                cmp r1,1
            is eq # left pixel
                dec r1
                dec r5
                st r5,r1
                inc r5
                st r5,r1
                inc r5
                st r5,r1
                ldi r5, bricks7
                add r5,r4,r5
                st r5,r1
                inc r5
                st r5,r1
                inc r5
                st r5,r1
                pop r1
                neg r1

            else #right pixel
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                ldi r5, bricks7
                add r5,r4,r5
                st r5,r1
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                pop r1
            fi
        else
            pop r1
        fi
    fi

    if
        cmp r2,7
    is eq
        ldi r5, bricks7
        add r5,r4,r5
        push r1
        ld r5,r1
        if
            cmp r1, 1
        is eq # we need to know if this left or right pixel
            inc r6
            inc r5
            ld r5,r1
            if
                cmp r1,1
            is eq # left pixel
                dec r1
                dec r5
                st r5,r1
                inc r5
                st r5,r1
                inc r5
                st r5,r1
                ldi r5, bricks8
                add r5,r4,r5
                st r5,r1
                inc r5
                st r5,r1
                inc r5
                st r5,r1
                pop r1
            else #right pixel
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                ldi r5, bricks8
                add r5,r4,r5
                st r5,r1
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                pop r1
            fi
        else
            pop r1
        fi
    fi


 if
        cmp r2,5 #checking for every row, if corner pixel has been beaten sboku or snizu - If because of adding x - sboku
    is eq
        ldi r5, bricks5
        add r5,r4,r5
        push r1
        ld r5,r1
        if
            cmp r1, 1
        is eq # we need to know if this left or right pixel
            inc r6
            inc r5
            ld r5,r1
            if
                cmp r1,1
            is eq # left pixel
                dec r1
                dec r5
                st r5,r1
                inc r5
                st r5,r1
                inc r5
                st r5,r1
                ldi r5, bricks4
                add r5,r4,r5
                st r5,r1
                inc r5
                st r5,r1
                inc r5
                st r5,r1
                pop r1
                neg r1
                add r1,r4,r4

            else #right pixel
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                ldi r5, bricks4
                add r5,r4,r5
                st r5,r1
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                pop r1
                neg r1
                add r1,r4,r4
            fi
        else
            pop r1
        fi
    fi

    if
        cmp r2,4
    is eq
        ldi r5, bricks4
        add r5,r4,r5
        push r1
        ld r5,r1
        if
            cmp r1, 1
        is eq # we need to know if this left or right pixel
            inc r6
            inc r5
            ld r5,r1
            if
                cmp r1,1
            is eq # left pixel
                dec r1
                dec r5
                st r5,r1
                inc r5
                st r5,r1
                inc r5
                st r5,r1
                ldi r5, bricks5
                add r5,r4,r5
                st r5,r1
                inc r5
                st r5,r1
                inc r5
                st r5,r1
                pop r1
                neg r1
                add r1,r4,r4
            else #right pixel
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                ldi r5, bricks5
                add r5,r4,r5
                st r5,r1
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                pop r1
                neg r1
                add r1,r4,r4
            fi
        else
            pop r1
        fi
    fi


 if
        cmp r2,2 #checking for every row, if corner pixel has been beaten sboku or snizu - If because of adding x - sboku
    is eq
        ldi r5, bricks2
        add r5,r4,r5
        push r1
        ld r5,r1
        if
            cmp r1, 1
        is eq # we need to know if this left or right pixel
            inc r6
            inc r5
            ld r5,r1
            if
                cmp r1,1
            is eq # left pixel
                dec r1
                dec r5
                st r5,r1
                inc r5
                st r5,r1
                inc r5
                st r5,r1
                ldi r5, bricks1
                add r5,r4,r5
                st r5,r1
                inc r5
                st r5,r1
                inc r5
                st r5,r1
                pop r1
                neg r1
                add r1,r4,r4
            else #right pixel
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                ldi r5, bricks1
                add r5,r4,r5
                st r5,r1
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                pop r1
                neg r1
                add r1,r4,r4
            fi
        else
            pop r1
        fi
    fi

    if
        cmp r2,1
    is eq
        ldi r5, bricks1
        add r5,r4,r5
        push r1
        ld r5,r1
        if
            cmp r1, 1
        is eq # we need to know if this left or right pixel
            inc r6
            inc r5
            ld r5,r1
            if
                cmp r1,1
            is eq # left pixel
                dec r1
                dec r5
                st r5,r1
                inc r5
                st r5,r1
                inc r5
                st r5,r1
                ldi r5, bricks2
                add r5,r4,r5
                st r5,r1
                inc r5
                st r5,r1
                inc r5
                st r5,r1
                pop r1
                neg r1
                add r1,r4,r4
            else #right pixel
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                ldi r5, bricks2
                add r5,r4,r5
                st r5,r1
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                pop r1
                neg r1
                add r1,r4,r4
            fi
        else
            pop r1
        fi
    fi

    ###checking block collision sideways section ended--------------------------------------------------------------------




    #checking wall collisions by x-coordinate
    if
        cmp r4,32
    is ge
        neg r1
        dec r4
        dec r4
    fi
    if
        cmp r4,-1
    is le
        neg r1
        inc r4
        inc r4
    fi
    move r4,r0

    ### checking collisions with upper wall
    add r2,r3,r4
    if
        cmp r4,-1
    is le
        neg r3
        inc r4
        inc r4
    fi
    # if
    #     cmp r4,29
    # is eq
    #     ldi r4,0xbeef
    #     push r3 # stack has an y-velocity before collision with bat
    #     ldb r4,r3 #now it has coordinate of bat
    #     if
    #         cmp r0,r3
    #     is le, and
    #         sub r3,2
    #         cmp r0,r3
    #     is ge
    #     then
    #         pop r3
    #         neg r3
    #         add r2,r3,r4
    #     fi
    # fi



    ### y-checking collisions with blocks - above or below -------------------------------------------------------
    if
        cmp r4,8
    is eq
        ldi r5, bricks8
        add r5,r0,r5
        push r1
        ld r5,r1
        if
            cmp r1,1
        is eq
            inc r6
            inc r5
            ld r5,r1
            if 
                cmp r1,1
            is eq
                dec r5
                dec r5
                ld r5,r1
                if
                    cmp r1,1
                is eq #check for middle pixel - correct
                    dec r1
                    st r5,r1
                    inc r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    ldi r5,bricks7
                    add r5,r0,r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    dec r5
                    dec r5
                    st r5,r1
                    pop r1
                    neg r2
                    add r2,r4
                else #left pixel - correct
                    inc r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    ldi r5,bricks7
                    add r5,r0,r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    pop r1
                    neg r2
                    add r2,r4
                fi

            else #right pixel - correct
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                ldi r5,bricks7
                add r5,r0,r5
                st r5,r1
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                pop r1
                neg r2
                add r2,r4
            fi
    
        fi
    fi




    if
        cmp r4,7
    is eq
        ldi r5, bricks7
        add r5,r0,r5
        push r1
        ld r5,r1
        if
            cmp r1,1
        is eq
            inc r6
            inc r5
            ld r5,r1
            if 
                cmp r1,1
            is eq
                dec r5
                dec r5
                ld r5,r1
                if
                    cmp r1,1
                is eq #check for middle pixel - correct
                    dec r1
                    st r5,r1
                    inc r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    ldi r5,bricks8
                    add r5,r0,r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    dec r5
                    dec r5
                    st r5,r1
                    pop r1
                    neg r2
                    add r2,r4
                else #left pixel - correct
                    inc r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    ldi r5,bricks8
                    add r5,r0,r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    pop r1
                    neg r2
                    add r2,r4
                fi

            else #right pixel - correct
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                ldi r5,bricks8
                add r5,r0,r5
                st r5,r1
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                pop r1
                neg r2
                add r2,r4
            fi
    
        fi
    fi

    if
        cmp r4,5
    is eq
        ldi r5, bricks5
        add r5,r0,r5
        push r1
        ld r5,r1
        if
            cmp r1,1
        is eq
            inc r6
            inc r5
            ld r5,r1
            if 
                cmp r1,1
            is eq
                dec r5
                dec r5
                ld r5,r1
                if
                    cmp r1,1
                is eq #check for middle pixel - correct
                    dec r1
                    st r5,r1
                    inc r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    ldi r5,bricks4
                    add r5,r0,r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    dec r5
                    dec r5
                    st r5,r1
                    pop r1
                    neg r2
                    add r2,r4
                else #left pixel - correct
                    inc r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    ldi r5,bricks4
                    add r5,r0,r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    pop r1
                    neg r2
                    add r2,r4
                fi

            else #right pixel - correct
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                ldi r5,bricks4
                add r5,r0,r5
                st r5,r1
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                pop r1
                neg r2
                add r2,r4
            fi
    
        fi
    fi




    if
        cmp r4,4
    is eq
        ldi r5, bricks4
        add r5,r0,r5
        push r1
        ld r5,r1
        if
            cmp r1,1
        is eq
            inc r6
            inc r5
            ld r5,r1
            if 
                cmp r1,1
            is eq
                dec r5
                dec r5
                ld r5,r1
                if
                    cmp r1,1
                is eq #check for middle pixel - correct
                    dec r1
                    st r5,r1
                    inc r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    ldi r5,bricks5
                    add r5,r0,r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    dec r5
                    dec r5
                    st r5,r1
                    pop r1
                    neg r2
                    add r2,r4
                else #left pixel - correct
                    inc r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    ldi r5,bricks5
                    add r5,r0,r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    pop r1
                    neg r2
                    add r2,r4
                fi

            else #right pixel - correct
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                ldi r5,bricks5
                add r5,r0,r5
                st r5,r1
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                pop r1
                neg r2
                add r2,r4
            fi
    
        fi
    fi

    if
        cmp r4,2
    is eq
        ldi r5, bricks2
        add r5,r0,r5
        push r1
        ld r5,r1
        if
            cmp r1,1
        is eq
            inc r6
            inc r5
            ld r5,r1
            if 
                cmp r1,1
            is eq
                dec r5
                dec r5
                ld r5,r1
                if
                    cmp r1,1
                is eq #check for middle pixel - correct
                    dec r1
                    st r5,r1
                    inc r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    ldi r5,bricks1
                    add r5,r0,r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    dec r5
                    dec r5
                    st r5,r1
                    pop r1
                    neg r2
                    add r2,r4
                else #left pixel - correct
                    inc r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    ldi r5,bricks1
                    add r5,r0,r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    pop r1
                    neg r2
                    add r2,r4
                fi

            else #right pixel - correct
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                ldi r5,bricks1
                add r5,r0,r5
                st r5,r1
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                pop r1
                neg r2
                add r2,r4
            fi
    
        fi
    fi




    if
        cmp r4,1
    is eq
        ldi r5, bricks1
        add r5,r0,r5
        push r1
        ld r5,r1
        if
            cmp r1,1
        is eq
            inc r6
            inc r5
            ld r5,r1
            if 
                cmp r1,1
            is eq
                dec r5
                dec r5
                ld r5,r1
                if
                    cmp r1,1
                is eq #check for middle pixel - correct
                    dec r1
                    st r5,r1
                    inc r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    ldi r5,bricks2
                    add r5,r0,r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    dec r5
                    dec r5
                    st r5,r1
                    pop r1
                    neg r2
                    add r2,r4
                else #left pixel - correct
                    inc r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    ldi r5,bricks2
                    add r5,r0,r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    inc r5
                    st r5,r1
                    pop r1
                    neg r2
                    add r2,r4
                fi

            else #right pixel - correct
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                ldi r5,bricks2
                add r5,r0,r5
                st r5,r1
                dec r5
                st r5,r1
                dec r5
                st r5,r1
                pop r1
                neg r2
                add r2,r4
            fi
    
        fi
    fi
    ### y-checking collisions with blocks - above or below -------------------------------------------------------


    move r4,r2    
wend
halt
ball_y: dc 28
x_bat: dc 1

#suppose that field is 32x32, bricks take rows 17 and 18
asect 0xdead #added this adress to check it in logisim RAM
bricks1: dc 0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0
bricks2: dc 0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0

bricks4: dc 0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0
bricks5: dc 0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0

bricks7: dc 0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0
bricks8: dc 0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0
end.
#ya hz voobsche rabotaet eta zalupa ili net, poka probnyi variant
# need to change coordinate system, because in this version ball can only reflect by corner of brick
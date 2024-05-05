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
#r6 - score (0xcccc)
ldi r0,128 #x-coordinate
ldi r1,-11 #x-velocity
ldi r2,224 #y-coordinate
ldi r3,-4 # y-velocity
ldi r6,248
while
    ldi r6,248
    cmp r2,r6
stays lt
    add r1,r0,r4
    #checking wall collisions by x-coordinate
    if 
        ldi r6, 256
        cmp r4,r6
    is ge
        neg r1
        add r1,r4,r4
    fi
    if
        cmp r4,0
    is lt
        neg r1
        add r1,r4,r4
    fi
    move r4,r0

    
    ###checking block collision sideways section
    if
        ldi r6,88
        cmp r2,r6 #checking for every row, if corner pixel has been beaten sboku or snizu - If because of adding x - sboku----------------------------------------
    is ge, and
        ldi r6,95
        cmp r2,r6
    is le
    then

        ldi r5, bricks11
        move r0,r4
        shr r4
        shr r4
        shr r4
        #ldi r6,0b0000000000011111
        #and r6, r4
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
                ldi r5, bricks10
                add r5,r4,r5
                add r5,r4,r5
                st r5,r1
                add r5,2
                st r5,r1
                add r5,2
                st r5,r1
                pop r1
                neg r1

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
            fi
        else
            pop r1
        fi
    fi


    if
        ldi r6,80
        cmp r2,r6 #checking for every row, if corner pixel has been beaten sboku or snizu - If because of adding x - sboku----------------------------------------
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
        ldi r6,0b0000000000011111
        and r6, r4
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
            fi
        else
            pop r1
        fi
    fi






    if
        ldi r6,64
        cmp r2,r6 #checking for every row, if corner pixel has been beaten sboku or snizu - If because of adding x - sboku----------------------------------------
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
            fi
        else
            pop r1
        fi
    fi

    if
        ldi r6,56
        cmp r2,r6 #checking for every row, if corner pixel has been beaten sboku or snizu - If because of adding x - sboku----------------------------------------
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
            fi
        else
            pop r1
        fi
    fi


    if
        ldi r6,40
        cmp r2,r6 #checking for every row, if corner pixel has been beaten sboku or snizu - If because of adding x - sboku----------------------------------------
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
            fi
        else
            pop r1
        fi
    fi

    if
        ldi r6,32
        cmp r2,r6 #checking for every row, if corner pixel has been beaten sboku or snizu - If because of adding x - sboku----------------------------------------
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
            fi
        else
            pop r1
        fi
    fi


    if
        ldi r6,16
        cmp r2,r6 #checking for every row, if corner pixel has been beaten sboku or snizu - If because of adding x - sboku----------------------------------------
    is ge, and
        ldi r6,23
        cmp r2,r6
    is le
    then

        ldi r5, bricks2
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
                ldi r5, bricks1
                add r5,r4,r5
                add r5,r4,r5
                st r5,r1
                add r5,2
                st r5,r1
                add r5,2
                st r5,r1
                pop r1
                neg r1

            else #right pixel

                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                ldi r5, bricks1
                add r5,r4,r5
                add r5,r4,r5
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                pop r1
                neg r1
            fi
        else
            pop r1
        fi
    fi

    if
        ldi r6,8
        cmp r2,r6 #checking for every row, if corner pixel has been beaten sboku or snizu - If because of adding x - sboku----------------------------------------
    is ge, and
        ldi r6,15
        cmp r2,r6
    is le
    then

        ldi r5, bricks1
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
                ldi r5, bricks2
                add r5,r4,r5
                add r5,r4,r5
                st r5,r1
                add r5,2
                st r5,r1
                add r5,2
                st r5,r1
                pop r1
                neg r1

            else #right pixel

                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                ldi r5, bricks2
                add r5,r4,r5
                add r5,r4,r5
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                pop r1
                neg r1
            fi
        else
            pop r1
        fi
    fi

    ###checking block collision sideways section ended--------------------------------------------------------------------

    ### checking collisions with upper wall
    add r2,r3,r4
    if
        cmp r4,0
    is lt
        neg r3
        add r3,r4
    fi
    move r4,r2

    if
        ldi r6,232
        cmp r2,r6
    is ge, and
        ldi r6,239
    is le
    then
        ldi r5,0xbeef
        ld r5,r4 #now it has coordinate of bat
        move r0,r6
        shr r6
        shr r6
        shr r6
        if
            cmp r6,r4
        is eq
            neg r3
            neg r1
            #add r2,r3,r2
            #add r0,r1,r0
            
        else
            dec r4
            if
                cmp r6,r4
            is eq
                neg r3
                #add r2,r3,r2
                #add r0,r1,r0
                
            else
                dec r4
                if
                    cmp r6,r4
                is eq
                    neg r3
                    neg r1
                    #add r2,r3,r2
                    #add r0,r1,r0
                    
                else
                    #add r2,r3,r2
                fi
            fi
        fi
    fi



    ### y-checking collisions with blocks - above or below -------------------------------------------------------
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
                is eq #check for middle pixel - correct
                    dec r1
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
                    sub r5,2
                    sub r5,2
                    st r5,r1
                    pop r1
                    neg r3
                    #add r3,r2
                else #left pixel - correct
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
                    #add r3,r2
                fi

            else #right pixel - correct
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
                #add r3,r2
            fi
        else
            pop r1
        fi
    fi
    
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
                is eq #check for middle pixel - correct
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
                    #add r3,r2
                else #left pixel - correct
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
                    #add r3,r2
                fi

            else #right pixel - correct
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
                #add r3,r2
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
                is eq #check for middle pixel - correct
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
                    #add r3,r2
                else #left pixel - correct
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
                    #add r3,r2
                fi

            else #right pixel - correct
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
                #add r3,r2
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
                is eq #check for middle pixel - correct
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
                    #add r3,r2
                else #left pixel - correct
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
                    #add r3,r2
                fi

            else #right pixel - correct
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
                #add r3,r2
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
                is eq #check for middle pixel - correct
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
                    #add r3,r2
                else #left pixel - correct
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
                    #add r3,r2
                fi

            else #right pixel - correct
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
                #add r3,r2
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
                is eq #check for middle pixel - correct
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
                    #add r3,r2
                else #left pixel - correct
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
                    #add r3,r2
                fi

            else #right pixel - correct
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
                #add r3,r2
            fi
        else
            pop r1
        fi
    fi

    if
        ldi r6,16
        cmp r2,r6
    is ge, and
        ldi r6,23
        cmp r2,r6
    is le
    then
        move r0,r4
        shr r4
        shr r4
        shr r4
        ldi r5, bricks2
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
                is eq #check for middle pixel - correct
                    dec r1
                    st r5,r1
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    ldi r5,bricks1
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
                    #add r3,r2
                else #left pixel - correct
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    ldi r5,bricks1
                    add r5,r4,r5
                    add r5,r4,r5
                    st r5,r1
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    pop r1
                    neg r3
                    #add r3,r2
                fi

            else #right pixel - correct
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                ldi r5,bricks1
                add r5,r4,r5
                add r5,r4,r5
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                pop r1
                neg r3
                #add r3,r2
            fi
        else
            pop r1
        fi
    fi




    if
        ldi r6,8
        cmp r2,r6
    is ge, and
        ldi r6,15
        cmp r2,r6
    is le
    then
        move r0,r4
        shr r4
        shr r4
        shr r4
        ldi r5, bricks1
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
                is eq #check for middle pixel - correct
                    dec r1
                    st r5,r1
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    ldi r5,bricks2
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
                    #add r3,r2
                else #left pixel - correct
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    ldi r5,bricks2
                    add r5,r4,r5
                    add r5,r4,r5
                    st r5,r1
                    add r5,2
                    st r5,r1
                    add r5,2
                    st r5,r1
                    pop r1
                    neg r3
                    #add r3,r2
                fi

            else #right pixel - correct
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                ldi r5,bricks2
                add r5,r4,r5
                add r5,r4,r5
                st r5,r1
                sub r5,2
                st r5,r1
                sub r5,2
                st r5,r1
                pop r1
                neg r3
                #add r3,r2
            fi
        else
            pop r1
        fi
    fi
    ### y-checking collisions with blocks - above or below -------------------------------------------------------


    #move r4,r2    
wend
halt
asect 0xdead #added this adress to check it in logisim RAM
bricks1: dc 0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0
bricks2: dc 0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0

bricks4: dc 0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0
bricks5: dc 0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0

bricks7: dc 0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0
bricks8: dc 0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0

bricks10: dc 0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0
bricks11: dc 0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0
end.
# need to change coordinate system, because in this version ball can only reflect by corner of brick
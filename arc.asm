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
#r4 - temporary register for y coordinate to check if ball in brick row
#r5 - has an adress of brick
#r6 - value of brick: 1 - not broken,0-broken
ldi r0,16 #x-coordinate
ldi r1,1 #x-velocity
ldi r2,1 #y-coordinate
ldi r3,1 # y-velocity
move r2,r4
while
    cmp r2,31
stays ne
    add r1,r0,r4
    if
        cmp r4,31
    is ge
        neg r1
    fi
    if
        cmp r4,0
    is le
        neg r1
    fi
    move r4,r0
    add r2,r3,r4
    if
        cmp r4,0
    is le
        neg r3
    fi
    if
        cmp r4,29
    is eq
        ldi r4,0xbeef
        push r3 # stack has an y-velocity before collision with bat
        ldb r4,r3 #now it has coordinate of bat
        if
            cmp r0,r3
        is eq
            pop r3
            neg r3
        else
            dec r3
            if
                cmp r0,r3
            is eq
                pop r3
                neg r3
            else
                dec r3
                if
                    cmp r0,r3
                is eq
                    pop r3
                    neg r3
                fi
            fi
        fi
    fi
    if
        cmp r4, 1
    is eq, or
        cmp r4, 2
    is eq, or
        
    fi
    arr
    add r1,r0,r0
    
    
wend
halt
ball_y: dc 28
x_bat: dc 1

#suppose that field is 32x32, bricks take rows 17 and 18
asect 0xdead #added this adress to check it in logisim RAM
bricks1_1: dc 0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0
bricks1_2: dc 0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0

bricks2_1: dc 0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0
bricks2_2: dc 0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0

bricks3_1: dc 0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0
bricks3_2: dc 0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0
end.
#ya hz voobsche rabotaet eta zalupa ili net, poka probnyi variant
# need to change coordinate system, because in this version ball can only reflect by corner of brick
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
ldi r0,15 #x-coordinate
ldi r1,1 #x-velocity
ldi r2,1 #y-coordinate
ldi r3,1 # y-velocity
move r2,r4
while
    cmp r2,0
stays ne
    #negating-velocity section
    if
        cmp r0,31
    is ge
        neg r1 
    fi
    if
        cmp r0,0
    is le
        neg r1
    fi
    if
        cmp r2,31
    is ge
        neg r2
    fi
    #adding coordinates and checking for collision
    add r1,r0,r0
    add r1,r0,r0
    if
        cmp r4,17
    is eq
        ldi r5,bricks1
        add r5,r0,r5
        ld r5,r6
        if
            cmp r6,1
        is eq
            dec r6 #here is collision moment - it should be detected by logisim
            st r5,r6
            neg r1
            neg r3
            add r1,r0,r0
            add r1,r0,r0
            add r3,r2,r2
        else
            move r4,r2
        fi
    fi
    if
    cmp r4,18
    is eq
        ldi r5,bricks2
        add r5,r0,r5
        ld r5,r6
        if
            cmp r6,1
        is eq
            dec r6 #here is collision moment - it should be detected by logisim(with trigger and comparator, for example e.g.)
            st r5,r6
            neg r1
            neg r3
            add r1,r0,r0 #two addings to return x back
            add r1,r0,r0
            add r3,r2,r2 #adding negative velocity to y
        else
            move r4,r2
        fi
    fi
    
    #move r2,r4
wend
halt
#suppose that field is 32x32, bricks take rows 17 and 18
asect 0xdead #added this adress to check it in logisim RAM
bricks1: dc 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
bricks2: dc 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
end.
#ya hz voobsche rabotaet eta zalupa ili net, poka probnyi variant
# need to change coordinate system, because in this version ball can only reflect by corner of brick
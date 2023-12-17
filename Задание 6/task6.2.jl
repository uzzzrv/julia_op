using HorizonSideRobots
r = Robot("task6.sit",animate = true)

function corner_side(Side_hz::HorizonSide,Side_ver::HorizonSide) 
    moves = [] 
    deviation_hz = 0 
    deviation_ver = 0 
    while !isborder(r,Side_ver) || !isborder(r,Side_hz) 
        if isborder(r,Side_ver) 
            move!(r,Side_hz) 
            push!(moves,Side_hz) 
            deviation_hz += 1 
        else 
            move!(r,Side_ver) 
            push!(moves,Side_ver) 
            deviation_ver += 1 
        end 
    end 
    return [[deviation_hz,Side_hz],[deviation_ver,Side_ver],reverse(moves)] 
end 
function deviation_fix(instruction) 
    for i in 1:instruction[1] 
        move!(r,inverse(instruction[2])) 
    end 
    putmarker!(r) 
    for i in 1:instruction[1] 
        move!(r,instruction[2]) 
    end 
end 
function go_inverse(move) 
    for i in move 
        move!(r,inverse(i)) 
    end 
end 
function n6b() 
    for i in [[Ost,Nord],[West,Sud]] 
        base = corner_side(i[1],i[2]) 
        deviation_fix(base[1]) 
        deviation_fix(base[2]) 
        go_inverse(base[3]) 
    end 
end 
n6b()
inverse(Side::HorizonSide) = HorizonSide(mod(Int(Side)+2,4)) 
nextside(Side::HorizonSide) = HorizonSide(mod(Int(Side)+1,4)) 
prevside(Side::HorizonSide ) = HorizonSide(mod(Int(Side)-1,4)) 

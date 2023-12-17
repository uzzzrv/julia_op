#=
Задание 2
2. ДАНО: Робот - в произвольной клетке поля (без внутренних перегородок
и маркеров)
РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки по периметру
внешней рамки промаркированы.
=#

using HorizonSideRobots
r = Robot(animate = true)

function totopleft!(r,side)
    num = 0
    while !isborder(r,side)
        move!(r,side)
        num += 1
    end
    return num
end

function markrow!(r,side)
    while !isborder(r,side)
        putmarker!(r)
        move!(r,side)
    end
end

function back!(r,side,num_steps)
    for _ in range(0,num_steps-1) 
        move!(r,side)  
    end 
end

function perimetr!(r)
    tonord = totopleft!(r,Nord)
    towest= totopleft!(r,West)
    for side in (Ost,Sud,West,Nord)
        markrow!(r,side)    
    end   
    totopleft!(r,Nord)
    totopleft!(r,West)
    back!(r,Ost,towest)
    back!(r,Sud,tonord)  
end

perimetr!(r)

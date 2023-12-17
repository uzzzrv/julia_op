#=
ДАНО: Робот - в произвольной клетке ограниченного прямоугольного
поля
РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки поля
промаркированы.
=#

using HorizonSideRobots
robot = Robot(animate = true)

function back!(robot,side,num_steps)
    for x in range(0,num_steps-1)
        move!(robot,side)
    end
end
inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2,4))

function totopleft!(robot::Robot,side::HorizonSide)
    num = 0
    while !isborder(robot, side)
        move!(robot,side)
        num += 1
    end
    return num
end

function mark!(robot::Robot,side::HorizonSide)
    while !isborder(robot,side)
        putmarker!(robot)
        move!(robot,side)
    end
    putmarker!(robot)
end

function vsepole!(robot::Robot)
    tonord = totopleft!(robot,Nord)
    towest = totopleft!(robot,West)   
    side = Ost
    mark!(robot,side)
    while !isborder(robot,Sud)
        move!(robot,Sud)
        side = inverse(side)
        mark!(robot,side)
    end
    totopleft!(robot,Nord)
    totopleft!(robot,West)
    back!(robot,Sud,num_nord)
    back!(robot,Ost,num_west)
end

vsepole!(robot)

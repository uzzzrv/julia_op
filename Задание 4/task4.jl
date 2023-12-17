#=
Задание 4
ДАНО: Робот находится в произвольной клетке ограниченного
прямоугольного поля без внутренних перегородок и маркеров.
РЕЗУЛЬТАТ: Робот — в исходном положении в центре косого креста из
маркеров, расставленных вплоть до внешней рамки.
=#

using HorizonSideRobots

r = Robot( "task4.sit", animate = true)

function back!(robot,sides::Tuple,num_s)
    for _ in range(0,num_s-1)
        for side in sides
            move!(robot,inverse_side(side))
        end
    end
end
inverse_side(side::HorizonSide) = HorizonSide(mod(Int(side)+2,4))

function marksteps!(robot,sides::Tuple)
    steps = 0
    putmarker!(robot)
    for side in sides
        move!(robot,side)
        steps += 1
    end
    return steps//2
end

function twosideisborder(robot,sides::Tuple)
    side1, side2 = sides
    if (isborder(robot,side1) == 0) && (isborder(robot,side2) == 0)
        return false
    else
        return true
    end
end

function kosoykrest!(robot)
    for side in ((Nord, West), (Nord, Ost), (Sud, West), (Sud, Ost))
        num_s = 0
        while !twosideisborder(robot,side) 
            num_s += marksteps!(robot,side) 
        end
        putmarker!(robot)
        back!(robot,side::Tuple,num_s) 
    end
end

kosoykrest!(r)

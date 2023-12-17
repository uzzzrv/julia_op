#= 
Задание 1
ДАНО: Робот находится в произвольной клетке ограниченного
прямоугольного поля без внутренних перегородок и маркеров.
РЕЗУЛЬТАТ: Робот — в исходном положении в центре прямого креста из
маркеров, расставленных вплоть до внешней рамки.
=# 

using HorizonSideRobots
r = Robot("task1.sit", animate = true)

function mark!(r::Robot,side::HorizonSide)
    while !isborder(r,side)
        move!(r,side)
        putmarker!(r)
    end
end

function back!(r::Robot,side::HorizonSide)
    while ismarker(r)
        move!(r,side)
    end
end

function pryamoi_krest!(r::Robot) 
    for side in (Nord,Sud,West,Ost)
        mark!(r,side)
        back!(r,inverse(side))
    end
    putmarker!(r)      
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2,4))

pryamoi_krest!(r)

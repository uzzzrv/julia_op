#=
Задание 7
ДАНО: Робот - рядом с горизонтальной бесконечно продолжающейся в
обе стороны перегородкой (под ней), в которой имеется проход шириной в одну
клетку.
РЕЗУЛЬТАТ: Робот - в клетке под проходом
=#

using HorizonSideRobots
robot = Robot(animate = true)

function move_throughborder!(robot,side_border)
    n = 0
    side = left(side_border)
    while isborder(robot,side_border)
        n += 1
        move_n!(robot,side,n)
        side = inverse_side(side)
    end
    move!(robot,side_border)
    move_n!(robot, side, div((n+1),2))

end


function move_n!(robot, side::HorizonSide, n)
    for x in 1:n
        move!(robot,side)
    end    
end

inverse_side(side::HorizonSide) = HorizonSide(mod(Int(side)+2,4))

left(side::HorizonSide) = HorizonSide(mod(Int(side)+1,4))

move_throughborder!(robot,Nord)

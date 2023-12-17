#=
Задание 8
ДАНО: Где-то на неограниченном со всех сторон поле без внутренних
перегородок имеется единственный маркер. Робот - в произвольной клетке этого
поля.
РЕЗУЛЬТАТ: Робот - в клетке с маркером.
=#

using HorizonSideRobots
robot = Robot("task8.sit", animate = true)

function find_marker!(robot)
    side = Nord
    n = 0
    flag = true 
    while !find_marker!(robot,side,n)
        # if flag == true
        #     n+=1
        # end
        if flag
            n = n + 1
        end
        flag  = !flag
        side = left(side)
    end
end

function  find_marker!(robot,side,max_num_steps)
    for _ in 1:max_num_steps
        # if ismarker(robot)
        #     return true
        # end            
        ismarker(robot) && return true 
        move!(robot,side)             
    end
    return false            
end

function move_n!(robot, side::HorizonSide, n)
    for _ in 1:n
        move!(robot,side)
    end    
end

left(side::HorizonSide) = HorizonSide(mod(Int(side)+1,4))

find_marker!(robot)


 

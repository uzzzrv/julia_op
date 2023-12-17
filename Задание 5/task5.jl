#=
5. ДАНО: На ограниченном внешней прямоугольной рамкой поле имеется
ровно одна внутренняя перегородка в форме прямоугольника. Робот - в
произвольной клетке поля между внешней и внутренней перегородками.
РЕЗУЛЬТАТ: Робот - в исходном положении и по всему периметру
внутренней, как внутренней, так и внешней, перегородки поставлены маркеры.
=#

using HorizonSideRobots
r = Robot("task5.sit", animate=true)
 
using HorizonSideRobots
robot = Robot(animate = true)

function topleft_and_count!(robot::Robot)
    num_s_nord = num_s_west = 0
    while !isborder(robot, Nord) || !isborder(robot,West)
        num_s_nord += move_ifnoborder!(robot,Nord)
        num_s_west += move_ifnoborder!(robot,West)
    end
    return (num_s_nord, num_s_west)
end

function move_ifnoborder!(robot::Robot, side::HorizonSide)
    num_s  = 0
    while !isborder(robot,side)
        move!(robot,side)
        num_s += 1
    end
    return num_s
end

function markrow!(robot::Robot,side::HorizonSide)
    while !isborder(robot,side)
        putmarker!(robot)
        move!(robot,side)
    end
end

function find_border!(robot::Robot,side)
    while find_in_row!(robot,side) == false
        move!(robot,Sud)
        side = inverse_side(side)
    end
end
inverse_side(side::HorizonSide) = HorizonSide(mod(Int(side)+2,4))

function find_in_row!(robot::Robot,side::HorizonSide)
    while !isborder(robot, Sud) && !isborder(robot,side)
        move!(robot,side)
    end
    return isborder(robot,Sud)
end

function goback!(robot, n_sud, n_ost)
    for _ in range(0,n_sud-1)
        move!(robot, Sud)
    end
    for _ in range(0,n_ost-1)
        move!(robot,Ost)
    end
end

function mark_sec_perm!(robot::Robot,side::HorizonSide)
    while isborder(robot,side)
        putmarker!(robot)
        move!(robot,inverse_by_3(side))
    end
    putmarker!(robot)
    move!(robot,side)   
end
inverse_by_3(side::HorizonSide) = HorizonSide(mod(Int(side)+3,4))

function mark_perimeters!(robot::Robot)
    num_s_nord, num_s_west = topleft_and_count!(robot)
    for side in (Ost,Sud,West,Nord)
        markrow!(robot,side)    
    end 
    find_border!(robot,Ost)
    for side in (Sud, Ost, Nord, West)
        mark_sec_perm!(robot, side)
    end
    topleft_and_count!(robot)
    goback!(robot,num_s_nord,num_s_west)
end



mark_perimeters!(robot)

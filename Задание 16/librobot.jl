using HorizonSideRobots
HSR = HorizonSideRobots

left(side::HorizonSide) = HorizonSide(mod(Int(side)+1, 4))
right(side::HorizonSide) = HorizonSide(mod(Int(side)-1, 4))
inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))

try_move!(robot, side) = 
    if isborder(robot, side)
        return false
    else
        move!(robot, side)
        return true
    end


# К занятию 7 (функции высшего порядка) :

along!(stop_condition::Function, robot, side) = 
    while stop_condition() == false && try_move!(robot, side) end

function numsteps_along!(stop_condition::Function, robot, side)
    n = 0
    while stop_condition() == false && try_move!(robot, side)
        n += 1
    end
    return n
end

function snake!(stop_condition::Function, robot; start_side, ortogonal_side)
    s = start_side
    along!(robot, s) do 
        stop_condition() || isborder(robot, s)
    end
    while !stop_condition() && try_move!(robot, ortogonal_side)
        s = inverse(s)
        along!(robot, s) do 
            stop_condition() || isborder(robot, s)
        end
    end
end
# !!! в конспекте здесь ошибка: там не учтена возможность наличия перегородки в направлении s

snake!(robot; start_side, ortogonal_side) = 
    snake!(() -> false, robot; start_side, ortogonal_side)

function shatl!(stop_condition::Function, robot; start_side)
    s = start_side
    n = 0
    while stop_condition() == false
        n += 1
        move!(robot, s, n)
        s = inverse(s)
    end
    return (n+1)÷2 # - число шагов от начального положения до конечного
end

function spiral!(stop_condition::Function, robot; start_side = Nord, nextside::Function = left)
    side = start_side
    n = 0
    while stop_condition() == false
        if iseven(n)
            n += 1
        end
        move!(stop_condition, robot, side, num_maxsteps = n)
        side = nextside(side)
        move!(stop_condition, robot, side, num_maxsteps = n)
        side = nextside(side)
    end
end

function HorizonSideRobots.move!(stop_condition::Function, robot, side; num_maxsteps::Integer)
    n = 0
    while n < num_maxsteps && stop_condition() == false
        n += 1
        move!(robot, side)
    end
    return n
end

#-------------------------------------
# к занятию 8:

HSR = HorizonSideRobots

abstract type AbstractRobot end

HSR.move!(robot::AbstractRobot, side) = move!(get_baserobot(robot), side)
HSR.isborder(robot::AbstractRobot, side) = isborder(get_baserobot(robot), side)
HSR.putmarker!(robot::AbstractRobot) = putmarker!(get_baserobot(robot))
HSR.ismarker(robot::AbstractRobot) = ismarker(get_baserobot(robot))
HSR.temperature(robot::AbstractRobot) = temperature(get_baserobot(robot))

#----------------------------------------

mutable struct CountmarkersRobot <: AbstractRobot
    robot::Robot
    num_markers::Int64
end
 

function HSR.move!(robot::CountmarkersRobot, side) 
    move!(robot.robot, side)
    if ismarker(robot)
        robot.num_markers += 1
    end
    nothing
end

mutable struct Coordinates
    x::Int
    y::Int
end

function HorizonSideRobots.move!(coord::Coordinates, side::HorizonSide)
    if side == Nord
        coord.y += 1
    elseif side == Sud
        coord.y -= 1
    elseif side == Ost
        coord.y -= 1
    elseif side == West
        coord.x -= 1
    end
end

get_coord(coord::Coordinates) = (coord.x, coord.y)

abstract type AbstractRobot end

HSR.move!(robot::AbstractRobot,side) = move!(get_base_robot(robot), side)
HSR.isborder(robot::AbstractRobot,side) = isborder(get_base_robot(robot),side)
HSR.putmarker!(robot::AbstractRobot) = putmarker!(get_base_robot(robot))
HSR.ismarker(robot::AbstractRobot) = ismarker(get_base_robot(robot))
HSR.temperature(robot::AbstractRobot) = temperature(get_base_robot(robot))

struct CoordsRobot <: AbstractRobot
    robot :: Robot
    coord :: Coordinates
    CoordRobot(r) = new(r, Coordinates(0,0))
end

function HorizonSideRobots.move!(robot::CoordsRobot, side)
    move!(robot.robot, side)
    move!(robot.coord, side)
end

get_base_robot(robot::CoordsRobot) = robot.robot
get_coord(robot::CoordsRobot) = get_coord(robot.coord)
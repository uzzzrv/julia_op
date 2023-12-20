include("librobot.jl")
mutable struct ChessmarkersRobot <: AbstractRobot
    robot::Robot
    flag::Bool
    function ChessmarkersRobot(robot, flag)
        if flag == true
            putmarker!(robot)
        end
        new(robot, flag)
    end
end

get_baserobot(robot::ChessmarkersRobot) = robot.robot

function HSR.move!(robot::ChessmarkersRobot, side)
    move!(robot.robot, side)
    robot.flag = !robot.flag
    if robot.flag == true
        putmarker!(robot)
    end
    nothing 
end

r=Robot(animate=true)
r=ChessmarkersRobot(r, true)
snake!(r;start_side=Ost, ortogonal_side=Nord)

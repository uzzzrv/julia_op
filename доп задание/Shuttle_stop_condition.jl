using HorizonSideRobots
include("edge_robot.jl")
HSR = HorizonSideRobots

robot = Robot("untitled.sit",animate=true)
robot = EdgeRobot{Robot}(robot, Nord)

function shuttle!(stop::Function, robot::EdgeRobot)
    n = 2
    while !stop()
        move!(stop, robot, n)
        n += 10
        inverse!(robot)
    end
end

function HSR.move!(stop_condition::Function, robot, num_steps::Integer)
    for i in 1:num_steps
        if !stop_condition() 
        move!(robot)
        end
    end
end

shuttle!(() -> ismarker(robot), robot)


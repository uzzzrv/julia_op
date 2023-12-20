include("librobot.jl")
using HorizonSideRobots
robot = Robot("task7.sit", animate = true)
s = Nord #задать с какой стороны перегородка

function task7(robot,sideborder)
    nsteps, side = shatl!(() -> !isborder(robot,sideborder), robot, Ost)
    move!(robot,s)
    side = inverse(side)
    move!(robot, side,div((nsteps+1),2))
end

task7(robot,s)

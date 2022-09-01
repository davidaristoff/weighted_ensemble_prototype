%%%%%%%%%%%%%%%%%%%%%%% plot WE particles %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%This function plots the evolving WE particles, for visualization purposes

%NOTES:
%This should be commented out in WE_simulation.m for long runs, 
%as it slows down simulations by a large amount

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%delete last WE particle configuration from plot
delete(handleA)
delete(handleB)

%plot colored WE particle configuration: last in A = blue, last in B = red
handleA = plot(xs(1,(xs(3,:)==0)),xs(2,(xs(3,:)==0)), ...
          '.','markersize',16,'color','b');
handleB = plot(xs(1,(xs(3,:)==1)),xs(2,(xs(3,:)==1)), ...
          '.','markersize',16,'color','r');
axis([-2 2 -1.5 2.5])
pause(0.0001)

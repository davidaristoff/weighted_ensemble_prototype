%%%%%%%%%%%%%%%%%%%% main WE simulation program %%%%%%%%%%%%%%%%%%%%%%%%%%%

%This function runs a WE simulation of the 2D entropic switch problem

%NOTES:
%this runs the "entropic switch" problem on a 3-well potential energy
%depending on temperature, particles either transition directly from 
%the left well, A, to the right well, B, or they transition via state C

%at bta = 1.67, the particles tend to transition directly from A to B
%at bta = 6.67, the particles tend to transition from A to B through C

%runtime on a Surface Pro 7 is ~15 minutes for T = 10^5 select/mutate steps 
%each of length deltaT = 10 time steps, with N = 1000 particles and 10 bins

%this run time is sufficient to equilibrate at bta = 6.67 
%assuming that the integrator time step is dt = 0.01

%particle vector xs is augmented with a row labeling the last visited state

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%initialize WE simulation
WE_initialization     

%main WE simulation loop
for t=1:T
 
    %define WE bins, u, and particle allocation, Nu
    [wus,copies] = WE_parameters_(xs,ws);
    
    %perform WE selection or resampling step
    [xs,ws] = WE_selection_(xs,wus,copies);    
    
    %perform WE evolution or mutation step
    xs = WE_evolution_(xs);   
    
    %update running WE observable average
    QOIavg = WE_update_(xs,ws,QOIavg);

    %plot WE particles
    WE_plot      %comment this out for long simulations
    pause(0.1)
end

%display WE observable average
disp('WE observable average = ...')
WE_average = QOIavg/T             

%display exact observable average
disp('exact observable average = ...')
exact_average = integral2(@(x,y) y.*exp(-bta*V(x,y)),-4,4,-3.5,4.5) ...
                /integral2(@(x,y) exp(-bta*V(x,y)),-4,4,-3.5,4.5)


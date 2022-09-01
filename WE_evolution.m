function xs = WE_evolution(xs,dt,deltaT,bta,F,d,N,distA,distB,rad)

%%%%%%%%%%%%%%%%%%% WE evolution function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%This function evolves the WE particles 
%for deltaT time steps each of size dt

%INPUTS:
%xs = (d+1)xN particle matrix, dt = time step 
%deltaT = number of time steps per evolution step
%bta = inverse temperature
%F = force, d = dimension, N = number of particles
%distA = distance to minimum of V in state A
%distB = distance to minimum of V in state B

%OUTPUTS:
%xs = (d+1)xN updated particle matrix

%NOTES:
%first d rows of xs are the particle positions in d dimensions
%where each column of xs represents a single particle
%the last row of xs is equal to 0 if the particle was last in A, and 1 else

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%evolve the WE particle vector for DeltaT time steps
for t=1:deltaT
    
    %evolve WE particles for 1 integrator time step of size dt
    xs(1:2,:) = xs(1:2,:) + F(xs)*dt + sqrt(2*dt/bta)*normrnd(0,1,[d,N]);
    
    %update WE particle labels (last in A = 0, last in B = 1)
    xs(3,:) = (xs(3,:)==0).*(distB(xs)<rad) ...
             +(xs(3,:)==1).*(1-(distA(xs)<rad));
end
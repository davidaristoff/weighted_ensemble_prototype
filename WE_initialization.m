%%%%%%%%%%%%%%%%%%%%%% WE initialization function %%%%%%%%%%%%%%%%%%%%%%%%%

%This function initializes all fixed WE parameters and functions

%OUTPUTS:
%beta = inverse temperature, dt = integrator time step
%deltaT = number of time steps between resamplings
%T = total number of time steps, N = number of particles, d = dimension
%tol = weight tolerance, QOIavg = running WE observable average, 
%rad = radius for state definitions of A and B

%V = WE potential, F = WE force
%xi = WE reaction coordinate, QOI = WE quantity of interest
%charA = characteristic function of A, charB = characteristic function of B

%xs = initial particle matrix
%ws = initial weight vector

%NOTES:
%this function also plots the WE initial condition, which are particles 
%normally distributed around the minimum of V in A, with equal weights

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bta = 6.67;      %6.67;       %bta = inverse temperature
dt = 0.001;      %dt = time step
deltaT = 10;     %deltaT = number of time steps between resamplings
T = 10^3;        %T = total number of time steps
N = 1000;        %N = number of particles
d = 2;           %d = dimension of space of particles
tol = 10^(-20);  %tol = tolerance for weights -- sets lower bound
QOIavg = 0;      %obs_avg = WE observable average
rad = 0.2;       %rad = radius for state definitions

%define WE potential, V, and force, F = -\nabla V
WE_potential

%define WE reaction coordinate, xi, observable of interest, QOI,
%and distance functions to minimums of V in states A and B, distA and distB
WE_functions

%fix global variables for WE functions
WE_update_ = @(xs,ws,QOIavg) ...
    WE_update(xs,ws,QOIavg,QOI);
WE_parameters_ = @(xs,ws) WE_parameters(xs,ws,xi,N,levels,tol);
WE_selection_ = @(xs,wus,copies) WE_selection(xs,wus,copies,d);
WE_evolution_ = @(xs) WE_evolution(xs,dt,deltaT,bta,F,d,N,distA,distB,rad);

%define initial particles in A: last in A labeled 0, last in B labeled 1
xs = [-1;0;0] + [normrnd(0,0.1*rad,[d N]);zeros(1,N)]; %row 3 = state label

%define initial uniform weights
ws = ones(1,N)/N;

%plot initial particles and potential energy landscape
x = linspace(-2,2,10^3);
y = linspace(-1.5,2.5,10^3);
[X,Y] = meshgrid(x,y);
Z = V(X,Y);
close all 
figure
contour(X,Y,Z,40)
hold on
handleA = plot(xs(1,:),xs(2,:),'.','markersize',16);   %plot particles
handleB = [];
axis([-2 2 -1.5 2.5])


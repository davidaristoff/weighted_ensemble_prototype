%%%%%%%%%%%%%%%%%%%%% WE function definitions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%This function defines the reaction coordinate, 
%the quantity of interest (QOI), 
%and the characteristic function of sets A and B

%OUTPUTS:
%xi = reaction coordinate, QOI = observable or quantity of interest
%distA = distance to minimum of V in state A
%distB = distance to minimum of V in state B

%NOTES:
%states A and B are balls of radius "rad" around (-1,0) and (1,0), resp.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%define xi = x1-coordinate in d dimensions
xi = @(xs) xs(1,:);     

%set levels = L uniform levels of reaction coordinate between Lmin and Lmax
Lmin = -1.5;
Lmax = 1.5;
L = 10;
levels = linspace(Lmin,Lmax,L)';

%define QOI = WE observable or quantity of interest = x2-coordinate
QOI = @(xs) xs(2,:);

%distA = distance to minimum of V in A
distA = @(xs) vecnorm(xs(1:2,:) - [-ones(1,N);zeros(1,N)]);

%distB = distance to minimum of V in B
distB = @(xs) vecnorm(xs(1:2,:) - [ones(1,N);zeros(1,N)]);

function [wus,copies] = WE_parameters(xs,ws,xi,N,levels,tol)

%%%%%%%%%%%%%%%%%%%%% WE parameters function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%This function computes the parameters needed for the WE selection step

%INPUTS:
%xs = (d+1)xN particle matrix, ws = 1xN weight vector
%levels = level sets of reaction coordinate used to define fixed WE bins 
%tol = weight tolerance -- sets lower bound on weights

%OUTPUTS:
%wus = 1xM vector of uniform weights in bins after the WE selection step
%copies = 1xN vector defining the number of copies of each particle

%NOTES:
%the WE bins are chosen based on level sets of the reaction coordinate xi
%and the WE allocation is uniform among bins whose weight is > tol
%the parameter tol prevents splitting of particles with very small weights

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%define bin occupancy matrix u
u = ([-inf;levels]<xi(xs))&(xi(xs)<=[levels;inf]); %bin occupancy matrix
u = u(any(u,2),:);                      %remove rows of all zeros from u
%(i,j)th entry of u equals 1 if bin i contains particle j, and 0 else

%define bin weight matrix Pu
Pu = ws.*u;   
%(i,j)th entry of Pu equals weight of particle j in bin i

%defines total bin weight vector wus
wus = sum(Pu,2);

%define WE allocation distribution, distr
distr = ((wus > tol)/sum(wus > tol))';  
%here, distr is the uniform distribution in bins with total weight > tol

%define integer particle allocation, Nu, approximately following distr
Nu = 1 + WE_resample(N-size(u,1),distr)';
%roughly uniform particle allocation in the bins, via multinomial sampling

%normalize the bin weight matrix Pu
Pu = Pu./wus;
%MxN matrix Pu gives the normalized weights in bins u=1,...,M

%compute the uniform weights in each bin, wus, after selection
wus = wus./Nu;
%Mx1 column vector wus gives the weights in bins u=1,...,M after selection

%compute the matrix of the number of copies of each particle in each bin
copies = WE_resample(Nu,Pu);
%MxN matrix: (i,j)th entry = number of copies of particle j in bin i

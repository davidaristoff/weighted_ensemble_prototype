function [xs,ws] = WE_selection(xs,wus,copies,d)

%%%%%%%%%%%%%%%%%%% WE selection function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%This function performs the WE selection step

%INPUTS:
%xs = (d+1)xN particle matrix, wus = 1xN bin weight vector
%copies = matrix of copies of each particle, d = dimension

%OUTPUTS:
%xs = updated particle matrix, ws = updated weight vector

%NOTES: 
%(i,j)th entry of copies = number of copies of particle j in bin i

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%copy each particle according to the matrix copies
xs = repelem(xs,ones(1,d+1),sum(copies,1));

%copy particle weights according to the matrix copies
ws = repelem(sum(wus.*(copies>0),1),sum(copies,1));



    
    


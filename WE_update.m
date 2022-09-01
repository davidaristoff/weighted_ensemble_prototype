function QOIavg = WE_update(xs,ws,QOIavg,QOI)

%%%%%%%%%%%%%%%%%%%%%%%%%%%% WE QOI update %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%This function updates the WE running QOI average

%INPUTS:
%QOIavg = current QOI sum over iterations 
%xs = 1xN particle vector, ws = 1xN weight vector

%OUTPUTS:
%QOIavg = updated QOI sum over iterations

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%update QOI average
QOIavg = QOIavg + ws*QOI(xs)';
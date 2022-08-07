%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%   Mohamed Soliman   OVGU 05.08.2021 
%%%%%   Task 2
%%%%% Exloration process
%%%%%
clc;
clear all;
close all;
%%%%%%%%%%%%%
addpath(genpath("/home/msoliman/YALMIP-master/"))

addpath(genpath("/home/msoliman/Hamster_ACADO/Car_exploration/Task_2/func"))


%%
 para2;
 obst;
 planner;


while t(end) < Tend 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
parameters_in = {x_p1,r_end};
%tic;
[solutions,diagnostics] = controller{parameters_in};  %toc;  
    U = solutions{1};
    oldu = U(1:2);
    X = solutions{2};
    obj=solutions{3};
    if diagnostics == 1
        error('The problem is infeasible');
    end 
%     end
    %% Storing system trajectroy and control signal for plotting
    xhist(:,i+1) = x_p1;
    uhist(:,i+1) = oldu;
    objhist(i+1)= obj;
    %%
    iter = iter+1;i=i+1;
    nextTime = iter*dt; 
    t = [t nextTime];
   x_p1=Ad*x_p1+Bd*oldu';
end   
  
ave('safe_path','xhist','ObstacleArray')
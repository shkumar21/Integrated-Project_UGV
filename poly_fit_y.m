%% Sloving optimzation problem to determine the polynomial coefficents taking into account the constraints
clc; clear all;close all
addpath(genpath("/home/msoliman/YALMIP-master/"))
load safe_path.mat
%%
% O_set=[15 40 40 90;22 38 75 70]; %box center
% ObstacleArray=[];
% 
% ObstacleArray=[20 38 0 88;24 42 80 92;20 36 50 68;24 40 100 72]; %box sizes

xhist = xhist(:,1:10:end);
xhist=xhist(:,1:140);
xdata = xhist(1,:);
ydata = xhist(2,:);

sdpvar t
[x,a] = polynomial(t,6);
[y,b] = polynomial(t,6);

objective = 0;
t_i = linspace(0,1,length(xdata));
X = [];
Y = [];
Avoid = [];     
for i = 1:length(xdata)
%     x_i = replace(x,t,t_i(i));X = [X x_i];
    y_i = replace(y,t,t_i(i));Y = [Y y_i];
    objective = objective +  1000*(y_i - ydata(i))^2 ;
    
    Avoid = [Avoid,norm([y_i] - [22],inf) >= 1,...
        norm([y_i] - [75],inf) >= [20],norm([y_i] - [70],inf) >= 1];
end
% objective= objective+1000*abs(Y(55)-ydata(55));
Match = [
         Y(1)==ydata(1),
         Y(end)==ydata(end)];

optimize([Match,Avoid],objective);
plot(value(X),value(Y))
hold on
plot(xdata,ydata)
sdpvar z(2,3);
plot(norm(z(:,1)-[22;22],inf)<=1)
hold on

plot(norm(z(:,2)-[40;75],inf)<=[80;25])
hold on
plot(norm(z(:,3)-[90;70],inf)<=1)



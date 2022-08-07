% This function is for ACADO plotting
%%%%% Plot the results
close all
cpuTime = [(INFO_MPC.cpuTime) ].*10^3;
load safe_path2T.mat
%% The Complete scene
h1 = figure(1);
set(h1,'Units','normalized','Position',[0.0 0.0 0.5 0.5]);
X=[0 0; 8.36 0; 8.36 3.3; 6.72 3.3; 6.72 1.85; 0 1.85]; 
% X=[0 0; 8.5 0; 8.5 3.4; 6.8 3.4; 6.8 1.70; 0 1.70]; 
%X=[0 0;100 0;100 100;80 100; 80 50;0 50];
pgon = polyshape(X);
plot(pgon)
hold on
Y=[0 1.85;6.72 1.85;6.72 3.30;0 3.30]; 
% Y=[0 1.70;6.80 1.70;6.80 3.40;0 3.40]; 
%Y=[0 50;80 50;80 100;0 100];
pgon1 = polyshape(Y);
plot(pgon1)

hold on 
plot(vehicle_states(1),vehicle_states(1),'+k')
text(vehicle_states(1),vehicle_states(2),strsplit(sprintf('%c\n','A')),'FontSize',15,'Color','k')
hold on
plot(r_end(1),r_end(2),'+g')
text(r_end(1),r_end(2),strsplit(sprintf('%c\n','B')),'FontSize',15,'Color','k')
hold on
plot(vehicle_states(:,1), vehicle_states(:,2), 'b-', 'Linewidth', 2.0);
hold on
% quiver(vehicle_states(end,1),vehicle_states(end,2),1,tan(vehicle_states(end,3)), 'r-', 'Linewidth', 3.0);
% hold on
plot(xhist2T(1,:), xhist2T(2,:), 'g-', 'Linewidth', 2.0);
rectangle('Position',[ObstacleArray(1,1) ObstacleArray(3,1) 2*safety_margin 2*safety_margin],'FaceColor', 'r')
hold on
rectangle('Position',[ObstacleArray(1,2) ObstacleArray(3,2) 2*safety_margin 2*safety_margin],'FaceColor', 'r')
hold on
rectangle('Position',[ObstacleArray(1,3) ObstacleArray(3,3) 2*safety_margin 2*safety_margin],'FaceColor', 'r')
grid on


title ('Path in Known environment')
xlabel('Distance in X-direction [m]','FontSize',10);
ylabel('Distance in Y-direction [m]','FontSize',10);
axis([0 8.5 0 3.4]) %x,y change,axis([0 100 0 100])
legend('Known region','Unknnown region','Start point','End point','Path')
legend('Location','bestoutside'	)
%%
h2 = figure(2);
set(h2,'Units','normalized','Position',[0.0 0.0 0.5 0.5]);
title('Control Signals ');
subplot(2,1,1);
plot(t, controls_MPC(:,1), 'k', 'Linewidth', 2.0);
ylabel('Acceleration [m/sec^2]');
hold on
subplot(2,1,2);
plot(t, controls_MPC(:,2),'k','Linewidth', 2.0);
ylabel('Steering angle rate [rad/sec^2]');
xlabel('Time [sec]')
grid on;
%%
h3 = figure(3);
set(h3,'Units','normalized','Position',[0.0 0.0 0.5 0.5]);
title('Constrained States ');
subplot(2,1,1);
hold on
grid on
f=fill([0,t(end),t(end),0], [v_min,v_min,v_min-1,v_min-1], 'r');
set(f,'facealpha',.5,'edgecolor','None')
f=fill([0,t(end),t(end),0], [v_max,v_max,v_max+1,v_max+1], 'r');
set(f,'facealpha',.5,'edgecolor','None')
plot(t, vehicle_states(:,4), 'k', 'Linewidth', 2.0);
ylabel('Velocity [m/sec]');


subplot(2,1,2);
hold on
grid on
f=fill([0,t(end),t(end),0], [delta_min,delta_min,delta_min-0.2,delta_min-0.2], 'r');
set(f,'facealpha',.5,'edgecolor','None')
f=fill([0,t(end),t(end),0], [delta_max,delta_max,delta_max+0.2,delta_max+0.2], 'r');
set(f,'facealpha',.5,'edgecolor','None')
plot(t, vehicle_states(:,5),'k','Linewidth', 2.0);
ylabel('Steering angle [rad]');
xlabel('Time [sec]')
%%
h4 = figure(4);
set(h4,'Units','normalized','Position',[0.0 0.0 0.5 0.5]);
title('CPU time ');
plot(t(1:end-1), ([cpuTime]), 'k', 'Linewidth', 2.0);
ylabel('Processing time [msec]');
xlabel('simulation time [s]')

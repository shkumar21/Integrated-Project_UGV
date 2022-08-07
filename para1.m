%% PARAMETERS %%
%% Initial values and setting
t=0;
iter = 0;
i=1;
dt =0.1;
Tend = 13; %Simulation time
vehicle_states=[0 0 0*pi/4 0 0 0 0];  % car states [x y yaw v delta z1 z2]
oldu=[0;0;0];
xhist = [0; 0;0;0;0;0;0];
uhist = oldu;
obj=0;

v_max = 1.5; %Max accelearation
v_min = 0;   %Min speed
delta_max=0.2443; %max steering angle
delta_min=-0.2443; %min steering angle
region=[0 1.750; 6.72 1.75; 6.72 3.3; 0 3.3];
% region=[0 1.7; 6.8 1.7; 6.8 3.4; 0 3.4];
%region= [0 50; 80 50; 80 100; 0 100]; % the boundaries of the unknown region
R_lidar=2; %lidar range=1m
% r_end=[8.5;3.4;0;0];% referance
r_end=[8.36;3.3;0;0];% referance
  %% ACADO paramters
n_U=3;
N_x=7;
N=50;
input.N =50;      % predicition Horizon NMPC can see 5 sec a head 
X0 = vehicle_states ;
input.x = repmat(X0,N+1,1);
input.x0 = X0;
Uref = zeros(N,n_U);
input.u = Uref;
all_ref = repmat([0 , 0, 1, 0, 0,0],N,1);
input.y = all_ref;
input.yN = all_ref(end,3);

KKT_MPC = []; INFO_MPC = [];
controls_MPC = [0 0 0];
state_sim = X0;
 
 % Weightening Matrices 
input.W  = diag([6000,  6000, 10000, 0.09,100,1000     ...    %   States x y z1 
                   ]);                           %  %controls       acc   dsteer z2
                                             

input.WN  = 10000;  % States

 
 
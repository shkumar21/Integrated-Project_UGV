%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%   Mohamed Soliman   
%%%%%   Task 2
%%%%% Formulate Path followin using the results from fit_path.m
%%%%% Here we exploit the offline path information and formulate path
%%%%% following problem using ACADO
%%%%%
clc;
clear all
close all;
%%%%%%%%%%%%%
addpath("C:\NTP_2\Integrated\Task_2")
addpath("C:\NTP_2\Integrated\Task_2\func\Acado_files")


%%
 para1;
 obst1;
 ObstacleArray = construct( O_set, safety_margin);
 
 %% SIMULATION LOOP
disp('------------------------------------------------------------------')
disp('                  Simulation Loop'                                    )
disp('Model Predicitve Path Following Controller using Non-linear car Model')

  while t(end) < Tend 
     % Solve the optimization problem
     input.x0 = vehicle_states(end,:);
     output = acado_car1(input); 
     input.x = output.x;       
     input.u = output.u;       
     
     %% Simulate system
    sim_input.x = vehicle_states(end,:).'; 
    sim_input.u = output.u(1,:).'; 
    states = integrate_car1(sim_input); 
    vehicle_states = [vehicle_states; states.value'];

    %% Storing system trajectroy and control signal for plotting
    INFO_MPC = [INFO_MPC; output.info];
    KKT_MPC = [KKT_MPC; output.info.kktValue];
    controls_MPC = [controls_MPC; output.u(1,:)];
    %%
    iter = iter+1;i=i+1;
    nextTime = iter*dt; 
    t = [t nextTime];
   
  end   
 
  plot_acado;


%% Obstacles
 % Adding small obstacles
 O_set = [];
 O_set(:,1) = [1.50;1.00];
 O_set(:,2) = [3.40;1.25];
 O_set(:,3) = [7.65;2.80];
 
 safety_margin = .20;

 % Adding bigg obstacles
 O_setBig = [];
%  O_setBig(:,1) = [40;75];
%  safety_margin_big = [40;25];
 % approximation of obstacle to be a square
 numberofSidesObstacle = 4;
 ObstacleArray=[];
%% ### Information of the Project ###
% Maintainer: Giseop Kim 
% Contact: paulgkim@kaist.ac.kr, gisbi.kim@gmail.com
% Latest Version: 2017. 10. 08

%% Setups  
clear; clc; 
addpath('cfg'); addpath('src');  
tic

% Current configuration
cfg_171007;

%% (test version) Load Data (bin -> pointCloud (matlab built-in))
tmp_path= '/media/gskim/Data/NCLT/training/[-310,-455]/2012-02-19/1329678816759801.bin';
% tmp_path= '/media/gskim/Data/NCLT/2012-03-25_vel.tar/2012-03-25_vel/2012-03-25/velodyne_sync/1332701740030057.bin';
ptcloud = SavePointcloudFromBin(tmp_path, color_flag);

%% Load Data (bin -> pointCloud (matlab built-in))
% ptcloud = SavePointcloudFromBin(full_path, false);

%% Draw for debugging
% Points
% pcshow(ptcloud);
% hold on;
% 
% % Observer 
% scatter3(0,0,0,40,'filled', 'r');
% axis equal

%% Split into N pies 
ptcloud_pies = SplitPointcloudIntoPies(ptcloud, Num_pies, color_flag);

%% Rearrange heading of pointcloud (lidar coord -> robot coord(heading))
pie_angle = 360/Num_pies;
heading = rad2deg(heading_GT);
shift_num = ceil(heading/pie_angle);

shifted_ptcloud_pies = ptcloud_pies;

% shifted pointcloud vector 
for i = 1:Num_pies
    j = mod(i + shift_num, Num_pies);
    if(j == 0)
        j = 20;
    end
    shifted_ptcloud_pies{i} = ptcloud_pies{j};
end

%% Draw Partially for debugging

% Select range of pies to draw 
start_ratio = 0;
end_ratio = 1;

% Do not modify this part 
range = [ceil(start_ratio*Num_pies), ceil(end_ratio*Num_pies)];
if(range(1) == 0)
    range(1) = 1;
end

 fig1 = figure(1); %hold on;
% Draw 
for i= range(1):range(2)
    
    % # Choose the Draw-Mode #
    pie = ptcloud_pies{i};        % Option 1: Draw wrt LiDAR Coord.
%     pie = shifted_ptcloud_pies{i};  % Option 2: Draw wrt Robot Coord.

    if(~isempty(pie))
%         gap = 3;
%         if(rem(i,gap) == 0)
            pcshow(pie) % very time consuming work       
            hold on;    
%         end
    end
end

% Observer 
scatter3(0,0,0,40,'filled', 'r');

% heading for debugging
length = 10;
arrow_start = [0 0 0];
% arrow_start = [X_GT, Y_GT, Z_GT]; 
arrow_end = [length*cos(heading_GT) + arrow_start(1), length*sin(heading_GT) + arrow_start(2), 0 + arrow_start(3)];
x_lidar_coord = ptcloud.Location(1,1); 
y_lidar_coord = ptcloud.Location(1,2);
len_lidar_coord = sqrt(x_lidar_coord^2 + y_lidar_coord^2);
arrow_lidar_coord = [(x_lidar_coord/len_lidar_coord)*length + arrow_start(1), ...
                     (y_lidar_coord/len_lidar_coord)*length + arrow_start(2), ...
                     (0 + arrow_start(1))];

line([arrow_start(1) arrow_end(1)]',[arrow_start(2) arrow_end(2)]',[arrow_start(3) arrow_end(3)]', ... 
        'Color','r','LineWidth',2); % robot heading
line([arrow_start(1), 0+10]',[arrow_start(2), 0]',[arrow_start(3) 0]', ... 
        'Color','b','LineWidth',2); % global-x
% line([arrow_start(1), arrow_lidar_coord(1)]',[arrow_start(2), arrow_lidar_coord(2)]',[arrow_start(3) arrow_lidar_coord(3)]', ... 
%         'Color','green','LineWidth',2); % lidar coordinate

% setup 
axis equal
xlim([-100,100]);
ylim([-100,100]);
xlabel('x');
ylabel('y');
view(0,90);

%% Isovist Vector 

isovist = zeros(1, Num_pies);
for i = 1:Num_pies
   pie = ptcloud_pies{i};
   isovist(i) = ComputeIsovistFromPie(pie); % Detail Algorithm should be improved.
end
isovsit_sorted = sort(isovist);


%% End 
toc
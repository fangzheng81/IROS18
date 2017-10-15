%% config
clear; clc; 
addpath('cfg'); addpath('src');  
tic

% Current configuration
cfg_171007;

%% Main Start
pp_path = '/media/gskim/Data/NCLT/training/[-310,-455]/';
% pp_path = '/media/gskim/Data/NCLT/training/[-45,-250]/';

day_list = strsplit(ls(pp_path));
day_list = day_list(~cellfun('isempty',day_list)); % remove empty cell

for i=1:length(day_list)

    day = day_list{i};

    p_path = strcat(pp_path, day, '/');
    files = strsplit(ls(p_path));
    
    for j=1:length(files)
        file = files{j};
        if( ~isempty(file))
            if( file(end-2:end) == 'bin')
                bin_name = file;
            end
        end
    end

    ptcloud = SavePointcloudFromBin( strcat(p_path, bin_name), 1);
    tform = load(strcat(p_path, 'tform.mat'));
    
    % transfom to Global coordinate 
    ptcloud = pctransform(ptcloud, tform.tform);

    i = str2num(strcat(day(1:4), day(6:7), day(9:10)));
    figure(i);
    pcshow(ptcloud)
    hold on;

    %% arrow
    % Observer 
    scatter3(0,0,0,40,'filled', 'r');
    hold on;
    % % heading for debugging
    % length = 10;
    % arrow_start = [0 0 0];
    % % arrow_start = [X_GT, Y_GT, Z_GT]; 
    % arrow_end = [length*cos(heading_GT) + arrow_start(1), length*sin(heading_GT) + arrow_start(2), 0 + arrow_start(3)];
    % x_lidar_coord = ptcloud.Location(1,1); 
    % y_lidar_coord = ptcloud.Location(1,2);
    % len_lidar_coord = sqrt(x_lidar_coord^2 + y_lidar_coord^2);
    % arrow_lidar_coord = [(x_lidar_coord/len_lidar_coord)*length + arrow_start(1), ...
    %                      (y_lidar_coord/len_lidar_coord)*length + arrow_start(2), ...
    %                      (0 + arrow_start(1))];
    % 
    % line([arrow_start(1) arrow_end(1)]',[arrow_start(2) arrow_end(2)]',[arrow_start(3) arrow_end(3)]', ... 
    %         'Color','r','LineWidth',2); % robot heading
    % line([arrow_start(1), 0+10]',[arrow_start(2), 0]',[arrow_start(3) 0]', ... 
    %         'Color','b','LineWidth',2); % global-x


    %% size setup 
    axis equal
    xlim([-100,100]);
    ylim([-100,100]);
    xlabel('x');
    ylabel('y');
    view(0,90);

    print(num2str(i), '-dpng');

end
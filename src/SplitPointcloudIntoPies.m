function [ ptcloud_pies ] = SplitPointcloudIntoPies( ptcloud, Num_pies, color_on )

% ptcloud_pies = {};
%% test 
% tmp_path = '/media/gskim/Data/NCLT/training/[-310,-455]/2013-04-05/1365180457287065.bin';
% ptcloud = SavePointcloudFromBin(tmp_path, 1);
% Num_pies = 60;

%% main 
points_pies = {};

num_points = ptcloud.Count;
angle_one_piece = 360/Num_pies;

for i = 1: Num_pies
%     ptcloud_pies{i} = [];
    points_pies{i} = [];
end    

arr_debug = zeros(1, num_points);
for i=1:num_points
    tmp_xyz = ptcloud.Location(i,:);
    
    if(tmp_xyz == [0 0 0])
        continue;
    end

    tmp_x = tmp_xyz(1);
    tmp_y = tmp_xyz(2);
    tmp_z = tmp_xyz(3);
    ob_x = 0;
    ob_y = 0;
    ob_z = 0;
    
    relative_x = tmp_x - ob_x;
    relative_y = tmp_y - ob_y;
    relative_z = tmp_z - ob_z;
   
    relative_theta = getThetaFromXY(relative_x, relative_y); % degree

    index = ceil(relative_theta/angle_one_piece);
    if(index == 0)
        index = 1;
    end
    arr_debug(i) = index;
    points_pies{index} = [points_pies{index} ; tmp_x, tmp_y, tmp_z];

end

color_table = jet(Num_pies);

for i=1:Num_pies
    pie = points_pies{i};

    if(isempty(pie))
        ptcloud_pies{i} = [];
    else    
        if(color_on)
            num_points_in_pie = size(pie,1);
            color_of_pie = repmat(color_table(i,:), num_points_in_pie, 1);
            ptcloud_pies{i} = pointCloud(pie, 'Color', color_of_pie);
        else
            ptcloud_pies{i} = pointCloud(pie);
        end
    end
end

end


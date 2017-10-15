function [ fig1 ] = DrawTrajectory( jpath )

%% for test 
jpath = '/media/gskim/Data/NCLT/2012-05-26/groundtruth_2012-05-26.csv';
observer_x = -45;
observer_y = -250;
observer_z = 0;

%% Read
GT_table = csvread(jpath);

GT_time = int64(GT_table(:,1));
GT_X = GT_table(:,2);
GT_Y = GT_table(:,3);
GT_Z = GT_table(:,4);

num_points = length(GT_time);
color_table = jet(num_points);
ptcloud_trajectory = pointCloud([GT_X, GT_Y, GT_Z], 'Color', color_table);

%% Infor for drawing 
x_range = ptcloud_trajectory.XLimits;
y_range = ptcloud_trajectory.YLimits;
z_range = ptcloud_trajectory.ZLimits;

%% Draw 
i = ceil(10000 * rand(1));
fig1=figure(i);
pcshow(ptcloud_trajectory);
xlabel(strcat('x: [', int2str(x_range(1)), ', ', int2str(x_range(2)), ']') );
ylabel(strcat('y: [', int2str(y_range(1)), ', ', int2str(y_range(2)), ']') );
zlabel(strcat('z: [', int2str(z_range(1)), ', ', int2str(z_range(2)), ']') );

hold on;
scatter3(observer_x, observer_y, observer_z,'filled');
view(90,-90)

end


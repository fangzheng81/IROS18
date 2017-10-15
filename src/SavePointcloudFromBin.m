function [ ptcloud ] = SavePointcloudFromBin( path, color_on )

%% for test 
% path = '/media/gskim/Data/NCLT/training/[-310,-455]/2012-01-15/1326655085179636.bin';
% color_on = 1;


%% info 
addpath('cfg'); addpath('src');  
cfg_171007;

%% Read Raw Bin file 
raw_data = ReadSingleBin(path);

%% NCLT setup (ref: read_vel_sync.py at homepage http://robots.engin.umich.edu/nclt/)
scaling = 0.005; % 5mm
offset = -100.0;

data_converted = double(raw_data).*scaling + offset;

%% Save 
l = length(raw_data);

x = zeros(l/4, 1);
y = zeros(l/4, 1);
z = zeros(l/4, 1);
r = zeros(l/4, 1);

for i= 1:l/4
    j = (i-1)*4;
%   negative z, because the hardware was mounted upside down. (check here:
%   http://robots.engin.umich.edu/nclt/index.html#documentation)
        x(i) = data_converted(j+1); 
        y(i) = data_converted(j+2); 
        z(i) = (-1) .* data_converted(j+3); % Because its original point is recoreded in the sensor (velodyne32) frame.
        r(i) = data_converted(j+4); % not sure the fourth element is r 
end

num_points = size(x,1);
color_table = jet(num_points);
%% Transformation to body frame
% x_tf
poinsts_homogen = [x'; y'; z'; ones(1,length(x))];
xyz_tf = H_vel_to_body * [x'; y'; z'; ones(1,length(x))];
xyz_tf = xyz_tf(1:end-1,:);

%% Convert into Pointcloud format 

if(color_on)
    ptcloud = pointCloud(xyz_tf', 'Color', color_table);
%     ptcloud = pointCloud([x y z], 'Color', color_table);
else
    ptcloud = pointCloud(xyz_tf');
%     ptcloud = pointCloud([x y z]);
end

%% Downsample a 3-D point cloud (Optional)
% ref: https://kr.mathworks.com/help/vision/ref/pcdownsample.html


end


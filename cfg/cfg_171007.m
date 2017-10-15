%% ### Version: 2017. 10. 07 ###

%% Path 
date = '20120118';
% bin = '1326031631339311.bin';
bin = '1326031631539307.bin';
% bin = '1326031197330853.bin';
% bin = '1326031062327952.bin';

if isunix 
    parent_path = 'data/NCLT-campus/vel/';
    full_path = strcat(parent_path, date, '/', bin);
elseif ispc
    parent_path = 'data\\NCLT-campus\\vel\\';
    full_path = strcat(parent_path, date, '\\', bin);
end

%% (tmp) for sanity check 

%GT for 1326031631339311.bin
if (bin == '1326031631339311.bin')
    utime_GT = 1326031631334541;
    time_GT = utime_GT/(10^(6));
    X_GT = -126.1656223354;
    Y_GT = -284.4761762167;
    Z_GT = 10.5032546137;
    roll_GT = 0.020256155;
    pitch_GT = -0.0015401892;
    heading_GT = 2.9252408117;
end

%GT for 1326031631539307.bin
if (bin == '1326031631539307.bin')
    utime_GT = 1326031631538397;
    time_GT = utime_GT/(10^(6));
    X_GT = -126.3101344808;
    Y_GT = -284.456055437;
    Z_GT = 10.5062471573;
    roll_GT = 0.0188145213;
    pitch_GT = -0.004337092;
    heading_GT = 3.0082813156;
end
				
%GT for 1326031197330853.bin
if (bin == '1326031197330853.bin')
    utime_GT = 1326031197330805;
    time_GT = utime_GT/(10^(6));
    X_GT = -48.7147232083;
    Y_GT = -204.0033741367;
    Z_GT = 3.53633458;
    roll_GT = -0.0316786178;
    pitch_GT = -0.0116489426;
    heading_GT = -1.3283947558;
end

%GT for 1326031062327952.bin
if (bin == '1326031062327952.bin')
    utime_GT = 1326031062325844;
    time_GT = utime_GT/(10^(6));
    X_GT = -23.8253670245;
    Y_GT = -39.3015316274;
    Z_GT = 2.6934836949;
    roll_GT = 0.0205998555;
    pitch_GT = 0.2727774815;
    heading_GT = 3.0601371758;
end
					
%% Number of pies 
Num_pies = 60; 

%% flags 
color_flag = true;
   
%% transformation matrix 

%% Transformation matrix 

% transformation matrix 1
x_trs_body_to_vel = 0.002;
y_trs_body_to_vel = -0.004;
z_trs_body_to_vel = -0.957;
x_rot_body_to_vel = deg2rad(-0.807); % x_rot
y_rot_body_to_vel = deg2rad(-0.166); % y_rot
z_rot_body_to_vel = deg2rad(+90.703); % z_rot 

H_vel_to_body = makeTransformMarix(x_trs_body_to_vel, y_trs_body_to_vel, z_trs_body_to_vel, x_rot_body_to_vel, y_rot_body_to_vel, z_rot_body_to_vel);

% % transformation matrix 1
% x_trs_global_to_body = 0.002;
% y_trs_global_to_body = -0.004;
% z_trs_body_to_vel = -0.957;
% x_rot_body_to_vel = deg2rad(0.807); % x_rot
% y_rot_body_to_vel = deg2rad(0.166); % y_rot
% z_rot_body_to_vel = deg2rad(-90.703); % z_rot 
% 
% H_body_to_global = makeTransformMarix(x_trs_body_to_vel, y, z, x_rot_body_to_vel, y_rot_body_to_vel, z_rot_body_to_vel);




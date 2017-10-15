function [ H ] = makeTransformMarix( x_trs, y_trs, z_trs, x_rot, y_rot, z_rot )

% Good ref: chapter 2.3 (point transformation) and 2.8 (Euler angle), Introduction to robotics (John J. Craig)
R_body_to_vel = [cos(z_rot) -sin(z_rot) 0; sin(z_rot) cos(z_rot) 0; 0 0 1] ...
               *[cos(y_rot) 0 sin(y_rot); 0 1 0; -sin(y_rot) 0 cos(y_rot)] ...
               *[1 0 0; 0 cos(x_rot) -sin(x_rot); 0 sin(x_rot) cos(x_rot)];
t_body_to_vel = [x_trs y_trs z_trs]';

H = [ R_body_to_vel t_body_to_vel; 0 0 0 1];

end


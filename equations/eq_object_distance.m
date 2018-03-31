function h = eq_object_distance(xE,x0,z0)
%
% xE = x coordinate of eye
% x0 = x coordinate of object
% z0 = z coordinate of object

h = sqrt(((x0-xE).^2) + z0.^2);
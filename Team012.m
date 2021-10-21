function [throw] = Team012(mine, theirs)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


num = length(mine);

throw = mod(num + 2, 3);

end


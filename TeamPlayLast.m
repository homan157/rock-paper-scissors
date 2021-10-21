function [throw] = TeamPlayLast(me, you)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

num = length(me);

if num > 0
    throw = you(length);
else
    throw = 1;
end

end


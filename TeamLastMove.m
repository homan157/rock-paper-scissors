function [throw] = TeamLastMove(me, you)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


% Beats whatever the last move was

num = length(me);

if(you(num) == 0)
    throw = 1;
elseif you(num) == 1
    throw = 2;
else
    throw = 3;
end

end


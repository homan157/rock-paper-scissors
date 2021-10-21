function [throw] = TeamBeatLastMovesLastMove(me, you)
% Summary of this function goes here
%   Detailed explanation goes here


% Beats whatever the last move's last moves move will be

num = length(me);

if(you(num) == 0)
    throw = 2;
elseif you(num) == 1
    throw = 0;
else
    throw = 1;
end

end


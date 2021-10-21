function [throw] = TeamJ(my_throws, their_throws)
%RPS Test

num_throws = length(my_throws);

wins = 0;
losses = 0;
throw = -1;

% Count wins losses for a possible trick
if num_throws > 4
    
    for i=1:num_throws
        if my_throws(i) == 0
            if their_throws(i) == 1
                losses = losses + 1;
            elseif their_throws(i) == 2
                wins = wins + 1;
            end
        elseif my_throws(i) == 1
            if their_throws(i) == 2
                losses = losses + 1;
            elseif their_throws(i) == 0
                wins = wins + 1;
            end
        else
            if their_throws(i) == 0
                losses = losses + 1;
            elseif their_throws(i) == 1
                wins = wins + 1;
            end
        end
    end
end

difference = wins - losses;


% Set a baseline
if num_throws < 6
    throw = 1;
    
% Now try to predict as many different algorithms as possible
else
    
    one = their_throws(num_throws);
    two = their_throws(num_throws - 1);
    three = their_throws(num_throws - 2);
    four = their_throws(num_throws - 3);
    five = their_throws(num_throws - 4);
    six = their_throws(num_throws - 5);
    
    % fairly certain its 0, 1, 2 algorithm mod(num_turns, 3)
    if (one + two + three) == 3 && (four + five + six) == 3 && difference > -100
        
        % Check (0,1,2) & (0,2,1)
        if three == 0
            if (two == 1 && one == 2) || (two == 2 && one == 1)
                throw = 1;
            end
        % Check (1,2,0) & (1,0,2)
        elseif three == 1
            if(two == 2 && one == 0) || (two == 0 && one == 2)
                throw = 2;
            end
        % Check (2,0,1) & (2,1,0)
        else
            if(two == 0 && one == 1) || (two == 1 && one == 0)
                throw = 0;
            end
        end 
    end
    
    % Check if just picking one throw
    if (one == two) && (two == three) && (two == four) && (four == five) && (five == six) && throw == -1
        if one == 0
            throw = 1;
        elseif one == 1
            throw = 2;
        else
            throw = 0;
        end
    end
        
    
  
    
    % Debug for any case missed
    if throw == -1
        throw = mod(my_throws(num_throws) + 2, 3);
    end
end


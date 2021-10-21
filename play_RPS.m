function [ winner ] = play_RPS( p1_name, p2_name )
% play_RPS
% Plays two Rock-Paper-Scissors AIs against one another in a best of 1001
% series. Inputs are the names of the functions, and output is the name of
% the winning function.

% initialize counters for who's winning
p1_wins = 0;
p2_wins = 0;
ties = 0;

% preallocate spce for the history vectors
p1_throws = zeros(1001,1);
p2_throws = zeros(1001,1);

% loop over the 1001 games
for m = 1:1001
    % initially assume both plays make legal throws
    p1_illegal_throw = false;
    p2_illegal_throw = false;
    
    % call player 1's function, if it has an error, count that as an
    % illegal thrown and set their throw to 0 (rock)
    try
        new_p1_throw = feval(p1_name,p1_throws(1:(m-1)),p2_throws(1:(m-1)));
    catch
        p1_illegal_throw = true;
        new_p1_throw = 0;
    end
    
    % call player 2's function, if it has an error, count that as an
    % illegal thrown and set their throw to 0 (rock)
    try
        new_p2_throw = feval(p2_name,p2_throws(1:(m-1)),p1_throws(1:(m-1)));
    catch
        p2_illegal_throw = true;
        new_p2_throw = 0;
    end
    
    % check that the returned throws are either 0 (rock), 1 (paper), or 2
    % (scissors), if not flag that player's throw to illegal
    if ~isequal(new_p1_throw,0) && ~isequal(new_p1_throw,1) && ~isequal(new_p1_throw,2)
        p1_illegal_throw = true;
        new_p1_throw = 0;
    end
    if ~isequal(new_p2_throw,0) && ~isequal(new_p2_throw,1) && ~isequal(new_p2_throw,2)
        p2_illegal_throw = true;
        new_p2_throw = 0;
    end
        
    % add the returned throws to the history
    p1_throws(m) = new_p1_throw;
    p2_throws(m) = new_p2_throw;
    
    % determine if the game is a tie: eith both legal throws are the same,
    % or both throws were illegal
    if (new_p1_throw == new_p2_throw && ~p1_illegal_throw && ~p2_illegal_throw) || (p1_illegal_throw && p2_illegal_throw)
        ties = ties + 1;
    % otherwise, if player 1's throw was legal, check if it beats player
    % 2's throw: 0 beats 2, 1 beats 0, and 2 beats 1 
    % (or if player 2's throw was illegal, player 1 wins)
    elseif ~p1_illegal_throw && ...
            ((new_p1_throw == 0 && new_p2_throw == 2) || ...
            (new_p1_throw == 1 && new_p2_throw == 0) || ...
            (new_p1_throw == 2 && new_p2_throw == 1) || ...
            p2_illegal_throw)
        p1_wins = p1_wins + 1;
    % if it's not a tie, and player 1 didn't win, player 2 wins
    else
        p2_wins = p2_wins + 1;
    end
end

% announce the winner and give stats
% (if it's overall a tie, determine the winner randomly)
if p1_wins == p2_wins
    fprintf('%s ties %s %i-%i-%i, winner is chosen randomly\n',p1_name, p2_name, p1_wins, p2_wins, ties)
    if randi([0,1])
        winner = p1_name;
    else
        winner = p2_name;
    end
elseif p1_wins > p2_wins
    fprintf('%s defeats %s %i-%i-%i\n',p1_name, p2_name, p1_wins, p2_wins, ties)
    winner = p1_name;
else
    fprintf('%s defeats %s %i-%i-%i\n',p2_name, p1_name, p2_wins, p1_wins, ties)
    winner = p2_name;
end

end


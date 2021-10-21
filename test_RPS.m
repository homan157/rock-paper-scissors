function [passed_tests] = test_RPS(fname)
% test_RPS Tests a Rock-Paper-Scissors AI for tournament play. Input is the
% name of the function, and output is true or false. Also prints messages
% to the scren for each test.

passed_tests = true;

fprintf('\nFirst game test.\n')
fprintf('In the first game against an opponent, empty arrays are input.\n');
fprintf('Your function should return a 0, 1, or 2.\n');
fprintf('INPUT: [], []\n')
first_throw = feval(fname,[],[]);
fprintf('OUTPUT: %i\n',first_throw)
if ismember(first_throw, 0:2)
    fprintf('PASSED\n');
else
    fprintf('FAILED\n');
    passed_tests = false;
    return
end

fprintf('\nSecond game test.\n')
fprintf('In the second game against an opponent, the opponent''s previous throw can be anything.\n');
fprintf('Your function should return a 0, 1, or 2.\n');
for opp_throw=0:2
    fprintf('INPUT: [%i], [%i]\n',first_throw,opp_throw)
    second_throw(opp_throw+1) = feval(fname,[first_throw],[opp_throw]);
    fprintf('OUTPUT: %i\n',second_throw(opp_throw+1))
    if ismember(second_throw(opp_throw+1), 0:2)
        fprintf('PASSED\n');
    else
        fprintf('FAILED\n');
        passed_tests = false;
        return
    end
end

fprintf('\nThird game test.\n')
fprintf('By the third game, the inputs are vectors.\n');
fprintf('Your function should return a 0, 1, or 2.\n');
for opp_throw1=0:2
    for opp_throw2=0:2
        fprintf('INPUT: [%i,%i], [%i,%i]\n',first_throw,second_throw(opp_throw1+1),opp_throw1,opp_throw2)
        third_throw = feval(fname,[first_throw,second_throw(opp_throw1+1)],[opp_throw1,opp_throw2]);
        fprintf('OUTPUT: %i\n',third_throw)
        if ismember(third_throw, 0:2)
            fprintf('PASSED\n');
        else
            fprintf('FAILED\n');
            passed_tests = false;
            return
        end
    end
end

fprintf('\nBart Simpson test.\n')
fprintf('Your function should defeat Bart Simpson.\n');
human_throws = [];
for game=1:1001
    bart_throws = zeros(1,game-1);
    human_throws(game) = feval(fname,human_throws,bart_throws);
end
player_wins = sum(human_throws==1);
bart_wins = sum(human_throws==2);
ties = sum(human_throws==0);
errors = 1001-player_wins-bart_wins-ties;
if errors > 0
    fprintf('%i illegal throws in series.\n',errors);
    fprintf('FAILED\n');
    passed_tests = false;
    return
end

if player_wins > bart_wins
    fprintf('%s defeats bartS %i-%i-%i\n',fname, player_wins, bart_wins, ties)
    fprintf('PASSED\n');
elseif bart_wins > player_wins
    fprintf('bartS defeats %s %i-%i-%i\n',fname, player_wins, bart_wins, ties)
    fprintf('FAILED\n');
    passed_tests = false;
    return
else
    fprintf('%s ties bartS %i-%i-%i\n',fname, player_wins, bart_wins, ties)
    fprintf('FAILED\n');
    passed_tests = false;
    return
end

fprintf('\nRandomness test.\n')
fprintf('Your function should give the same output for a given input. Random numbers are not allowed.\n');
new_human_throws = [];
for game=1:1001
    bart_throws = zeros(1,game-1);
    new_human_throws(game) = feval(fname,new_human_throws,bart_throws);
end
if isequal(human_throws,new_human_throws)
    fprintf('PASSED\n');
else
    fprintf('FAILED\n');
    passed_tests = false;
    return
end

end


rd = randi(10000);
rand('seed',rd); randn('seed',rd); 
for i = 1:500
    try 
        MotomanPush_learn_slow;
        break;
    catch ME
        disp(ME);
        fprintf('REtrying...\n');
    end
end
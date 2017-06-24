rd = randi(10000);
rand('seed',rd); randn('seed',rd); 
% for i = 1:1000000
%     try 
        MotomanPush_learn;
%         break;
%     catch ME
%         disp(ME);
%         fprintf('REtrying...\n');
%     end
% end
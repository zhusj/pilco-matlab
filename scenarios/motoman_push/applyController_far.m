%% applyController.m
% *Summary:* Script to apply the learned controller to a (simulated) system
%
% Copyright (C) 2008-2013 by
% Marc Deisenroth, Andrew McHutchon, Joe Hall, and Carl Edward Rasmussen.
%
% Last modified: 2013-06-04
%
%% High-Level Steps
% # Generate a single trajectory rollout by applying the controller
% # Generate many rollouts for testing the performance of the controller
% # Save the data

%% Code
% 1. Generate trajectory rollout given the current policy
if isfield(plant,'constraint'), HH = maxH; else HH = H; end
cost_far = cost;
cost_far.target = [0.65 1.0 0.66]'; 
policy_far = policy;
policy_far.maxU = 1.0; 

[xx, yy, realCost_far{j+J}, latent_far{j}, dist_far{j}] = ...
  rollout(gaussian(mu0, S0), policy_far, HH, plant, cost_far);
disp(xx);                           % display states of observed trajectory
% x = [x; xx]; y = [y; yy];                            % augment training set
% if plotting.verbosity > 0
%   if ~ishandle(3); figure(3); else set(0,'CurrentFigure',3); end
%   hold on; plot(1:length(realCost{J+j}),realCost{J+j},'r'); drawnow;
% end



% 3. Save data

filename = [dt '/' basename num2str(j) '_H_far' num2str(H)]; save(filename);

%% cartPole_learn.m
% *Summary:* Script to learn a controller for the cart-pole swingup
%
% Copyright (C) 2008-2013 by
% Marc Deisenroth, Andrew McHutchon, Joe Hall, and Carl Edward Rasmussen.
%
% Last modified: 2013-03-27
%
%% High-Level Steps
% # Load parameters
% # Create J initial trajectories by applying random controls
% # Controlled learning (train dynamics model, policy learning, policy
% application)

%% Code
% rng('default');
imax = 100;
for iter = 1:imax
% 1. Initialization
clear; close all;
settings_cp;                      % load scenario-specific settings
basename = 'MotomanPush_';           % filename used for saving data

% ros
rosshutdown
rosinit

% 2. Initial J random rollouts
for jj = 1:J
  [xx, yy, realCost{jj}, latent{jj}] = ...
    rollout(gaussian(mu0, S0), struct('maxU',policy.maxU), H, plant, cost);
  x = [x; xx]; y = [y; yy];       % augment training sets for dynamics model
  % if plotting.verbosity > 0;      % visualization of trajectory
  %   if ~ishandle(1); figure(1); else set(0,'CurrentFigure',1); end; clf(1);
  %   draw_rollout_cp;
  % end
  
end

mu0Sim(odei,:) = mu0; S0Sim(odei,odei) = S0;
mu0Sim = mu0Sim(dyno); S0Sim = S0Sim(dyno,dyno);

dt = datestr(datetime('now'),30);
mkdir(dt)

% 3. Controlled learning (N iterations)
for j = 1:N
  trainDynModel;   % train (GP) dynamics model
  learnPolicy;     % learn policy
  applyController; % apply controller to system
  disp(['controlled trial # ' num2str(j)]);
%   if plotting.verbosity > 0;      % visualization of trajectory
%     if ~ishandle(1); figure(1); else set(0,'CurrentFigure',1); end; clf(1);
%     draw_rollout_cp;
%   end
end

end
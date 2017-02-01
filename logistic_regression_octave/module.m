%% Load Data

data = csvread('data_n.txt');
X = data(:, 2:end); y = data(:, 1);

% m represents number of examples
% n represents number of features
[m, n] = size(X);

% Scale features and set them to zero mean
%fprintf('Normalizing Features ...\n');

%[X mu sigma] = featureNormalize(X);

% Add intercept term to X
X = [ones(m, 1) X];

% Initialize fitting parameters
initial_theta = zeros(n + 1, 1);

lambda = 1;

[cost, grad] = costFunction(initial_theta, X, y,lambda);

fprintf('Cost at initial theta (zeros): %f\n', cost);
% fprintf('Gradient at initial theta (zeros): \n');
% fprintf(' %f \n', grad);

fprintf('\nProgram paused. Press enter to continue.\n\n');
pause;
options = optimset('GradObj', 'on', 'MaxIter', 400);

%  Run fminunc to obtain the optimal theta
%  This function will return theta and the cost 
[theta, cost] = ...
	fminunc(@(t)(costFunction(t, X, y,lambda)), initial_theta, options);

% Print theta to screen
fprintf('Cost at theta found by fminunc: %f\n', cost);
% fprintf('theta: \n');
% fprintf(' %f \n', theta);

% Compute accuracy on our training set
p = predict(theta, X);

fprintf('\nTrain Accuracy: %f\n', mean(double(p == y)) * 100);

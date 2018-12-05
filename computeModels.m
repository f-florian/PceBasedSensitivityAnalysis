function [iDistr,SobolOpts,tests] = computeModels(allOptions, distributions, sample)
modelList=allOptions.models;
opts=allOptions.side;

% function for getting size(A)(1)
fsize = @(A) subsref(size(A), struct('type', '()', 'subs', {{1}}));

% Setup input
for idx = 1 : size(distributions,1)
    iDistr.Marginals(idx).Type = distributions{idx,1};
    iDistr.Marginals(idx).Parameters = distributions{idx,2};
    iDistr.Marginals(idx).Name = distributions{idx,3}; 
end
myInput = uq_createInput(iDistr);

% Select the sensitivity tool in UQLab and specify Sobol analysis
SobolOpts.Type = 'Sensitivity';
SobolOpts.Method = 'Sobol';
SobolOpts.Sobol.Order = opts{3,1};          % Maximum order of the Sobol' indices to be calculated
SobolOpts.Sobol.SampleSize = sample;    % Sample size of each variable.

% store result in a cellarray for comparing a general number of
% testcases; format: analysis, results, model
tests = cell(fsize(modelList),4);

for idx = 1 : opts{1,1}; % see other loop for comments
    tic
    tests{idx,3} = uq_createModel(modelList{idx,1});
    tests{idx,1} = uq_createAnalysis(SobolOpts);
    tests{idx,2} = tests{idx,1}.Results;
    tests{idx,4}=toc;
    SobolOpts.Sobol.SampleSize = 100*sample;
end

for idx = 3 : fsize(modelList)
    opts = modelList{idx,1};
    opts.Type = 'Metamodel';
    opts.FullModel = tests{1,3};
    tic
    tests{idx,3} = uq_createModel(opts);                % Create model
    tests{idx,1} = uq_createAnalysis(SobolOpts);        % Create and store the sensitivity analysis in UQLab
    tests{idx,2} = tests{idx,1}.Results;                % Retrieve the analysis results for comparison
    tests{idx,4}=toc;
end

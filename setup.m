% Clear variables from the workspace and reinitialize the UQLab framework
clearvars;
uqlab;

%two possible model are provided by the commands below (two lise
%per model), uncomment the one you want or create yours
[allOptions, distributions]=genInput();
[starts, steps, tests, iDistr]=uq_ODE(100, allOptions, distributions,1e4);
% [allOptions, distributions]=genInput2();
% [starts, steps, tests, iDistr]=uq_ODE(100, allOptions, distributions,1e2);

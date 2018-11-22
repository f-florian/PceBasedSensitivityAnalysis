% Clear variables from the workspace and reinitialize the UQLab framework
clearvars;
uqlab;

%two possible model are provided by the commands below (two lise
%per model), uncomment the one you want or create yours
[modelList, distributions]=genInput();
[starts, steps, tests, iDistr]=uq_ODE(100, modelList, distributions,4,1e4);
% [modelList, distributions]=genInput2();
% [starts, steps, tests, iDistr]=uq_ODE(100, modelList, distributions,3,1e2);

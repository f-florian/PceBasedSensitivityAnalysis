function [allOptions, distributions]=genInput()
% generate input for the actual evaluating function

distributions={
    'Gaussian', [0.514, 0.1], '\beta';
    'Triangular', [0, 0.33, 0.25], '\beta_E';
    'Triangular', [0.1, 0.3, 0.2], '\beta_V';
    'Triangular', [1e-3, 3e-3, 2e-3], '\phi';
};

% 'Gamma', [2, 0.1], 'sigma^-1';
% 'Gamma', [5, 1], 'gamma^-1';

%m-file evaluating r0
modelopts.mFile = 'r0simple';

PCEOpts.MetaType = 'PCE';
PCEOpts.Degree = 5;                     % Specify the maximum polynomial degree (default: sparse PCE expansion)
PCEOpts.ExpDesign.NSamples = 200;       % Specify the size of the experimental design (total cost of the metamodel)

PCEOpts2.MetaType = 'PCE';
PCEOpts2.Degree = 10;                     % Specify the maximum polynomial degree (default: sparse PCE expansion)
PCEOpts2.ExpDesign.NSamples = 200;       % Specify the size of the experimental design (total cost of the metamodel)

PCEOpts3.MetaType = 'PCE';
PCEOpts3.Degree = 5;                     % Specify the maximum polynomial degree (default: sparse PCE expansion)
PCEOpts3.ExpDesign.NSamples = 300;       % Specify the size of the experimental design (total cost of the metamodel)

PCEOpts4.MetaType = 'PCE';
PCEOpts4.Degree = 10;                     % Specify the maximum polynomial degree (default: sparse PCE expansion)
PCEOpts4.ExpDesign.NSamples = 300;       % Specify the size of the experimental design (total cost of the metamodel)

modelList = {
    modelopts, 'MC (1e4)', 53;
    modelopts, 'MC (1e6)', 33;
    PCEOpts3, 'PCE5,300', 40;
    PCEOpts, 'PCE5,200', 20;
    PCEOpts2, 'PCE10,200', 1;
    PCEOpts4, 'PCE10,300', 10;
            }

sideopt = {
    2, 'number of MC inputs';
    4, 'index to output';
    4, 'maximum order';
          }

allOptions.models=modelList;
allOptions.side=sideopt;

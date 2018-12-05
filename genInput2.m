function [allOptions, distributions]=genInput2()
% generate input for the actual evaluating function

distributions={
    'Uniform', [5e-7, 7e-7], 'Speardage';
    'Uniform', [5e-4, 1.5e-3], 'spreadfix';
    'Gaussian', [52, 10], 'gamma0';
};

modelopts.mFile = 'r0';

PCEOpts.MetaType = 'PCE';
PCEOpts.Degree = 5;                     % Specify the maximum polynomial degree (default: sparse PCE expansion)
PCEOpts.ExpDesign.NSamples = 200;       % Specify the size of the experimental design (total cost of the metamodel)

LRAOpts.MetaType = 'LRA';
LRAOpts.Rank = 1:20;                    % Specify the rank range
LRAOpts.Degree = 1:20;                  % Specify the degree range
LRAOpts.ExpDesign.NSamples = 200;       % Specify the size of the experimental design (total cost of the metamodel)

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
    modelopts, 'MC (1e2)', 53;
    PCEOpts3, 'PCE5,300', 40;
    PCEOpts, 'PCE5,200', 20;
    PCEOpts2, 'PCE10,200', 1;
    PCEOpts4, 'PCE10,300', 10;
            }

% modelopts, 'MC (1e6)', 33;
% LRAOpts, 'LRA5,200', 64;

sideopt = {
    1, 'number of MC inputs';
    3, 'index to output';
    3, 'maximum order';
          }

allOptions.models=modelList;
allOptions.side=sideopt;

function [starts, steps, tests, iDistr]=uq_ODE(seed,allOptions, distributions,samplesize)
modelList=allOptions.models;
opts=allOptions.side;

rng(seed); % set the random seed in order to get repreducible tests

% moodel evaluation is done there
[iDistr,SobolOpts,tests] = computeModels(allOptions, distributions, samplesize);

% function for getting size(A)(1)
fsize = @(A) subsref(size(A), struct('type', '()', 'subs', {{1}}));

% report various useful data
for idx = 1 : fsize(tests)
    disp(modelList{idx,2})
    uq_print(tests{idx,1});
end
for idx = 1 : fsize(tests)
    disp(modelList{idx,2})
    disp(tests{idx,4})
end

% set auxiliary data for plot sizes
steps=1/(fsize(tests)+1);
starts=steps - .5;

plotTotal(starts, steps, tests, modelList, iDistr);
plotFirst(starts, steps, tests, modelList, iDistr);


% print results in detail

for idx = 1:fsize(tests)
    fprintf(1, "%s", modelList{idx,2});
    for j=1:length(tests{idx,2}.FirstOrder)
        fprintf(1, " & %.6e", tests{idx,2}.FirstOrder(j))
    end
    fprintf(1, "\n")
end

mainMethod=opts{2,1};

for idx=1:opts{3,1}
    a=tests{mainMethod,2}.AllOrders{idx};
    b=tests{mainMethod,2}.VarIdx{idx};
    idx
    for j=1:size(a)
        fprintf(1,"$\\mathcal{S}_{");
        for h=1:length(b(j,:))
            q=tests{mainMethod,2}.VariableNames(b(j,h));
            fprintf(1,"%s, ", q{1});
        end
        fprintf(1,"}$ & $%e$ \n", a(j));
    end
end
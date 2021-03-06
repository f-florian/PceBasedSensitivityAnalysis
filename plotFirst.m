function plotFirst(start, step, tests, modelList, iDistr)
%  First Order Sobol' indices

% function for getting size(A)(1)
fsize = @(A) subsref(size(A), struct('type', '()', 'subs', {{1}}));

uq_figure('filename','FirstOrderSobolComparison.fig', 'Position', [50 50 500 400])
cm = colormap;
offset=start;
for idx = 1 : fsize(tests);
    uq_bar((1:length(tests{idx,2}.FirstOrder))+offset,tests{idx,2}.FirstOrder, step, 'facecolor', cm(modelList{idx,3},:),'edgecolor', 'none')
    hold on
    offset=offset+step;
end
ylabel('First order Sobol'' indices')
ylim([0 1])
xlim([0 length(tests{idx,2}.FirstOrder)+1])
set(gca, 'xtick', 1:length(iDistr.Marginals), 'xticklabel', tests{2,2}.VariableNames, 'fontsize',14);
xlabel('Variable name', 'fontsize', 14)
w={};
for i=1:fsize(modelList)
    w{i}=modelList{i,2};
end
uq_legend(w,'location', 'northeast', 'fontsize',14);

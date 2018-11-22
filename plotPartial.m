function plotPartial(start, step, tests, modelList, iDistr, orderidx)
% Partial Sobol' indices

% function for getting size(A)(1)
fsize = @(A) subsref(size(A), struct('type', '()', 'subs', {{1}}));

uq_figure('filename','TotalSobolComparison.fig', 'Position', [50 50 800 400])
cm = colormap;
offset=start;
datasize=length(tests{1,2}.AllOrders{orderidx});
for idx = 1 : fsize(tests);
    data=tests{idx,2}.AllOrders{orderidx};
    uq_bar((1:datasize)+offset, data, step, 'facecolor', cm(modelList{idx,3},:),'edgecolor', 'none')
    hold on
    offset=offset+step;
end
ylabel(['Order' orderidx 'Sobol'' indices'])
xlim([0 datasize+1])
set(gca, 'xtick', 1:length(iDistr.Marginals), 'xticklabel', tests{2,2}.VariableNames, 'fontsize',14);
xlabel('Variable name', 'fontsize', 14)
w={};
for i=1:fsize(modelList)
    w{i}=modelList{i,2};
end
uq_legend(w,'location', 'northeast', 'fontsize',14);

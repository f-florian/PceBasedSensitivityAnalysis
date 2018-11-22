function Y = r0simple(sample,param)
% R_0 value and data taken from
% Md. Samsuzzoha, Manmohan Singh, David Lucy. Uncertainty and
% sensitivity analysis of the basic reproduction number of a vaccinated epidemic model of influenza
% http://dx.doi.org/10.1016/j.apm.2012.03.029

data = [
    1/365       %-delta
    5.5e-8      %-mu
    7.140e-5    %+r
    1.857e-4    %-k
    9.3e-6      %-alpha
    1/365       %+theta
    1           %betai
       ];

% length(param)
% length(data)
% maxidx=min(length(param),length(data));
% data(1:maxidx)=param(1:maxidx);

gamma=.2;
sigma=.5;

beta=sample(:,1);
betae=sample(:,2);
betav=sample(:,3);
phi=sample(:,4);
% gamma=sample(:,5);
% sigma=sample(:,6);

delta=data(1);
mu=data(2);
r=data(3);
k=data(4);
alpha=data(5);
theta=data(6);
betai=data(7);

tmpsum = r + alpha + gamma;

Y=beta .* (tmpsum .* betae + betai .* sigma ) ...
  .* (r + theta + betav .* phi) ./ tmpsum ./ ...
  (r + k + sigma) ./ (r + theta + phi);
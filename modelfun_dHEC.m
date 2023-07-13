function [ y ] = modelfun_dHEC( beta, x )

%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

stim_az = x(:, 1); % stimulus azimuth
FP_az = x(:, 2); % fixation point azimuth
nof_AV_stims = x(:, 3); 
AV_data = x(:, 3+(1:(3*nof_AV_stims)));
AV_data = reshape(AV_data, [nof_AV_stims 3]);

bases_HC = AV_data(:, 1)';
bases_EC = AV_data(:, 1)' - AV_data(:, 2)';

beta_out = beta; % glue command


h = beta_out(1); % half-heigh of the saccade related EC bias
s = beta_out(2); % slope of the saccade related EC bias
c = beta_out(3); % coefficient of the center of the FP
w = beta_out(4); %  ...
w_E = beta_out(5);
sigma_H = beta_out(6);
sigma_E = beta_out(7);
d_f = beta_out(8);

% d_f = exp(-d*abs(Tr_FP - FP));
% -log(d_f) = d*abs(Tr_FP - FP);
% d = -log(d_f)/abs(Tr_FP - FP)

b_0 = b_0_fun(stim_az, FP_az, h, s, c);

d = -log(d_f)/22.5; % function inversion

tripple_gauss = 0;
for i = 1:nof_AV_stims
    AV_data_current = AV_data(i, :);
    AV_stim_az = AV_data_current(1);
    AV_FP_az = AV_data_current(2);
    AV_bias = AV_data_current(3);
    FP_sh_az = -AV_FP_az+FP_az;
    
    w_vH = f_wdt(stim_az, AV_stim_az, sigma_H, bases_HC);
    w_vE = f_wdt(stim_az, AV_stim_az + FP_sh_az, sigma_E, bases_EC);
    w_v = (1-w_E) * w_vH + w_E * w_vE;
    d_f = exp(-d*abs(AV_FP_az - FP_az));
    w_v = w_v*d_f;
    b_d = AV_bias - b_0_fun(AV_stim_az, FP_az, h, s, c);
    tripple_gauss = tripple_gauss+ w_v.*b_d;
end

y = b_0 + w*tripple_gauss;
end




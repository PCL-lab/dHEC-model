%% This is example of usage of model. However you can use anything more complex or even simpler.

model_version_id = 4;
fitted_parameters = [1, 2, 1.1, 0.9, 0.3, 12, 5, 0.9];
% Fitted parameters order: h, k, c, w, w_E, sigma_H, sigma_E, d_f
% fitted_parameter_names = {'h', 'k', 'c', 'w', 'w_E', 'sigma_H', 'sigma_E', 'd_f'};

if model_version_id == 4
    modelfun = @modelfun_dHEC;
    filtered_parameter_ids = 1:8;
elseif model_version_id == 3
    modelfun = @modelfun_dHC;
    filtered_parameter_ids = [1 2 3 4 6 8];
elseif model_version_id == 2
    modelfun = @modelfun_HEC;
    filtered_parameter_ids = [1 2 3 4 5 6 7];
elseif model_version_id == 1
    modelfun = @modelfun_HC;
    filtered_parameter_ids = [1 2 3 4 6];
end

fitted_parameters = fitted_parameters(filtered_parameter_ids);

does_use_saccades = 0;
AV_stimulus_azimuths = 7.5*(-1:1);
AV_FP_azimuths = 11.25*[1 1 1];
AV_biases = 5*[1 1 1];

dense_xax = -40:0.1:40;

sz = numel(dense_xax);



FPs = 11.25*[-1 1];

FP_color_letter = {'b','r'}; 

figure();

plot(AV_stimulus_azimuths, AV_biases, 'g-o'); hold on;

for fp_i = 1:2
    y = [];
    for xax_i = 1:sz
        stimulus_azimuth = dense_xax(xax_i);
        probe_FP_azimuth = FPs(fp_i);
        y(end+1) = wrap_modelfun(modelfun, stimulus_azimuth, ...
            probe_FP_azimuth, does_use_saccades, fitted_parameters, ...
            AV_stimulus_azimuths, AV_FP_azimuths, AV_biases);
    end
    plot(dense_xax, y, [FP_color_letter{fp_i} '-']); 
    hold on;
end

axis([-40 40 0 6]);

xlabel('Probe Location (°)');
ylabel('Prediction of Response Bias (°)');
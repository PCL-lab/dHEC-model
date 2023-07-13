function [response_bias] = ...
    wrap_modelfun(modelfun, stimulus_azimuth, ...
    probe_FP_azimuth, does_use_saccades, fitted_parameters, ...
    AV_stimulus_azimuths, AV_FP_azimuths, AV_biases)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if size(AV_stimulus_azimuths, 1) ~= 1
    error('AV_stimulus_azimuths must be line vector');
end

if size(AV_FP_azimuths, 1) ~= 1
    error('AV_FP_azimuths must be line vector');
end

if size(AV_biases, 1) ~= 1
    error('AV_biases must be line vector');
end

if size(AV_stimulus_azimuths, 2) ~= size(AV_FP_azimuths, 2) || size(AV_biases, 2) ~= size(AV_FP_azimuths, 2)
    error('Lengths of AV_stimulus_azimuths, AV_FP_azimuths and AV_biases must be the same')
end

nof_AV_stims = size(AV_stimulus_azimuths, 2);

AV_data(:, 1) = AV_stimulus_azimuths';
AV_data(:, 2) = AV_FP_azimuths';
AV_data(:, 3) = AV_biases';




x = [stimulus_azimuth, probe_FP_azimuth, nof_AV_stims, reshape(AV_data, [1 3*nof_AV_stims])];
beta = fitted_parameters;
if ~ does_use_saccades
    beta(1) = 0;
end
response_bias = modelfun(beta, x);
end


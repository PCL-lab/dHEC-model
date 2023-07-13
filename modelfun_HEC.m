function [ y ] = modelfun_HEC( beta, x )

%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

beta_aux = beta([1 2 3 4 5 6 7 7]);
beta_aux(8) = 1;

y = modelfun_dHEC(beta_aux, x);
end
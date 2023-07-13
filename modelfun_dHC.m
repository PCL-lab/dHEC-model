function [ y ] = modelfun_dHC( beta, x )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
beta_aux = beta([1 2 3 4 4 5 6 6]);
beta_aux(5) = 0;

y = modelfun_dHEC(beta_aux, x);

end


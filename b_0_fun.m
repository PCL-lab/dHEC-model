function [ y ] = b_0_fun( x, FP,  h, s, c )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
y = h*f_sig(s*(x-(-c*FP)));
end


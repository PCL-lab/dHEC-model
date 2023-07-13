function [ y ] = f_wdt( x, mu, sigma, bases )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

den = 0;
mean_b = mean(bases);
for b=bases
    den = den + normpdf(b, mean_b, sigma);
end
y = normpdf(x, mu, sigma)/den;

end


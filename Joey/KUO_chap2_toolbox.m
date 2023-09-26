%%  S5 - APP3 - KUO_chap2_toolbox.M
%   Auteur:     Giuseppe Lomonaco
%   CIP:        LOMG2301

%   Date de creation:                       26-Septembre-2023
%   Date de derniere modification:          26-Septembre-2023

%   DESCRIPTION:    toolbox given for MATLAB in the KUO chapiter 2

clc
close all
clear 


%% toolbox 2-4-1
% Use the MATLAB symbolic toolbox to find the Laplace transforms.
syms t
f = t^4;

F = laplace(f);

disp("-----------------------------------------------------------")
disp("TOOLBOX 2-4-1 - FINDING THE LAPLACE TRANSFORM WITH SYMBOLIC")
disp("-----------------------------------------------------------")
fprintf("The Laplace transform of '%s' is '%s' with \n", f, F)
fprintf("\n\n")





%% toolbox 2-5-1 - 
% clc
% close all
% clear all

disp("-----------------------------------------------------------")
disp("          TOOLBOX 2-5-1 - RESIDUE FONCTION")
disp("-----------------------------------------------------------")
num = [5    3]            % numerator polynomial coefficients
den = [1    6   11  6]     % denominator polynomial coefficients

disp("you can calculate the partial fraction expansion as:") 
[r, p, k] = residue(num, den)

disp("now convert the partial fraction expansion back to polynomial coefficients")
[num2, den2] = residue(r, p, k)

disp("Note that the result is normalized for the leading coefficients in the denominator")
fprintf("\n\n")





%% TOOLBOX 2-5-2 - RATIO OF 2 POLYNOMIAL
% clc
% close all
% clear all

disp("-----------------------------------------------------------")
disp("          TOOLBOX 2-5-2 - RATIO OF 2 POLYNOMIAL")
disp("-----------------------------------------------------------")
disp("Coefficients of polynomial s^4 + 5*s^3 + 9*s^2 + 7*s + 2 (DENOMINATOR)")
den = [1  5   9   7   2]
disp("-----------------------------------------------------------")

disp("Polynomial coefficients of the numerator")
num = [1]
disp("-----------------------------------------------------------")

disp("Using residue function")
[r, p, k] = residue(num, den)
disp("-----------------------------------------------------------")

disp("Obtain the polynomial form")
[num2, den2] = residue(r, p, k)
disp("-----------------------------------------------------------")







%% TOOLBOX 2-6-1 - USING THE INVERSE LAPLACE FUNCTION
% clc
% close all
% clear all

disp("-----------------------------------------------------------")
disp(" TOOLBOX 2-6-1 - USING THE INVERSE LAPLACE FUNCTION")
disp("-----------------------------------------------------------")
disp("The inverse Laplace transform for the following equation is")
disp("obtained using MATLAB Symbolic Toolbox by the following")
disp("sequence of MATLAB functions. (using s and tau as syms)")

syms s tau
F = 1/(tau*s^2 + s);
f = ilaplace(F);
fprintf("\nThe inverse laplace transform of  '%s'  is  '%s' \n", F, f)
disp("-----------------------------------------------------------")

disp("Time response shown next for a given value r=0.1 the graph is obtained")



clear all
t = 0:0.01:1;
tau = 0.1;
plot(1-exp(-t/tau));


disp("You see that at t = 0.1,  y(t) = 0.63 ")










%% TOOLBOX 2-6-2 - TIME RESPONSE FOR A UNIT-STEP INPUT
% clc
% close all
% clear all

disp("-----------------------------------------------------------")
disp(" TOOLBOX 2-6-2 - TIME RESPONSE FOR A UNIT-STEP INPUT")
disp("-----------------------------------------------------------")

num = [1000];
den = [1    34.5    1000];

G = tf(num, den);

step(G)
title('Step Response')
xlabel('Time (sec)')
ylabel('Amplitude')










%% TOOLBOX 2-7-1 - UNIT IMPULSE RESPONSE
% clc
% close all
% clear all

disp("-----------------------------------------------------------")
disp(" TOOLBOX 2-7-1 - UNIT IMPULSE RESPONSE")
disp("-----------------------------------------------------------")

num = [1000];
den = [1    34.5    1000];

G = tf(num, den);

impulse(G);


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





%% TOOLBOX 
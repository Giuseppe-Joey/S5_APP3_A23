%%  S5 - APP3 - FORMATIF - QUESTION2.M
%   Auteur:     Giuseppe Lomonaco
%   CIP:        LOMG2301

%   Date de creation:                       06-Octobre-2023
%   Date de derniere modification:          06-Octobre-2023

%   DESCRIPTION:    pratique formatif question 2

clc
close all
clear all


%% question 2
% soit:
A = [0      1;
    -6      -5];

B = [0;
     1];

C = [1      1];

D = [0];


[num, den] = ss2tf(A, B, C, D)
TF = tf(num, den)

%% b) donner leq. qui permettra de trouver les poles
coefficients = [1   5   6];
Z = roots(coefficients)


%% c) trouver le diff associe a ce modele



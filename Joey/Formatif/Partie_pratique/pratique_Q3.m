%%  S5 - APP3 - FORMATIF PRATIQUE- PRATIQUE_Q3.M
%   Auteur:     Giuseppe Lomonaco
%   CIP:        LOMG2301

%   Date de creation:                       05-Octobre-2023
%   Date de derniere modification:          05-Octobre-2023

%   DESCRIPTION:    pratique formatif pratique question 3

clc
close all
clear all


% soit un systeme decrit par
A = [0          1;
     -100       -4];

B = [0;
     1];

C = [1      0];

D = [0];






%% a) calculer et tracer la repomse a limpulsion

[num, den] = ss2tf(A, B, C, D);
TF = tf(num, den)

figure
impulse(TF)
title("Reponse impulsionnelle Originale")
grid on




%% b) reponse a un echelon de 50
t = 0:0.01:10;
u1 = 50 * ones(size(t));

y0 = lsim(num, den, u1, t);

figure
plot(t, y0)
grid on



%% c) simuler la repnse des etats x(t) = [x1(t)    x2(t)]' lorsque lentree est:
% u(t) = 100 pour 0 <= t < 2
% u(t) = 20  pour t > 2

t = 0:0.01:10;
u = zeros(size(t));
u(t<2) = 100;
u(t>=2) = 20;

sys = ss(A, B, C, D);

x0 = [  0     1]';

yC = lsim(sys, u, t, x0)

y = lsim(num, den, u1, t)

figure
plot(t, yC, t, y)

















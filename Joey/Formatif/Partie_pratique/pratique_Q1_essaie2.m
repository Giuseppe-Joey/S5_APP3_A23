%%  S5 - APP3 - FORMATIF PRATIQUE- PRATIQUE_Q1.M
%   Auteur:     Giuseppe Lomonaco
%   CIP:        LOMG2301

%   Date de creation:                       05-Octobre-2023
%   Date de derniere modification:          05-Octobre-2023

%   DESCRIPTION:    pratique formatif pratique question 1

clc
close all
clear all


num = [1.5      28.5        202.8       652.2       740.4];
den = [1        23          210         950         2044        1632];


TF = tf(num, den);



% reduction de la fonction
[R, P, K] = residue(num, den);
poid = abs(R)./abs(real(P));
zeta = (-real(P)) ./ abs(P)
[numR, denR] = residue(R(4:5), P(4:5), K);

% ajustement du gain DC
gain0 = dcgain(num, den);
gainR = dcgain(numR, denR);
numR = numR * (gain0/gainR);

% nouvelle FT
TFR = tf(numR, denR)



%% b) comparer la rep a un echelon unitaire du sys reduit a celui original
t = 0:0.01:10;
u = ones(size(t));

y0 = lsim(num, den, u, t);
yR = lsim(numR, denR, u, t);

figure
plot(t, y0, t, yR)
title("Reponse a un echelon unitaire")
legend("FT originale", "FT reduite")
grid on



%% c) calculer le facteur damortissement
zeta = (-real(P)) ./ abs(P)
% le facteur damortissement 



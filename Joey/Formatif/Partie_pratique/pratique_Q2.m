%%  S5 - APP3 - FORMATIF PRATIQUE- PRATIQUE_Q2.M
%   Auteur:     Giuseppe Lomonaco
%   CIP:        LOMG2301

%   Date de creation:                       05-Octobre-2023
%   Date de derniere modification:          05-Octobre-2023

%   DESCRIPTION:    pratique formatif pratique question 2

clc
close all
clear all


load("DonneesIdentifMasseRessortAmorti.mat")


% figure
% plot(t, x)
% 
% figure
% plot(t, Fext)



% methode didentification par moindres carres
dt = t(2) - t(1);
dx = diff(x) / dt;
d2x = diff(dx) / dt;

% on reduit de 1 dx et de 2 Fext, t et x
dx = dx(1:end-1);
Fext = Fext(1:end-2);
t = t(1:end-2);
x = x(1:end-2);

% pour moindre carre
X = [Fext    dx     d2x];
R = X'*X;
P = X'*x;

A = inv(R)*P

k = 1 / A(1)
b = -k * A(2)
m = -k * A(3)


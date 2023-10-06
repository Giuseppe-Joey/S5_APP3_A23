clc;clear;close all
load donnees_moteur_2016

dt = t(2:end) - t(1:end-1);
%Force d'Entree
X1 = tension;

%Premiere derivee
X2 = diff(vitesse)./dt;
X = [X1(1:end-1) X2];

%Vecteur de sortie
Y = vitesse(1:end-1);

%Matrice de correlation
R = X'*X;
P = X'*Y;

%Coefficients
A = inv(R)*P

Bm = (0.0649/A(1)) - 0.031
Jm = -A(2)*(Bm + 0.031)

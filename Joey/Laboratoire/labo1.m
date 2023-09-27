%%  S5 - APP3 - PROBLEMATIQUE - XXXXXX_XXXXXXX_XXXXXXX.M
%   Auteur:     Giuseppe Lomonaco
%   CIP:        LOMG2301
%   Auteur:     Jean Dodie Ombeni
%   CIP:        OMBJ2301
%   Auteur:     Anthony Royer
%   CIP:        ROYA2019

%   Date de creation:                       26-Septembre-2023
%   Date de derniere modification:          26-Septembre-2023

%   DESCRIPTION:    laboratoire 1

clc
close all
clear 




% load("DonneesIdentifSyst1erOrdre_2.mat")




%% EXERCICE 1 - MOINDRES CARRES
disp("EXERCICE 1 - MOINDRES CARRES")
load("DonneesIdentifSyst1erOrdre_1.mat")

%                                 ____________
% de base on a          R(s) -->  | K/(1+Ts) |  --> Y(s)
%                                 ____________

figure
plot(t, y)
grid on

X1 = [u(1:end-1)];
X2 = -diff(y)./diff(t);

X = [X1 X2];
Y = [y(1:end-1)];

P = X'*Y;
R = X'*X;

% la matrice A contient les parametres K et T
A = inv(R) * P;
K = A(1)
T = A(2)









%% EXERCICE 2 - notes de cours JdeL polesmodesdominants sect 5 num na), b) et c) de lex 1
% utiliser les fonction   tf    series  parallel    residue     dcgain  step
disp("EXERCICE 2 - POLES DOMINANTS")

% fonction de transfert 1
num1 = [2   6.4];
den1 = [1    8];
tf1 = tf(num1,den1)

%fonction de transfert 2
num2 = [25];
den2 = [1   14.8    61.7    47  25];
tf2 = tf(num2, den2)

%fonction de transfert 3
num3 = [3];
den3 = [1   3];
tf3 = tf(num3, den3)

% fonction de transfert et 
G = tf1*tf2*tf3

% 1 - le v signifie quon veut le vecteur
[numG, denG] = tfdata(G, 'v')
[R, P, K] = residue(numG, denG) 

% 2 - trouver le ratio du pole dominant
ratio = abs((R)./real(P))

% 3 - calculer la fonction de transfert du systeme reduit determine a partir
% des poles dominants --- dans cet exemple, on suppose que les poles i et j
% ont les valeurs les plus elevees du ratio definit ci dessus (poles
% dominants), ici le 5e et 6e selon le ratio
[num_reduit, den_reduit] = residue(R(5:6), P(5:6), K);


% 4 - Correction du gain DC du systeme reduit
gain_0 = dcgain(numG, denG);
gain_reduit = dcgain(num_reduit, den_reduit)
num_reduit_2 = num_reduit * (gain_0/gain_reduit)












%% EXERCICE 3













%% EXERCICE 4










%% EXERCICE 5








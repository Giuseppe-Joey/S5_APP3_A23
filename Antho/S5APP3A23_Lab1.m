%%  S5 - APP3 - Laboratoire - S5APP3A23_Lab1.M
%   Auteur:     Anthony Royer
%   CIP:        ROYA2019

%   Date de creation:                       27-Septembre-2023
%   Date de derniere modification:          27-Septembre-2023

%   DESCRIPTION:    Laboratoire 1
%                   

clc
close all
clear 

% Contrôles du comportement du code
showImportedData = 0;
showFigures = 1;

%% Probleme 1 - Moindres Carrés
disp("=================================")
disp("=========== Problème 1 ==========")
disp("=================================")
load DonneesIdentifSyst1erOrdre_1.mat

if showImportedData == 1
    figure('Name','DonneesIdentifSyst1erOrdre_1')
    plot(t,y)
    grid on
end

% Quand X tends vers l'infini, Y tends vers K

Xin1 = u(1:end-1);
dt = diff(t);
Xout1 = -diff(y)./dt;  % Appelé Ydot dans les notes
Ymat = y(1:end-1);
Xmat = [Xin1 Xout1];

A1 = pinv(Xmat)*Ymat;
K1 = A1(1);
T1 = A1(2);

disp(['La valeur de K est : ', num2str(K1)])
disp(['La valeur de T est : ', num2str(T1), ' s'])
disp(' ')

%% Probleme 2 - Fonctions de transfert et pzmap
disp("=================================")
disp("=========== Problème 2 ==========")
disp("=================================")

num_DynAct = [2 6.4];
den_DynAct = [1 8];
num_SysDynFlex = [25];
den_SysDynFlex = [1 14.8 61.7 47 25];
num_DynCap = [3];
den_DynCap = [1 3];

tf_DynAct = tf(num_DynAct,den_DynAct);
tf_SysDynFlex = tf(num_SysDynFlex, den_SysDynFlex);
tf_DynCap = tf(num_DynCap,den_DynCap);

%% (A) - Trouver la fonction de transfert entre u(t) et y(t) avec series
% Fonctions Matlab utiles : tf series parallel residue dcgain step
tf_complet = series(tf_DynAct,series(tf_SysDynFlex,tf_DynCap))
[num_complet, den_complet] = tfdata(tf_complet, 'v');
figure('Name','Pôles-Zeros')
pzmap(tf_complet)
disp(" ")
% Plus proche de l'axe des img, plus le poids est elevé
%% (B) - Réduire le modèle à ses pôles dominants avec fractions partielles
% Step 1 -  Calcul des pôles et leurs résidus
[Residus2,Poles2,K2] = residue(num_complet, den_complet)
% Step 2 - Choisir le pole (reduction a un sys de deg 1) ou les deux poles
% (reduction a un sys deg 2) qui ont le svaleurs les plus elevés avec ratio
poids = abs(Residus2)./real(Poles2)
% Step 3 - Calculer la fonction de transfert du sys reduit déterminé a
% partir des poles dominants

% Selon le output de mon poids, je prends les 5e et 6e
% on recrée la fonction mais en gardant juste le plus important
[num_reduit,den_reduit] = residue(Residus2(5:6),Poles2(5:6),K2);
tf_reduit = tf(num_reduit,den_reduit);

% Step 4 - Correction du gain DC du systeme reduit
gain_initial = dcgain(num_complet, den_complet);
gain_reduit = dcgain(num_reduit,den_reduit);
gain_rapport = gain_initial/gain_reduit;
num_reduit2 = num_reduit*gain_rapport;
tf_reduit2 = tf(num_reduit2,den_reduit)

%% (C) - Comparer la réponse des deux systèmes à un échelon
figure('Name','Lab1 Prob 2')
hold on
stepplot(tf_complet)
stepplot(tf_reduit2)
hold off
grid on

%% Probleme 3 - Équations differentielles
disp("=================================")
disp("=========== Problème 3 ==========")
disp("=================================")
% Fonctions Matlab utiles : tf lsim tf2ss
t3 = [0:0.01:25]';
u3 = zeros(size(t3));
u3((t3 >= 0) &(t3 < 2)) = 2;
u3((t3 >= 2)) = 0.5;

% Une fonction de transfert est l'entrée sur la sortie, donc 
num6 = [1 2];
den6 = [1 1 0.25];
tf6 = tf(num6,den6);

% [A,B,C,D] = tf2ss(num6,den6);
Ymat2 = lsim(tf6,u3,t3);

figure('Name','Probleme 3')
plot(t3,Ymat2)
grid on;





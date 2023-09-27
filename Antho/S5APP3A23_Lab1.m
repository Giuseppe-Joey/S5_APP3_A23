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

showImportedData = 0;
%% Probleme 1 - Moindres Carrés
disp("=================================")
disp("=========== Problème 1 ==========")
disp("=================================")
load DonneesIdentifSyst1erOrdre_1.mat

if showImportedData == 1
    figure()
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




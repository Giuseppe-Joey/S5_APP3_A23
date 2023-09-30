%%  S5 - APP3 - PROBLEMATIQUE - PROBLEMATIQUE.M
%   Auteur:     Giuseppe Lomonaco
%   CIP:        LOMG2301
%   Auteur:     Jean Dodie Ombeni
%   CIP:        OMBJ2301
%   Auteur:     Anthony Royer
%   CIP:        ROYA2019

%   Date de creation:                       30-Septembre-2023
%   Date de derniere modification:          30-Septembre-2023

%   DESCRIPTION:    fffffffffffffffffffffffffffffffffffffffffffffffffffff
%                   ggggggggggggggggggggggggggggggggggggggggggggggggggggg

clc
close all
clear all


%% DONNEES DU PROBLEME
disp(" Paramètre        Valeur         Unité          Description ");
disp(" ---------------------------------------------------------- ");
Kp =            0.318;          % V/rad
K =             100;            %                   gain ampli 
tau =           0.01;           % Cste de temps ampli en seconde
Ki =            0.5;            % Cste de couple du moteur en N-m/A
Kb =            0.5;             % Cste de force contreélectromotrice (fcém) du moteur en V/rad/s
Ra =            8;              % résistance armature du moteur en Ohm
La =            0.008;          % inductance armature du moteur en H
Jm =             0.02;          % inertie armature en N-m s2/rad
Bm =            0.01;           % frottement visqueux armature en N.m/rad/s
N =             0.1;            % facteur de réduction 
JL =            1;              % inertie charge en N.m s2/rad
BL =            1;              % frottement visqueux charge en N-m/rad/s

fprintf("    Kp             %.3f         V/rad           \n", Kp)
fprintf("    K              %.0f                          gain ampli \n", K)
fprintf("   tau             %.2f             s        Cste de temps ampli \n", tau)
fprintf("    Ki             %.1f          N-m/A       Cste de couple du moteur \n", Ki) 
fprintf("    Kb             %.1f          V/rad/s   Cste de force contreélectromotrice (fcém) du moteur \n", Kb) 
fprintf("    Ra             %.0f              Ohm     résistance armature du moteur \n", Ra) 
fprintf("    La             %.3f             H      inductance armature du moteur \n", La)
fprintf("    Jm             %.2f          N-m s2/rad       inertie armature \n", Jm) 
fprintf("    Bm             %.2f          N.m/rad/s     frottement visqueux armature \n", Bm) 
fprintf("    N              %.1f                           facteur de réduction \n", N)
fprintf("    JL             %.0f             N.m s2/rad         inertie charge \n", JL) 
fprintf("    BL             %.0f             N-m/rad/s       frottement visqueux charge \n", BL)















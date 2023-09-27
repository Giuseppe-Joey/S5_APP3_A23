%%  ESCOOTER_POWER.M
%   Auteur:     Giuseppe Lomonaco
%   CIP:        LOMG2301

%   Date de creation:                       26-Septembre-2023
%   Date de derniere modification:          26-Septembre-2023

%   DESCRIPTION:    fffffffffffffffffffffffffffffffffffffffffffffffffffff
%                   ggggggggggggggggggggggggggggggggggggggggggggggggggggg

clc
close all
clear 

m = 70;                 % masse de Joey
g = 9.81;               % acceleration gravitationnelle
u1 = 0.7;               % coefficient de friction MIN entre pneu et route
u2 = 0.9;               % coefficient de friction MAX entre pneu et route


v = 0:1:30;             % vitesse en km/h
Fapp = 617.75;          % Force appliquée en Newtons
Work = Fapp.*v;         % travail de la force de friction






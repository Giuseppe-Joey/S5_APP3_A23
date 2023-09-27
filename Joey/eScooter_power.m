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


v = 0:1:20;             % vitesse en km/h
Fapp = 617.75;          % Force appliquée en Newtons
% Work = Fapp.*v;         % travail de la force de friction



% Initialiser un vecteur pour stocker la puissance à chaque vitesse
P = zeros(size(v));

% Calculer la puissance à chaque vitesse
for i = 1:length(v)
    P(i) = Fapp * v(i);
end

% Afficher les résultats
% disp('Vitesse (m/s)   Puissance (W)');
% disp([v' P']);

figure
plot(v*3.6, P/1000)
xlabel("Vitesse (km/h)")
ylabel("Puissance (kW)")
grid on



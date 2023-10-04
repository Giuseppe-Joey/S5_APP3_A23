%%  S5 - APP3 - PROBLEMATIQUE - PROBLEMATIQUE.M
%   Auteur:     Giuseppe Lomonaco
%   CIP:        LOMG2301
%   Auteur:     Jean Dodie Ombeni
%   CIP:        OMBJ2301
%   Auteur:     Anthony Royer
%   CIP:        ROYA2019

%   Date de creation:                       30-Septembre-2023
%   Date de derniere modification:          03-Octobre-2023

%   DESCRIPTION:    fichier de calculs de la problématique

close all
clear
clc

%% DONNEES DU PROBLEME
disp(" Paramètre        Valeur         Unité          Description ");
disp(" ---------------------------------------------------------- ");
Kp =            0.318;          % V/rad
K =             100;            % gain ampli 
tau =           0.01;           % Cste de temps ampli en seconde
Ki =            0.5;            % Cste de couple du moteur en N-m/A
Kb =            0.5;            % Cste de force contreélectromotrice (fcém) du moteur en V/rad/s
Ra =            8;              % résistance armature du moteur en Ohm
La =            0.008;          % inductance armature du moteur en H
Jm =            0.02;           % inertie armature en N-m s2/rad
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

%% Construction du modele ABCD
JmN2Jl = Jm + (N.^2)*JL;
BmN2Bl = Bm + (N.^2)*BL;

A1 = [0 1 0 0;
     0 (-BmN2Bl/JmN2Jl) (N*Ki/JmN2Jl) 0;
     0 (-Kb/(N*La)) (-Ra/La) (1/La);
     0 0 0 (-1/tau)];
B1 = [0 0 0 (K/tau)]';
C1 = [1 0 0 0];
D1 = [0];


%FTBF et FTBO numerique
[NUM1,DEN1] = ss2tf(A1,B1,C1,D1);
FTBO = tf(NUM1,DEN1)
FTBF = Kp*feedback(FTBO, Kp) % Kp gain de potentiometre donc lentre et le feedback est touche


numa = [K];
dena = [tau 1];
numb = [N*Ki];
denb = [(JmN2Jl*La) (Ra*JmN2Jl + La*BmN2Bl) (BmN2Bl*Ra + Ki*Kb) 0];

tfa = tf(numa,dena);
tfb = tf(numb/2.4e-06,denb/2.4e-06);
FTBO_a_bras = tfa*tfb
[NumBO,DenBO] = tfdata(FTBO_a_bras, 'v');
FTBF_a_bras = tf(Kp*NUM1,(DEN1 + Kp*NUM1))


t = [0:0.01:50]';
stepp = ones(size(t));

% Affichage
figure('Name','Simulation de lerreur avec une entree echelon')
plot(t, lsim(FTBF, stepp, t))
xlabel('Time (s)')
ylabel('Amplitude')
xlim([0 10])
grid on


%f) 2 - Reduction numerique:
figure('Name','PZmap FTBO')
pzmap(FTBO)
[R, P, Kq] = residue(NumBO,DenBO)
poids = abs(R)./real(P)
[B,A] = residue(R(3:4),P(3:4),Kq); %a modifier selon les poids
tfss = tf(B,A);

% On ne se sert pas de cela car FTBO est instable
% K1 = dcgain(FTBO);
% K2 = dcgain(tfss);
% KK = K2/K1;
% Kn = 1/KK;
% TF = tfss*Kn;

TF = tfss
FTBF_Red_num = Kp*feedback(tfss,Kp)

% Rduction physique

num_red_phy = [N*Ki*K];
den_red_phy = [Ra*JmN2Jl Ra*BmN2Bl Kb*Ki]
FTBO_red_phy = tf(num_red_phy,den_red_phy)
FTBF_red_phy = Kp*feedback(FTBO_red_phy,Kp)

% Affichage

figure('Name','Réponse à un échelon en BO')
hold on
subplot(3,1,1)
step(FTBO)
legend('FTBO')
grid on
subplot(3,1,2)
step(TF)
legend('FTBO_reduite num')
grid on
subplot(3,1,3)
step(FTBO_red_phy)
legend('FTBO_reduite physique')
grid on
hold off

figure('Name','Réponse Impulsionnelle en BO')
hold on
subplot(3,1,1)
impulse(FTBO)
legend('FTBO')
grid on
subplot(3,1,2)
impulse(TF)
legend('FTBO_reduite num')
grid on
subplot(3,1,3)
impulse(FTBO_red_phy)
legend('FTBO_reduite physique')
grid on

% En BF
figure('Name','Réponse à un échelon en BF')
hold on
subplot(3,1,1)
step(FTBF)
legend('FTBF')
grid on
subplot(3,1,2)
step(FTBF_Red_num)
legend('FTBF_reduite num')
grid on
subplot(3,1,3)
step(FTBF_red_phy)
legend('FTBF_reduite physique')
grid on
hold off

figure('Name','Réponse Impulsionnelle en BF')
hold on
subplot(3,1,1)
impulse(FTBF)
legend('FTBF')
grid on
subplot(3,1,2)
impulse(FTBF_Red_num)
legend('FTBF_reduite num')
grid on
subplot(3,1,3)
impulse(FTBF_red_phy)
legend('FTBF_reduite physique')
grid on

%% partie identification
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



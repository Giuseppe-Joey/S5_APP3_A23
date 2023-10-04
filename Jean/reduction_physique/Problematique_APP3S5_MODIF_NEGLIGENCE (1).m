close all
clear
clc

% Param
Kp = 0.318;     % V/rad
K = 100;        % gain ampli
tau =  0.01;    % Cte de temps ampli (s)
Ki =  0.5;      % Cte de couple du moteur (N-m/A)
Kb =  0.5;      % Cte de force contre électromotrice (fcém) du moteurV/rad/s
Ra =  8;        % résistance armature du moteur Ohm
La =  0.008;    % inductance armature dumoteur H (Henrys)
Jm =  0.02;     % inertie armatureN-m s2/rad
Bm = 0.01;      % frottement visqueux armature N.m/rad/s
N =  0.1;       % facteur de réduction
JL =  1;        % inertie charge N.m s2 /rad
BL =  1;        % frottement visqueux charge N-m/rad/s

%b) Matrice / eq d'état:
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

%%
t = [0:0.01:50]';
stepp = ones(size(t));

% Affichage
figure('Name','Simulation de lerreur avec une entree echelon')
plot(t, lsim(FTBF, stepp, t))
xlabel('Time (s)')
ylabel('Amplitude')
title(' Systeme avec aucune négligence')
xlim([0 10])
grid on
stepinfo(FTBF)

% Systeme avec negligence
FTBF_a_bras_negligence = tf(Kp*NumBO,(DenBO + Kp*NumBO))
t = [0:0.01:100]';
stepp = ones(size(t));
% Affichage
figure('Name','Simulation de lerreur avec une entree echelon avec negligence')
plot(t, lsim(FTBF_a_bras_negligence, stepp, t))
xlabel('Time (s)')
ylabel('Amplitude')
title(' Systeme avec négligence')
xlim([0 20])
grid on
stepinfo(FTBF_a_bras_negligence)

%%

%f) 2 - Reduction numerique:
figure('Name','PZmap FTBO')
pzmap(FTBO)
[R, P, Kq] = residue(NumBO,DenBO)
poids = abs(R)./real(P)
[B,A] = residue(R(3:4),P(3:4),Kq); %a modifier selon les poids
tfss = tf(B,A);
% On ne se sert pas de cela car FTBO instable
% K1 = dcgain(FTBO);
% K2 = dcgain(tfss);
% KK = K2/K1;
% Kn = 1/KK;
% TF = tfss*Kn;
TF = tfss
FTBF_Red_num = Kp*feedback(tfss,Kp)

figure('Name','Réponse à un échelon en BO')
hold on
subplot(2,1,1)
step(FTBO)
legend('FTBO')
grid on
subplot(2,1,2)
step(TF)
legend('FTBO_reduite')
grid on
hold off

figure('Name','Réponse Impulsionnelle en BO')
hold on
subplot(2,1,1)
impulse(FTBO)
legend('FTBO')
grid on
subplot(2,1,2)
impulse(TF)
legend('FTBO_reduite')
grid on

% En BF
figure('Name','Réponse à un échelon en BF')
hold on
subplot(2,1,1)
step(FTBF)
legend('FTBF')
grid on
subplot(2,1,2)
step(FTBF_Red_num)
legend('FTBF_reduite')
grid on
hold off

figure('Name','Réponse Impulsionnelle en BF')
hold on
subplot(2,1,1)
impulse(FTBF)
legend('FTBF')
grid on
subplot(2,1,2)
impulse(FTBF_Red_num)
legend('FTBF_reduite')
grid on


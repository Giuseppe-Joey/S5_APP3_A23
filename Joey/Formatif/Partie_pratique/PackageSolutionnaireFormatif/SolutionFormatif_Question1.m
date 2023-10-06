% Question 1

%%%
  close all
  clear all
  clc
%%%

  tmp = 'Poles dominants: ';
  
% Question 1


  num= [1.5 28.5 202.8 652.2 740.4];
  den= [1 23 210 950 2044 1632];
  
  FT= tf(num, den)
  
  disp(' ')
  disp('Fonction de transfert originale')
  disp(['Numerateur (original):    ', num2str(num)])
  disp(['Denominateur (original):  ', num2str(den)])
  
  
 % Frations partielles  

  [R, P, K] = residue(num, den);
  
  % Calcul du ratio de dominance 
  ratio = abs( R./real(P))
  
  disp(' ')
  disp('Residus, pôles et ratio de dominance:')
  [R, P, ratio]
  
% On conserve les deux pôles/résidues qui maximisent le test de dominance

  [numr, denr] = residue(R(4:5), P(4:5), K);

% Correction du gain DC

  g0 = dcgain(num ,den );
  gr = dcgain(numr,denr);
  numr = numr*g0/gr;

  disp(' ')
  disp('Fonction de transfert reduite')
  FTr = tf(numr,denr)

  disp(' ')
  disp(['Numerateur (reduit):    ', num2str(numr)])
  disp(['Denominateur (reduit):  ', num2str(denr)])
  
% Reponse a l'échelon
  
  t = [0:0.1:10]';
  u = ones(size(t));
  y0 = lsim(num ,den ,u,t);
  yr = lsim(numr,denr,u,t);
  
  figure
  plot(t, y0, 'r')
  hold on
  grid on
  plot(t, yr, 'k')
  legend('originale', 'reduite')
  title([tmp, 'Reponse de la FT originale et de la FT reduite'])
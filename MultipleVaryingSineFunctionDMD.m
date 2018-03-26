
clc 
clear all
close all

%1st Sine Wave
f1 = 0.5; 
w1 = 2*pi*f1;
A1 = 10;

%2nd Sine Wave
f2 = 0.25; 
w2 = 2*pi*f2;
A2 = 5;

%3rd Sine Wave
f3 = 0.7; 
w3 = 2*pi*f3;
A3 = 1;

%4th Sine Wave
f4 = 0.1; 
w4 = 2*pi*f4;
A4 = 0.5;

x = 0:pi/30:2*pi; 
r = 6; %Number of DMD modes
dt = 10; %Sampling Rate
endint = 60; %Span of sampling

%Sampled at 0.1 seconds for endint/dt = 6.2 seconds, while moving 0.1 seconds to the
%right
b = zeros(length(x),endint+1); %No noise parameter
bt = b; %Noise Parameter

noiseSignal = rand(1, endint+1); 
B = 25; %Noise strength

for t = 1:endint+1
 t = t/dt;
 phase1 = t*w1;
 phase2 = t*w2;
 phase3 = t*w3;
 phase4 = t*w4;
 y1 = exp(0.2*x).*sin(w1.*x+phase1);
 y2 = exp(0.9*x).*sin(w2.*x+phase2);
 y3 = exp(0.1*x).*sin(w3.*x+phase3);
 y4 = exp(0.05*x).*sin(w4.*x+phase4);
 b(:,dt*t) = y1(:)+y2(:)+y3(:)+y4(:);
 bt(:,dt*t) = y1(:)+y2(:)+y3(:)+y4(:)+ B*noiseSignal(:);
 %plot(x,y1,x,y2,x,y3,x,y4)
 %pause(0.1)
end

figure(2)
plot(x,bt(:,61),x,b(:,61))
title('Last snapshot of waves with and without noise')

v1 = bt(:,1:end-1);
v2 = bt(:,2:end);

[U,E,W] = svd(v1);    %SVD of v1_n-1

Ut = U(:,1:r); %trims U vector to r modes
Et = E(1:r,1:r); %trims E vector to r modes
Wt = W(:,1:r); %trims W vector to r modes


Sbar = Ut'*v2*Wt*inv(Et); %E is not a square matrix if I sample more x points

[V,D] = eig(Sbar);
eigenvalues = diag(D);
eigenvalues = sort(eigenvalues);


eigenvalues = log(eigenvalues)*dt;

figure(3)
plot(eigenvalues, 'x')
xlabel('Real(omega)')
ylabel('Im(omega)')

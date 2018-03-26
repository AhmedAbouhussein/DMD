
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

x = 0:pi/30:2*pi-(pi/30); %Exclude last point
r = 10; %Number of DMD modes
dt = 10; %Sampling Rate
endint = 60; %Span of sampling

%Sampled at 0.1 seconds for endint/dt = 6.2 seconds, while moving 0.1 seconds to the
%right
bx = zeros(length(x),endint); 
by = bx;

for t = 1:endint+1
 t = t/dt;
 phase1 = t*w1;
 phase2 = t*w2;
 y1 = exp(-0.5*x).*sin(w1.*x+phase1);
 y2 = exp(-0.5*x).*sin(w2.*x+phase2); 
 bx(:,dt*t) = y1(:);
 by(:,dt*t) = y2(:);
 [X,Y] = meshgrid(x,x);
 Z = exp(0.1*x)*sin(w1.*X+phase1)+exp(0.02*x).*sin(w2.*Y+phase2);
 surf(X,Y,Z)
 pause(0.1)
end

v1 = [bx(:,1:end-1);by(:,1:end-1)];
v2 = [bx(:,2:end);by(:,2:end)];

[U,E,W] = svd(v1);    %SVD of v1_n-1

Ut = U(:,1:r); %trims U vector to r modes
Et = E(1:r,1:r); %trims E vector to r modes
Wt = W(:,1:r); %trims W vector to r modes


Sbar = Ut'*v2*Wt*inv(Et); %E is not a square matrix if I sample more x points

[V,D] = eig(Sbar);
eigenvalues = diag(D); 

eigenvalues = log(eigenvalues)*dt;


plot(eigenvalues, 'x')
xlabel('Real(omega)')
ylabel('Im(omega)')
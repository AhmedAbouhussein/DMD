clc 
clear all
close all 

syms x y
f = 3*sin(x);
t = linspace(0.1,10,100);
rnd = rand(1,length(t));
A = 5;
b = subs(f,x,t)+A*rnd;
figure(1)
plot(b)
title('noise signal in time domain')
b = laplace(f,y);
b = subs(b,y,t);
b = double(b);
figure(2)
plot(b);
title('noise signal in freq domain') 

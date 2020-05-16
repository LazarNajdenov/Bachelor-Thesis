% Script for plotting the scatters of the artificial datasets 
% taken from http://cs.joensuu.fi/sipu/datasets/.
clc;
clear;
close all;

addpath ../

load Aggregation7.mat
load Compound6.mat
load Flame2.mat
load Jain2.mat
load Patchbased3.mat
load R15.mat
load Spiral3.mat

points = three_kernels(700);
dotsize = 12;
map = [ 1 0 0; %red
           1 0 .5; % magenta  
           0 0 .8; % blue  
           0 .6 0; % dark green  
           172/255 108/255 204/255; % violet
           1 1 0; %yellow 
           162/255 26/255 94/255; % fuchsia
           
           54/255 252/255 195/255; % turkese
           127/255 21/255 5/255; % red brick
           198/255 95/255 59/255; % amaranto
           
           237/255 86/255 245/255; % pink
           84/255 68/255 129/255; %purple
           
           1 128/255 0; %orange
           199/255 174/255 132/255; % sand
           .3 1 0; % bright green
           ];

figure;
scatter(Aggregation(:,1), Aggregation(:,2), dotsize, Aggregation(:,3));

set(gca,'fontsize',13)
colormap(map);

figure;
scatter(Compound(:,1), Compound(:,2), dotsize, Compound(:,3));

set(gca,'fontsize',13)
colormap(map);

figure;
scatter(Flame(:,1), Flame(:,2), dotsize, Flame(:,3));

set(gca,'fontsize',13)
colormap(map);

figure;
scatter(Jain(:,1), Jain(:,2), dotsize, Jain(:,3));

set(gca,'fontsize',13)
colormap(map);

figure;
scatter(Patchbased(:,1), Patchbased(:,2), dotsize, Patchbased(:,3));

set(gca,'fontsize',13)
colormap(map);

figure;
scatter(R15(:,1), R15(:,2), dotsize, R15(:,3));

set(gca,'fontsize',13)
colormap(map);

figure;
scatter(Spiral(:,1), Spiral(:,2), dotsize, Spiral(:,3));

set(gca,'fontsize',13)
colormap(map);

figure;
scatter(points(:,1), points(:,2), dotsize, points(:,3));

set(gca,'fontsize',13)
colormap(map);


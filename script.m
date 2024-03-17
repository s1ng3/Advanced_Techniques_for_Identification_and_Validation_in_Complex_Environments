close all;
clear all;
clc;

load('data.mat');

Ts=id.Ts;

% Separate input and output data for identification
uid=id.InputData;
yid=id.OutputData;

% Separate input and output data for validation
uval=val.InputData;
yval=val.OutputData;

% Plotting the identification and validation data
figure;
subplot(411)
plot(uid,'k');
title('Input Identification Data');grid;shg;
legend('Input Data');
subplot(412)
plot(yid,'g');
title('Output Identification Data');grid;shg;
legend('Output Data');
subplot(413)
plot(uval,'k');
title('Input Validation Data');grid;shg;
legend('Input Data');
subplot(414)
plot(yval,'g');
title('Output Validation Data');grid;shg;
legend('Output Data');

% Model parameters
na=1; % Ideal cases for na=nb=1 and m=3 and also for na=nb=3 and m=1.
nb=1;
nk=1; % Delay in the system

m=3; % Degree

% Time vectors for identification and validation
timp_de_id=0:Ts:199.9;
timp_de_val=0:Ts:199.9;

% Building the phi matrix for identification
phi_id=phi_function_id(na,nb,nk,m,uid,yid);

% Estimate model parameters
theta=phi_id\yid;
y_hatz_id=phi_id*theta;

% Plotting identification data against prediction and simulation
figure;

subplot(221);
hold on;
grid;shg;
plot(timp_de_id,yid,'k');
plot(timp_de_id,y_hatz_id,'r');
hold off;
title('Identification Data vs. Prediction');
legend('Actual Output','Prediction');

% Building the phi matrix for identification simulation
phi_id_sim=phi_function_id_sim(na,nb,nk,m,uid,y_hatz_id);
y_hatz_id_sim=phi_id_sim*theta;

subplot(222);

hold on;
grid;shg;
plot(timp_de_id,yid,'b');
plot(timp_de_id,y_hatz_id_sim,'g');
hold off;
title('Identification Data vs. Simulation');
legend('Actual Output','Simulation Output');

% Building the phi matrix for validation
phi_val=phi_function_val(na,nb,nk,m,uval,yval);
y_hatz_val=phi_val*theta;

% Plotting validation data for prediction

subplot(223);
hold on;
grid;shg;
plot(timp_de_val,yval,'b');
plot(timp_de_val,y_hatz_val,'k');
hold off;
title('Validation Data vs. Prediction');
legend('Actual Output','Prediction');

% Calculate mean squared errors for validation prediction and simulation
mse3=0;
mse4=0;

phi_val_sim=phi_function_val_sim(na,nb,nk,m,uval,y_hatz_val);
y_hatz_val_sim=phi_val_sim*theta;

for i=5:length(yval)
    mse3= mse3+((y_hatz_val(i)-yval(i))^2);
    mse4=mse4+((y_hatz_val_sim(i)-yval(i))^2);
end

mse_val=(1/length(yval)*mse3);
mse_val_sim=(1/length(yval)*mse4);

% Building the phi matrix for validation simulation
phi_val_sim=phi_function_val_sim(na,nb,nk,m,uval,yval);
y_hatz_val_sim=phi_val_sim*theta;

% Plot validation data for simulation
subplot(224);
hold on;
grid;shg;
plot(timp_de_val,yval,'g');
plot(timp_de_val,y_hatz_val_sim,'r');
hold off;
title('Validation Data vs. Simulation');
legend('Actual Output','Simulation Output');

% Calculate mean squared errors for identification prediction and simulation
mse=0;
mse2=0;

for i=1:length(yid)
    mse=mse+((y_hatz_id(i)-yid(i))^2);
    mse2=mse2+((y_hatz_id_sim(i)-yid(i))^2);
end

mse_id=(1/length(yid)*mse);
mse_id_sim=(1/length(yid)*mse2);

% Displaying mean squared errors
fprintf('The mse for identification prediction is: %f for na=%d, nb=%d, nk=%d, m=%d. \n',mse_id,na,nb,nk,m);
fprintf('The mse for identification simulation is: %f for na=%d, nb=%d, nk=%d, m=%d. \n',mse_id_sim,na,nb,nk,m);
fprintf('The mse for validation prediction is: %f for na=%d, nb=%d, nk=%d, m=%d. \n',mse_val,na,nb,nk,m);
fprintf('The mse for validation simulation is: %f for na=%d, nb=%d, nk=%d, m=%d. \n',mse_val_sim,na,nb,nk,m);

% Function to calculate the phi matrix for identification
function phi_id=phi_function_id(na,nb,nk,degr_m,uid,yid)

    phi_id=[];

    for i=1:length(yid)

        vector=regline(na,nb,nk,i,uid,yid);
        phi_lines=[];

        for j=1:length(vector)
            phi_lines=phi_line_function(phi_lines,vector,0,degr_m,1,j);
        end

        phi_id=[phi_id; phi_lines];
    end
end

% Function to calculate the phi matrix for identification simulation
function phi_id_sim=phi_function_id_sim(na,nb,nk,degr_m,uid,y_hatz_id)

    phi_id_sim=[];

    for i=1:length(y_hatz_id)

        vector=regline(na,nb,nk,i,uid,y_hatz_id);
        phi_lines=[];
        for j=1:length(vector)
            phi_lines=phi_line_function(phi_lines,vector,0,degr_m,1,j);
        end

        phi_id_sim=[phi_id_sim;phi_lines];
    end
end

% Function to calculate the phi matrix for validation
function phi_val=phi_function_val(na,nb,nk,degr_m,uval,yval)

    phi_val=[];

    for i=1:length(yval)

        vector=regline(na,nb,nk,i,uval,yval);
        phi_lines=[];
        for j=1:length(vector)
            phi_lines=phi_line_function(phi_lines,vector,0,degr_m,1,j);
        end

        phi_val=[phi_val;phi_lines];
    end
end

% Function to calculate the phi matrix for validation simulation
function phi_val_sim=phi_function_val_sim(na,nb,nk,degr_m,uval,y_hatz_val)

    phi_val_sim=[];
    for i=1:length(y_hatz_val)

        vector=regline(na,nb,nk,i,uval,y_hatz_val);
        phi_lines=[];

        for j=1:length(vector)
            phi_lines=phi_line_function(phi_lines,vector,0,degr_m,1,j);
        end

        phi_val_sim=[phi_val_sim;phi_lines];
    end
end

% Function to calculate a phi matrix line
function philine=phi_line_function(philine,vector,deg,degr_m,value,position)

    value=value*vector(position);
    deg=deg+1;

    if deg~=degr_m
        for i=position:length(vector)
            philine=phi_line_function(philine,vector,deg,degr_m,value,i);
        end
    else
        philine=[philine value];
    end
end

% Function to construct the regressor line
function vline=regline(na,nb,nk,k,uid,yid)

    vline=1;
    for i=1:na
        if k-i<=0
            vline=[vline 0];
        else
            vline=[vline yid(k-i)];
        end
    end

    for j=1:nb
        if k-j-nk+1<=0
            vline=[vline 0];
        else
            vline=[vline uid(k-j-nk+1)];
        end
    end
end
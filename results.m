clc
clear
close all;

data = csvread('dataVP.csv');
index = data(:, 1);
track = data(:, 2);
temp = data(:, 3);
data(:, 3) = data(:,4);
data(:, 4) = temp;

% original candidates region

% center of mass
centerOfMass = data(:,4);
label{2} = "Center of mass";
% maximum datum
max = data(:,3);
label{1} = "Maximum";

% clean candidates region (inf, nan)

% center of mass
centerOfMass_clean = data(:, 5);
label(3) = "Clean region, CoM";
% maximum datum
max_clean = data(:, 6);
label(4) = "Clean region, Max";

% enlarged candidates region (from voter up)
%center of mass
centerOfMass_large = data(:,7);
label(5) = "Large region, CoM";
%maximum datum
max_large = data(:, 8);
label(6) = "Large region, Max";

%Using the maximum datum

%Angle weighting
angle_weight = data(:, 9);
label(7) = "Angle Weighting";

%Resizing the original image
resize_70 = data(:, 11); % 70%
label(8) = "70% size";
resize_60 = data(:, 12); % 60%
label(9) = "60% size";
resize_50 = data(:, 10); % 50%
label(10) = "50% size";
resize_40 = data(:, 13); % 40%
label(11) = "40% size";
resize_30 = data(:, 14); % 30%
label(12) = "30% size";

%changing confidence threshold from 0.5, with 40% size
confidence_4 = data(:, 15); % 0.4
label(13) = "Confidence 0.4";
confidence_3 = data(:, 16); % 0.3
label(14) = "Confidence 0.3";
confidence_2 = data(:, 17); % 0.2
label(15) = "Confidence 0.2";

%no confidence with all pixels voting at 50% size
no_confidence_50 = data(:, 18);
label(16) = "No Confidence";

%voted region is set higher
no_confidence_50_2 = data(:,19);
label(17) = "No confidence, high";
confidence_5_all_pixels = data(:,20);
label(18) = "Confidence 0.5, all pixels";

%Difference of Gaussians added before processing
dog_3_5 = data(:, 21);
label(19) = "Difference of Gaussians";

%Reorganized voting, 0.5 confidence, 50% scaling, all pixels
reorganized_voting = data(:, 22);
label(20) = "Reorganized voting";

%Frequency of filters 
freq_1 = data(:, 23);
label(21) = "Frequency 0.1";
freq_2 = data(:, 24);
label(22) = "Frequency 0.2";
freq_3 = data(:, 25);
label(23) = "Frequency 0.3";
freq_4 = data(:,26);
label(24) = "Frequency 0.4";
freq_5 = data(: , 27);
label(25) = "Frequency 0.5";
freq_6 = data(:, 28);
label(26) = "Frequency 0.6";

%%Use feedback from road
feedback = data(:,29);
label(27) = "Feedback from road";

%x = resize_40;

x = feedback;
y = reorganized_voting;
figure();

%while (1)
for i=3:29
  plot(index, track, "linewidth", 1, index, data(:,i), "linewidth", 1);
  legend("Track", label{i-2});
  title "Estimado"
  ylabel "Estimado (Horizontal)"
  xlabel "Tiempo"
  pause()
end
%endwhile

%plot(index,track,index, x, index, y);
%legend("Track", "X", "Y")
%plot(index, track, index, centerOfMass);

for i=1:27
  MSE(i) = sum(abs(track-data(:,i+2)).^2)/length(index); 
 
end
figure();

plot([1:27], MSE, "linewidth", 2);

title ("Mean Square Error")
xlabel ("Version")
ylabel ("MSE")
MSEx = sum(abs(track-x).^2)/length(index)
MSEy = sum(abs(track-y).^2)/length(index)

threshold = sum((10*ones(length(index),1)).^2)/length(index)


%csvwrite('track.txt', track);

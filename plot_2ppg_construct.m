data=load('C:\Users\19713\Dropbox\Dropbox\project_2022_ARVR_PPG_Blood_Pressure - zhengkun\PPG_data(164971,1).mat');
ACC_X=load('C:\Users\19713\Dropbox\Dropbox\project_2022_ARVR_PPG_Blood_Pressure - zhengkun\ACC_X(149035,1).mat');
ACC_Y=load('C:\Users\19713\Dropbox\Dropbox\project_2022_ARVR_PPG_Blood_Pressure - zhengkun\ACC_Y.mat');
ACC_Z=load('C:\Users\19713\Dropbox\Dropbox\project_2022_ARVR_PPG_Blood_Pressure - zhengkun\ACC_Z.mat');

acc_Z=ACC_Z.z_acc;
acc_Y=ACC_Y.y_acc;
acc_X=ACC_X.x_acc;
figure  
set(gcf,'Position',[400 100 810 1100]);
box on
hold on
normalize_data=(data.data-466)/(625-466);
length_ppg=3000;
% plot(linspace(0,length_ppg,length_ppg+1),normalize_data(44200:47200),'-r');
normalize_data_smooth=smooth(normalize_data,100);
start_point=44900;
line_width=3;
subplot(2,1,2);


plot(linspace(0,length_ppg,length_ppg+1),normalize_data_smooth(44150:47150),'LineWidth',line_width,'Color','r');
hold on
%plot(linspace(0,length_ppg,length_ppg+1),normalize_data_smooth(start_point:start_point+length_ppg),'--b','LineWidth',line_width);

segment_ACC=acc_X(45000:47500);
offset=60;
ratio=3.7;
length_acc=round(6000/ratio);
start_point=54660;
length_ppg=3130;
normalize_acc_X=(acc_X-min(segment_ACC))/(max(segment_ACC)-min(segment_ACC));
plot(linspace(0,3000,length_ppg+1), normalize_data_smooth(start_point:start_point+length_ppg)*0.86+0.03,'--b','LineWidth',3);
% legend('Groudtruth PPG','Constructed PPG','FontWeight','bold','FontSize',12)
set(gca,'FontSize', 18,'FontWeight','bold');
% xlim([0 max(time_acc)-10])
% xlim([400 850])
legend('Ground Truth PPG Signal','Constructed Blood Flow Waveform','FontSize',18)
ylabel('Amplitude')
xlabel('Samples')
ylim([0,1])

normalize_data=(data.data-466)/(625-466);
normalize_data_smooth=smooth(normalize_data,50);
length_ppg=3000;
% subplot(3,1,2);
% plot(linspace(0,length_ppg,length_ppg+1),normalize_data(44200:47200),'LineWidth',line_width,'Color','r');
% 
% set(gca,'FontSize', 18);
% % xlim([0 max(time_acc)-10])
% % xlim([400 850])
% ylabel('Amplitude')
% xlabel('Samples')
% 
% legend('Ground Truth PPG Signal','FontSize',18)

Fs=1000;
% R = acc_X;
% % R_user2 = z_acc_user2;
% HR_region = [0.8,3];
% [b1,a1]=butter(1,HR_region/(Fs/2));
% acc_X = filter(b1,a1, R);
acc_X_smooth=smooth(acc_X,100);

set(gca,'FontSize', 18,'FontWeight','bold');
% xlim([0 max(time_acc)-10])
% xlim([400 850])
ylabel('Amplitude')
xlabel('Samples')
time_acc = 0:1/Fs:(1/Fs*(size(acc_X,1)-1));


ax=subplot(2,1,1);
hold on
box on

begin=44230;
num_acc=900;
end_acc=num_acc+begin;
z_offset=-45;

acc_Y_smooth=smooth(acc_Y,10);
acc_Y_normalize=(acc_Y_smooth-min(acc_Y_smooth(begin:end_acc)))/(max(acc_Y_smooth(begin:end_acc))*1.1-min(acc_Y_smooth(begin:end_acc)));


acc_Z_smooth=smooth(acc_Z,100);
acc_Z_normalize=(acc_Z-min(acc_Z(begin:end_acc)))/(max(acc_Z(begin:end_acc))*1.1-min(acc_Z(begin:end_acc)));
% for i=1:size(speechIndices,1)
%     for j=1:size(speechIndices,2)
%         hold on
%         xline(speechIndices(i, j), 'Color','r', 'LineWidth',1.5);
%     end
% end
set(gca,'FontSize', 18,'FontWeight','bold');
% xlim([0 max(time_acc)-10])
% xlim([400 850])


colororder(['r',"#0072BD"]);

xlabel('Samples','FontWeight','bold');
yyaxis left
set(ax,'YColor','r','YTick',...
    [0 0.5 1 1.5]);
%plot(linspace(0,3000,num_acc+1), acc_Z_normalize(begin-z_offset:end_acc-z_offset),'LineWidth',line_width,'Color',"#0072BD",'LineStyle','-.')
plot(linspace(0,length_ppg,length_ppg+1),normalize_data_smooth(44150:47150),'LineWidth',line_width,'Color','r');
hold on
ylim([0,1.5])
yticks([0 0.5 1 1.5]);
ylabel('Constructed Blood Flow Waveform','FontSize',18,'FontWeight','bold',Color='r');
%legend('Y-Axis','Z-Axis','FontWeight','bold','FontSize',18)
yyaxis right
plot(linspace(0,3000,num_acc+1), acc_Y_normalize(begin:end_acc),'LineWidth',line_width,'Color',	"#0072BD",'LineStyle','-')
ylim([-0.5,1])
yticks([-0.5 0 0.5 1]);
ylabel('Z-Axis Acc(m/s^{2})',Color=	"#0072BD");
% Fs=1000;
% time_acc = 0:1/Fs:(1/Fs*(size(y_acc,1)-1)); 
% figure
% subplot(2,1,1)
% plot(time_acc(1:2501), y_acc(45000:47500))
% for i=1:size(speechIndices,1)
%     for j=1:size(speechIndices,2)
%         hold on
%         xline(speechIndices(i, j), 'Color','r', 'LineWidth',1.5);
%     end
% end
% set(gca,'FontSize', 12);
% xlim([0 max(time_acc)-10])
% xlim([400 850])
% ylabel('Acc (Y)')
% xlabel('Time (seconds)')
% 
% R = x_acc;
% R_user2 = z_acc_user2;
% HR_region = [0.8,3];
% [b1,a1]=butter(1,HR_region/(Fs/2));
% x_acc = filter(b1,a1, R);
% 
% Fs=1000;
% time_acc = 0:1/Fs:(1/Fs*(size(x_acc,1)-1)); 
% subplot(2,1,2)
% plot(time_acc(1:2501), x_acc(45000:47500))
% for i=1:size(speechIndices,1)
%     for j=1:size(speechIndices,2)
%         hold on
%         xline(speechIndices(i, j), 'Color','r', 'LineWidth',1.5);
%     end
% end
% set(gca,'FontSize', 12);
% xlim([0 max(time_acc)-10])
% xlim([400 850])
% ylabel('Acc (X)')
% xlabel('Time (seconds)')
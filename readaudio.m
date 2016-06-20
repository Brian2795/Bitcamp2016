% read in audio file and edit

[y1,Fs1] = audioread('cutfurelise.mp3');

% start the playback
binsize = floor(length(y1)/60);
y2 = y1;
tester;
for i = 1:60
    y1n = y1((i-1) * binsize + 1 : i * binsize);
    y2n = y1((i-1) * binsize + 1: i * binsize);
    difftest = diff4(i) * .5;
    if difftest > 0
        e = pvoc(y1n, difftest); 
        [N, D] = rat(difftest);
        f = resample(e, N, D);
        sampdif = length(f) - length(y1n);
        f1 = f;
        if sampdif > 0
            f1 = f(1:length(y1n));
        elseif sampdif < 0
            f1 = zeros(length(y1n), 1);
            f1(1:length(f)) = f;
        end
        f1 = transpose(f1);
        y2n = y1n + f1;
        y2((i-1) * binsize + 1: i * binsize) = y2n;
    end
end


y1= y2;
%echo
for i = 1:60
   for j= 0:echo4(i)
      N= Fs1*.3*j;
      for n= ((i-1)*binsize+1):i*binsize
        if n+N < length(y1)
          y2(n+N)= y1(n)+y2(n+N);
        end
      end
   end
end

audiowrite('cutfurelisetwtr.m4a',y2,Fs1);
player1 = audioplayer(y2, Fs1);
% e = pvoc(y1, 0.8); 
% f = resample(e,4,5); % NB: 0.8 = 4/5 
% player2 = audioplayer(transpose(y1(1:length(f)))+f,Fs1);

player1.TimerFcn = {@stopaudio, player1}; % timer callback function (defined below)
player1.TimerPeriod = 30; % period of the timer in seconds
playblocking(player1);
% 
% % rewrite with lower bitrate
% % audiowrite('shittytemptear.m4a', y1./2, Fs1);
% % info2 = audioinfo('shittytemptear.m4a');
% % [y2, Fs2] = audioread('shittytemptear.m4a');
% 
% % e = pvoc(y1, 0.8); 
% % f = resample(e,4,5); % NB: 0.8 = 4/5 
% % player2 = audioplayer(transpose(y1(1:length(f)))+f,Fs1);
% % 
% % bitspersamp2 = get(player2, 'BitsPerSample');
% % 
% % player2.TimerFcn = {@stopaudio, player2}; % timer callback function (defined below)
% % player2.TimerPeriod = 20; % period of the timer in seconds
% % playblocking(player2);
% % 
% % % e = pvoc(y1, 1.4); 
% % % f = resample(e,7,5); % NB: 0.8 = 4/5 
% % % player3 = audioplayer(transpose(y1(1:length(f)))+f,Fs1);
% % % 
% % % bitspersamp3 = get(player3, 'BitsPerSample');
% % % 
% % % player3.TimerFcn = {@stopaudio, player3}; % timer callback function (defined below)
% % % player3.TimerPeriod = 20; % period of the timer in seconds
% % % playblocking(player3);
% % 
% % out=y1;
% %  
% % % for n=2:length(y1)
% % %  
% % %     out(n,1)=.9*y1(n-1,1)+y1(n,1); % left
% % %     out(n,2)=.9*y1(n-1,2)+y1(n,2); % right
% % %  
% % % end
% % for n=2:length(y1)
% %  
% % out(n,1)=y1(n,1)-y1(n-1,1); % left
% % out(n,2)=y1(n,2)-y1(n-1,2); % right
% %  
% % end
% % 
% % player3 = audioplayer(transpose(out),Fs1);
% % player3.TimerFcn = {@stopaudio, player3}; % timer callback function (defined below)
% % player3.TimerPeriod = 20; % period of the timer in seconds
% % playblocking(player3);
% 
% 
%  
% out1=y1; % set up a new array, same size as old one
% N=50000;  % delay amount N/8192 seconds
% for n=N+1:length(y1)
%           out1(n)=.8*out1(n-N)+y1(n);  % recursive echo
% end
%  
% player4 = audioplayer(transpose(out1),Fs1);
% player4.TimerFcn = {@stopaudio, player4}; % timer callback function (defined below)
% player4.TimerPeriod = 20; % period of the timer in seconds
% playblocking(player4);
% 
% % pause the playback
% %pause(player);
% 
% % resume the playback
% %resume(player)
% 
% % stop the playback
% %stop(player)



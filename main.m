% Authors
% HABIBULLAH
% Adnan Sikandar
% M. Sami
%     10/01/2016
%   Digital Audio Proccessing 

% This is free and unencumbered software released into the public domain.
% 
% Anyone is free to copy, modify, publish, use, compile, sell, or
% distribute this software, either in source code form or as a compiled
% binary, for any purpose, commercial or non-commercial, and by any
% means.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
% EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
% MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
% IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
% OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
% ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
% OTHER DEALINGS IN THE SOFTWARE.


function main(path)  

 % Loading a Sound file into Matlab
[sound,fs] = wavread(path);          % sound contains stereo sound data fs is the sampling Frequency
% soundsc(sound,fs);                  

%  Sound_size = size(path);

%   Audio Signal Plot

left=sound(:,1);        % The left and right channel signals
right=sound(:,2);

% soundsc(right,fs)
time=(1/44100)*2000;
t=linspace(0,time,2000);
plot(t,left(1:2000))
xlabel('time (sec)');
ylabel('relative signal strength')

% *************************************************************************                  
% Reverse Playing
New_signal = flipud(sound);         
  soundsc(New_signal,fs);
wavwrite(New_signal,fs,'Output/Reversed.wav');

% *************************************************************************
% Echo (Digital Delay)
Sound_out=left;  % set up a new array, same size as old one
N=10000;  % delay amount N/44100 seconds
for n=N+1:length(sound)
    Sound_out(n)=left(n)+left(n-N);  % approximately 1/4 second echo
end
%  soundsc(Sound_out,fs);
wavwrite(Sound_out,fs,'Output/Echoed.wav')

%*********************************************************************
%   Left-to_Right Echo
out=sound;  % set up a new array, same size as old one
N=10000;  % delay amount N/44100 seconds
for n=N+1:length(sound)
out(n,1)=sound(n,1)+sound(n-N,2);  % echo right-to-left!
% out(n,2)=sound(n,2)+sound(n-N,1);  % echo left-to-right!
end
%  soundsc(out,fs) % echo
 wavwrite(out,fs,'Output/right_to_left_Echoed.wav')

% ***********************************************************************%
%                           Digital filter


    out = sound;

    for n=2:length(sound)

    out(n,1)=.9*out(n-1,1)+sound(n,1); % left
    out(n,2)=.9*out(n-1,2)+sound(n,2); % right
    end
%     soundsc(out,fs);
    wavwrite(out,fs,'Output/filtered.wav')
%      Speed Of Sound
% soundsc(sound,fs/2);
end


%centroid.m
%Uses Centroid method to classify digits from MNIST Database

clear;
load mnistdata;


for k=1:10
    % create training dataset T
    s = strcat('mean(train',num2str(k-1), ')');
    T(k,:) = double(eval(s));
    
end

success = zeros(10,1);%initialize
for num=1:10
    %for each testing data set, find success rate
    s = strcat('test',num2str(num-1));
    A = double(eval(s));
    [m,~]=size(A);
    O=mycent(A,T);
    matches = sum(O(:,1)==num-1);
    success(num,1) = matches/m * 100;
end
disp(success)


function O=mycent(A,T)
%Inputs:
%   A = n x 784 test data set
%   T = 10 x 784 averages
%Outputs:
%   O = n x 1 classified numbers


    [m,n]=size(A);
    O = zeros(m,1);
    %distance
    for i=1:m %for each row of A
        z = double(A(i,:));
        dist = zeros(10,1);
        for k=1:10
            dist(k) = norm( z - T(k,:) );
        end

        [M,I] = min(dist);%find index of minimum of dist
        O(i,1)=I-1;% minus 1 because digits are 0-9
    end
    
end


function nets=getSingleOutputNets(P, T)

for i=1:6
    
    Tnew=T(i,:);
    net = feedforwardnet(35,'trainscg');
    net.divideFcn='dividetrain';
    %[trainInd,valInd,testInd] = dividetrain(Q,trainRatio,valRatio,testRatio)
    net = configure(net, P, Tnew); 
    net.trainParam.epochs =100;
    net.trainParam.lr = 0.005;
    net.trainParam.goal = 0.01 ;
    net.trainParam.min_grad = 0.01;
    net.performFcn = 'msereg';
    net.performParam.ratio = 0.5;
    
    nets(i).net = train(net, P, Tnew);

end
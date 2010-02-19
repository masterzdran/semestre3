function [OutSignal]=testBER(InSignal)
    Fo=10000;
    Fc=25000;
    xSNR=-10:0.001:10;
    BER1=zeros(1,length(xSNR));
    BER2=BER1;
    BER3=BER2;
    BER4=BER3;
    i=1;
        display( 'OOK em Tx1');
        [signal,FS,TB]=emissor(InSignal,Fo,'ook');
    for val=xSNR
        [Xsignal]=TX(signal,val,1,FS,Fc);
        OutSignal=receptor(Xsignal,FS,TB,'ook');
        BER1(i)=BER(InSignal,OutSignal);
        i=i+1;
    end
    figure;
    plot(xSNR,BER1);
    title('OOK em tx1');
    xlabel('SNR (Unidades Lineares)');
    ylabel('BER');
    pause();
   display( 'OOK em Tx2');
    i=1;
	for val=xSNR
        [Xsignal]=TX(signal,val,2,FS,Fc);
        OutSignal=receptor(Xsignal,FS,TB,'ook');   
        BER3(i)=BER(InSignal,OutSignal);
        i=i+1;
    end
%     figure;
%     plot(xSNR,BER3);
%         title('OOK em tx2');
%     xlabel('SNR (Unidades Lineares)');
%     ylabel('BER');
    pause();
    display( 'PSK em Tx1');
    i=1;
    [signal,FS,TB]=emissor(InSignal,FS,'psk');
    for val=xSNR
        [Xsignal]=TX(signal,val,1,Fo,Fc);
        OutSignal=receptor(Xsignal,FS,TB,'psk');   
        BER2(i)=BER(InSignal,OutSignal);
        i=i+1;
    end

    figure;
    plot(xSNR,log10(BER2));
    title('PSK em tx1');
    xlabel('SNR (db)');
    ylabel('BER');
    pause();
    display( 'PSK em Tx2');
    i=1;
    for val=xSNR
        [Xsignal]=TX(signal,val,2,FS,Fc);
        OutSignal=receptor(Xsignal,FS,TB,'psk');   
        BER4(i)=BER(InSignal,OutSignal);
        i=i+1;
    end  
%     figure;
%     plot(xSNR,BER4);
%     title('PSK em tx2');        
%     xlabel('SNR (Unidades Lineares)');
%     ylabel('BER');

end
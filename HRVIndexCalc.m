function [MNN SDNN Poincare Flomb dfa DelayedPoincare CE DelayedCE]=HRVIndexCalc(RR_interval,RR_time,TF,HF,LF,TimeforDFA)
MNN=mean(RR_interval);
SDNN=std(RR_interval);
RMSSD
Poincare=PoincarePlotCalculation(RR_interval,1);
DelayedPoincare=0;%PoincarePlotCalculation(RR_time,RR_interval,5);

Flomb=0;%FlombCalculation(RR_time,RR_interval,TF,HF,LF);
% dfa=DFACalculation(RR_interval,3,TimeforDFA);
dfa = DFA(RR_interval);

 [~, tau] = time_delayed_MI(RR_interval,0:10);
 [m maxnorm] = fnn(RR_interval,'max',tau,5,0);

CE=0;%ConditionalEntropyCalculation(RR_interval,m,tau);
% DelayedCE=ConditionalEntropyCalculation(RR_interval,5);
[SampEn ApEn]=Entropy(maxnorm,center(RR_interval),m,tau,.3,'max');      

end
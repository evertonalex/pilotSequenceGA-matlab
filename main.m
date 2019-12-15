%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Main script - created by Lucas Sampaio @ 01/05/2019
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all; clc;
set(0,'defaulttextInterpreter','latex');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Cluster Size (1 to 4 works)
C = 2;
% Base Stations (1 per cell)
L = chn(C);
% Cell Radius
R = 100;
% Users per Cell
K = 10;
% Available Pilot Sequences
Tp = K;
% Min Transmission Frequency
Fmin = 9E8;
% Max Transmission Frequency
Fmax = 5E9;
% Shadowing variance (in dB)
Shad = 4;
% Path Loss Exponent
gamma = 4;
% Number of Transmission Channels
Channels = 1;
% Maximum Bandwidth per Carrier
Bmax = 20E6;
% Noise Power Spectrum Density
N0 = 4.11E-21;
% Reference distance (1 m for indoor and 10 m for outdoor)
d0 = 10;
% PSO Population Size
psize = 25;
% PSO Max Iteration
maxit = 100;
% Number of Antennas on each cell
M = 100;
% Maximum Power Transmission
Pmax = 1E-3; %Watts
% Maximum Iterations for Bitloading Alg.
Mbit = 250;
% Maximum Number of Trials
T = 1000;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Script
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pilot Sequence Allocation

[k_x, k_y, c_x, c_y, d, tmp, beta, h] = createscenario(C, R, K, Channels, Fmin, Fmax, M, Shad, gamma, d0);
drawscenario(C, R, K, c_x, c_y, k_x, k_y);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% POWER CONTROL

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SUM RATE MAXIMIZATION

% Trial Variables
Rt = zeros(T,2);
Rtmax = zeros(T,2);
Rtmin = zeros(T,2);

% for t=1:T
% 
%     [k_x, k_y, c_x, c_y, d, tmp, beta, h] = createscenario(C, R, K, Channels, Fmin, Fmax, M, Shad, gamma, d0);
%     %drawscenario(C, R, K, c_x, c_y, k_x, k_y);
% 
%     phi = zeros(K,Tp,L);
%     phi = randomcandidate(phi);
% 
%     % MRT Precoder
%     W = conj(h);
% 
%     % Initializing Variables
%     p0 = unifrnd(1E-9,Pmax/K,[K,L]);
%     P = zeros(K,L,maxit+1);
%     Rwf = zeros(K,L,maxit+1);
%     P(:,:,1) = p0;
%     [S,theta] = sinr(K,L,beta,h,N0*Bmax,W,P(:,:,1),phi);
%     [S_bl,theta_bl] = sinr(K,L,beta,h,N0*Bmax,W,P(:,:,1),phi);
%     Rwf(:,:,1) = Bmax * log2(1+S);
% 
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     % Iterative WaterFilling
%     for i=2:maxit+1
% 
%         wlevel = ((K)/log(2))*((Pmax + sum(1./theta,1)).^(-1));
%         P(:,:,i) = (1./(repmat(wlevel,K,1)*log(2)))-(1./theta);
%         [S,theta] = sinr(K,L,beta,h,N0*Bmax,W,P(:,:,i),phi);
%         Rwf(:,:,i) = Bmax * log2(1+S);
% 
%     end
% 
%     % Best and Worst Rates
%     TotalR = squeeze(sum(sum(Rwf,1),2));
%     MaxR = max(max(Rwf,[],2),[],1);
%     MinR = min(min(Rwf,[],2),[],1);
%     
%     % Trial info
%     Rt(t,1) = TotalR(end);
%     Rtmax(t,1) = MaxR(end);
%     Rtmin(t,1) = MinR(end);
% 
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     % Bit Loading Algorithm
% 
% 
%     P_bl_final = zeros(K,L,maxit+1);
%     B_bl_final = zeros(K,L,maxit+1);
%     P_bl_final(:,:,1) = p0;
%     R_bl = zeros(K,L,maxit+1);
%     R_bl(:,:,1) = Bmax * log2(1+S_bl);
% 
%     for it=2:maxit+1
% 
%         P_bl = zeros(K,L,Mbit);
%         B_bl = zeros(K,L,Mbit);
%         TotalR_bl = zeros(L,Mbit);
%         imax = 0;
% 
%         for ell=1:L
%             for i=1:Mbit
%                 TotalR_bl(ell,i) = sum(B_bl(:,ell,i));
%                 P_bl(:,ell,i+1) = (2.^(B_bl(:,ell,i)+1)-2.^(B_bl(:,ell,i)))./theta_bl(:,ell);
%                 [mval,idx] = min(P_bl(:,ell,i+1));
%                 B_bl(:,ell,i+1) = B_bl(:,ell,i);
%                 B_bl(idx,ell,i+1) = B_bl(idx,ell,i) + 1;
% 
%                 if sum((2.^(B_bl(:,ell,i+1))-1)./(theta_bl(:,ell))) > Pmax
%                     B_bl(idx,ell,i+1) = B_bl(idx,ell,i) - 1;
%                     for j=1:K
%                         x = find(B_bl(j,ell,2:end)==0);
%                         B_bl(j,ell,x+1) = max(B_bl(j,ell,:));
%                     end
%                     TotalR_bl(ell,i+1) = sum(B_bl(:,ell,i+1));
%                     teste = find(TotalR_bl(ell,2:end)==0);
%                     TotalR_bl(ell,teste+1) = max(TotalR_bl(ell,:));
%                     break;
%                 end      
%             end
%             P_bl_final(:,ell,it) = (2.^(B_bl(:,ell,end)))./theta_bl(:,ell);
%             B_bl_final(:,ell,it) = B_bl(:,ell,end);
%         end
% 
%         [S_bl,theta_bl] = sinr(K,L,beta,h,N0*Bmax,W,P_bl_final,phi); 
%         R_bl(:,:,it) = Bmax * log2(1+S_bl);
% 
%     end
% 
%     % Best and Worst Rates
%     TotalR_bl = squeeze(sum(sum(R_bl,1),2));
%     MaxR_bl = max(max(R_bl,[],2),[],1);
%     MinR_bl = min(min(R_bl,[],2),[],1);
%     
%     % Trial info
%     Rt(t,2) = TotalR_bl(end);
%     Rtmax(t,2) = MaxR_bl(end);
%     Rtmin(t,2) = MinR_bl(end);
%     
%     if(mod(t,100) == 0)
%         disp(['Trial: ' num2str(t)]);
%     end
%     
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Verhulst Algorithm

% alpha parameter
% alpha = 0.5;
% delta_target = 1024;
% ItVer = 100;
% P = unifrnd(0,Pmax,[K,L,ItVer]);
% SP = zeros(ItVer,1);
% SP(1) = sum(sum(P(:,:,1)));
% 
% [k_x, k_y, c_x, c_y, d, tmp, beta, h] = createscenario(C, R, K, Channels, Fmin, Fmax, M, Shad, gamma, d0);
% 
% phi = zeros(K,Tp,L);
% phi = randomcandidate(phi);
% 
% % MRT Precoder
% W = conj(h);
% 
% [S,theta] = sinr(K,L,beta,h,N0*Bmax,W,P(:,:,1),phi);
% 
% for i=2:ItVer
%    
%     P(:,:,i) = (1+alpha).* P(:,:,i-1) - alpha.* ((P(:,:,i-1).*theta)./delta_target) .* P(:,:,i-1);
%     
% end
% 
% [S,~] = sinr(K,L,beta,h,N0*Bmax,W,P,phi);
% Sit(:,:,end) = S;
% 
% figure()
% plot(squeeze(P(1,1,:)))
% hold on
% plot(repmat(delta_target,ItVer,1))


% % Ploting Rate Evolution - BitLoading - 1 GamePlay
% figure()
% plot(TotalR_bl./1E9,'-ok','LineWidth',1.0,'DisplayName','Cluster Throughput')
% hold on;
% plot(squeeze(MaxR_bl./1E9),'--vb','LineWidth',2.0,'DisplayName','Best User Trans. Rate')
% plot(squeeze(MinR_bl./1E9),'--or','LineWidth',2.0,'DisplayName','Worst User Trans. Rate')
% legend('Position',[0.552380959139693 0.662698416104392 0.317857136098402 0.126190472784497]);
% grid on;
% title(['For $L = ' num2str(L) ' $ Cells and $ K = ' num2str(K) ' $ users per cell - BitLoading Algorithm']);
% xlabel('Iterations');
% ylabel('System Throughput  [Gbps]');
% 
% 
% % Ploting Theta and Bit Allocated Relation For Centered Cell
% figure()
% bar(10*log10(theta_bl(:,1)),'FaceColor',[1 1 1],'EdgeColor', [0 0 0], 'LineWidth', 2.0,'DisplayName','$\theta$ Value');
% hold on;
% ylabel('$\theta$ [dB]');
% yyaxis right;
% stem(B_bl_final(:,1,end),'LineWidth',2.0,'DisplayName','Bits per Hertz');
% grid on;
% title(['For $L = ' num2str(L) ' $ Cells and $ K = ' num2str(K) ' $ users per cell - BitLoading Algorithm']);
% xlabel('User Index');
% ylabel('$Bits/Hz$');
% 
% 
% 
% % Ploting Rate Evolution
% figure()
% plot(TotalR./1E9,'-ok','LineWidth',2.0,'DisplayName','Cluster Throughput')
% hold on;
% plot(squeeze(MaxR./1E9),'--vb','LineWidth',2.0,'DisplayName','Best User Trans. Rate')
% plot(squeeze(MinR./1E9),'--or','LineWidth',2.0,'DisplayName','Worst User Trans. Rate')
% legend('Position',[0.552380959139693 0.662698416104392 0.317857136098402 0.126190472784497]);
% grid on;
% %axis([1 maxit+1 0.95*min(TotalR./1E9) 1.05*max(TotalR./1E9)])
% title(['For $L = ' num2str(L) ' $ Cells and $ K = ' num2str(K) ' $ users per cell - WaterFilling Algorithm']);
% xlabel('Iterations');
% ylabel('System Throughput [Gbps]');


phi = zeros(K,Tp,L);
phi = randomcandidate(phi);

% f = fitness(phi, beta, N0*Bmax);
% [phi, gbest] = pso(beta, N0*Bmax, psize, maxit);

% Genetic Algorithim
% GeneticAlgorithim - GA
GENERATIONNUMBER = 20;
RATEMUTATION = 0.08;
% CUTPOINT = 3; %PONTO DE CORTE DEFINIDO FIXO em GaCrosover
populationSize = 10;
[gaResut] = geneticAlgorithim(GENERATIONNUMBER, RATEMUTATION, beta, N0*Bmax, populationSize, K, Tp, L);

%Ploting Fitness Evolution
% figure();
% plot(2:maxit+1, gbest(2:end)', 'DisplayName','PSO','LineWidth',2,'LineStyle','--',...
%     'Color',[0 0 0]);
% hold on;
% grid on;
% ylabel('Fitness Value - $\mathcal{J}(\mathbf{\Phi})$','Interpreter','latex');
% xlabel('Iterations','Interpreter','latex');
% title('Fitness Value over Iterations - PSO');
% axis([1 maxit .99*min(gbest) 1.01*max(gbest)]);

function [children1, children2] = GaCrossover(individual, otherIndividual)
    children1 = [];
    children2 = [];

    
    children1(:,:,1:3) = individual(:,:,1:3);
    children1(:,:,4:7) = otherIndividual(:,:,4:7);
    
    children2(:,:,1:3) = otherIndividual(:,:,1:3);
    children2(:,:,4:7) = individual(:,:,4:7);
    
%     ABAIXO REPRESENTACAO SEGUINDO EXEMPLO PYTHON

% %     disp(individual(1))
%     
%     for cros=1:7
% %     for cros=1:1
%         disp("cros-> " + cros)
%                
%         
%         disp("teste")
%         
%         chromossome = [];
%         chromossome = individual(:,:, cros,1);
%         
%         otherChromossome = [];
%         otherChromossome = otherIndividual(:,:, cros,1);
%         
%         for j=1:length(chromossome)
%           children1(cros) = [];
%           children1(cros) = [children1(cros),[chromossome(1:cutPoint)]];  
%           children1(cros) = [children1(cros),[otherChromossome(cutPoint+1:length(otherChromossome))]];
%         end
%        
%       
%         
% %         children1(cros) = [children1(cros),[individual(1:cutPoint)]];
% %         children1(cros) = [children1(cros),[otherIndividual(cutPoint+1:length(otherIndividual))]];
% %     
% %         children2 = [children2, [otherIndividual(1:cutPoint)]];
% %         children2 = [children2, [individual(cutPoint+1:length(individual))]];
%     end
%         
%     
%     disp("debug1 ")
%     disp(children1);
%       disp("debug2 ")
%     disp(children2);
%    
%    
% 
% %     NEXT COMENTS IS ONLY COMENTS
% %     for ind = indiviual
% %         if(i < cutPoint)
% %             disp("i-> " + indiviual(1:3));
% %         end
% %        i = i + 1;
% %     end 
% 
% %     disp("size " + size(indiviual));
% %     disp("lengt " + length(indiviual));
% %     disp("numel " + numel(indiviual));
   
end